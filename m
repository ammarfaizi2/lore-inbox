Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSJWLEt>; Wed, 23 Oct 2002 07:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263293AbSJWLEt>; Wed, 23 Oct 2002 07:04:49 -0400
Received: from gateway.cinet.co.jp ([210.166.75.129]:52290 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262812AbSJWLEr>; Wed, 23 Oct 2002 07:04:47 -0400
Message-ID: <3DB5706A.9D3915F0@cinet.co.jp>
Date: Wed, 23 Oct 2002 00:36:10 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.44-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Andrey Panin <pazke@orbita1.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCHSET] PC-9800 architecture (CORE only)
References: <20021022065028.GA304@pazke.ipt>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for comment.

Andrey Panin wrote:
> 
> On Mon, Oct 21, 2002 at 10:49:19PM +0900, Osamu Tomita wrote:
> > This is a part of big patchset for support PC-9800 architecture, one
> of i386
> > sub architectures.
> > Core part cleanup has done. (But device drivers are still working.)
> > Many "#if" are killed by using "mach-xxx" framework.
> > If someone pick up this, we are very happy.
> > Comments are always welcome. Please tell me.
> 
> Ok, you asked for it :))
> 
> >       if (boot_cpu_data.hard_math && !cpu_has_fpu)
> > -             setup_irq(13, &irq13);
> > +#ifndef CONFIG_PC9800
> > +             setup_irq(13, &fpu_irq);
> > +#else
> > +             setup_irq(8, &fpu_irq);
> > +#endif
> >  }
> 
> May be this should be done this way (with FPU_IRQ_NUMBER hidden in the
> arch specific header):
> 
> -               setup_irq(13, &irq13);
> +               setup_irq(FPU_IRQ_NUMBER, &fpu_irq);
Thanks. I'll rewrite this way.
 
> > diff -urN linux/arch/i386/kernel/pc9800_debug.c
> linux98/arch/i386/kernel/pc9800_debug.c
> 
> Why this file is not in mach-pc9800 directory ?
This module provides new feature.
We can write debugging messages to PC-9800's NVRAM.
I don't know PC's CMOS can be used for this purpose, or not.
But, if other subarchtecture has usable space in NVRAM,
I assume scenario as follows.
rewrite some codes in pc9800_debug.c and put them mach-xxx directory,
then split out codes for PC-9800 and move them into mach-pc9800 direcory.

> And what is IORESOURCE98_SPARSE flag in mach-pc9800/mach_resources.h
> file ?
IORESOURCE98_SPARSE flag means odd or even only addressing.
We modify check_region(), request_region() and release_region().
If length parameter has negative value, addressing is sparse.
For example,
 request_region(0x100, -5, "xxx"); gets 0x100, 0x102 and 0x104.

Regards
Osamu Tomita  tomita@cinet.co.jp
