Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318256AbSHDWkR>; Sun, 4 Aug 2002 18:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318259AbSHDWkR>; Sun, 4 Aug 2002 18:40:17 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:8954 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318256AbSHDWkQ>; Sun, 4 Aug 2002 18:40:16 -0400
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028493814.26332.9.camel@ldb>
References: <1028471237.1294.515.camel@ldb>  <20020804185952.GC1670@junk> 
	<1028492596.1293.535.camel@ldb> 
	<1028498075.15200.29.camel@irongate.swansea.linux.org.uk> 
	<1028493814.26332.9.camel@ldb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 01:02:12 +0100
Message-Id: <1028505732.15495.38.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-04 at 21:43, Luca Barbieri wrote:
> > When we use MMX/SSE we need the view to be consistent anyway so the
> > various copying routines already handle this internally. 
> That's why sfence is not used unless CONFIG_X86_OOSTORE (and
> CONFIG_X86_MMXEXT) is defined.
> mfence and lfence instead replace the "lock; addl $0,0(%%esp)". Is this
> wrong?

I'm trying to understand why you think they are needed at all. Except
for code that specifically does non-temporal we don't need fences on an
X86, and the code that uses non temporal stores has its own fences built
in.

So as far as I can see the only cases we ever have to care about are

PPro - processor bug
IDT Winchip - because we run it in oostore module not strict x86 mode

I don't see why you are generating extra fence instructions for other
cases

