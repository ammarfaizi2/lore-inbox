Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318044AbSHHXCO>; Thu, 8 Aug 2002 19:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318045AbSHHXCO>; Thu, 8 Aug 2002 19:02:14 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:25875 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318044AbSHHXCN>; Thu, 8 Aug 2002 19:02:13 -0400
Date: Fri, 9 Aug 2002 01:04:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Luca Barbieri <ldb@ldb.ods.org>
cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] [2.5] asm-generic/atomic.h and changes to arm, parisc,
 mips, m68k, sh, cris to use it
In-Reply-To: <1028846417.1669.95.camel@ldb>
Message-ID: <Pine.LNX.4.44.0208090100100.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9 Aug 2002, Luca Barbieri wrote:

> > The compiler can cache the value in a register
> It shouldn't since it is volatile and the machine has instructions with
> memory operands.

volatile is no guarantee for that:

volatile int x;

void f(int y)
{
        x += y;
}

becomes:

	move.l x,%d0
	add.l 8(%a6),%d0
	move.l %d0,x

I agree that volatile should avoid caching, but it does not guarantee an
atomic modify.

bye, Roman

