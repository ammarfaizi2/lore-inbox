Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318026AbSHHWWO>; Thu, 8 Aug 2002 18:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318071AbSHHWWN>; Thu, 8 Aug 2002 18:22:13 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:31476 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318026AbSHHWWM>; Thu, 8 Aug 2002 18:22:12 -0400
Subject: Re: [PATCH] [2.5] asm-generic/atomic.h and changes to arm, parisc,
	mips, m68k, sh, cris to use it
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028844681.1669.80.camel@ldb>
References: <Pine.LNX.4.44.0208082357170.8911-100000@serv> 
	<1028844681.1669.80.camel@ldb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 Aug 2002 00:45:50 +0100
Message-Id: <1028850350.28882.121.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 23:11, Luca Barbieri wrote:
> - Had inline assembly for things the compiler should be able to generate
> on its own

The compiler is free to generate them several other ways

> - Didn't work on SMP (irrelevant in practice, but we already need that
> in asm-generic/atomic.h for parisc so m68k gets it for free)

Doesn't matter

> The actual assembly generated should be the same and the header is
> shorter.

Possibly not - volatile doesnt guarantee the compiler won't do

	x = 1
	add *p into x
	store x into *p


The general idea looks fine, but you can't drop asm stuff for volatile C
and be sure you will get away with it. On M68K it works because the
instructions it forces are those guaranteed to be indivisible relative
to an interrupt. You lose that assumption.



