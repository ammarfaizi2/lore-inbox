Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbUBYHgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 02:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbUBYHew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 02:34:52 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:3293 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262622AbUBYHeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 02:34:04 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: kgdb: rename i386-stub.c to kgdb.c
Date: Wed, 25 Feb 2004 13:03:50 +0530
User-Agent: KMail/1.5
References: <20040224130650.GA9012@elf.ucw.cz>
In-Reply-To: <20040224130650.GA9012@elf.ucw.cz>
Cc: KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402251303.50102.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 Feb 2004 6:36 pm, Pavel Machek wrote:
> Hi!
>
> kgdb uses really confusing names for arch-dependend parts. This fixes
> it. Okay to commit?

Why is arch/$x/kernel/$x-stub.c confusing? The name $x-stub.c is indicative of 
architecture dependent code in it. Err, well so is the path.

PPC and sparc stubs in present vanilla kernel use this naming convention. 
That's why I adopted it.

I find kernel/kgdbstub.c, arch/$x/kernel/$x-stub.c more consistent compared to 
kernel/kgdbstub.c, arch/$x/kernel/kgdb.c

-Amit

> 								Pavel
>
> ? big.diff
> ? big.patch
> ? patchit
> Index: core-lite.patch
> ===================================================================
> RCS file: /cvsroot/kgdb/kgdb-2/core-lite.patch,v
> retrieving revision 1.3
> diff -u -u -r1.3 core-lite.patch
> --- core-lite.patch	23 Feb 2004 21:48:55 -0000	1.3
> +++ core-lite.patch	24 Feb 2004 12:58:08 -0000
> @@ -209,8 +209,8 @@
>   	do_basic_setup();
>
>   	prepare_namespace();
> ---- clean.2.5/kernel/kgdbstub.c	2004-02-17 11:38:39.000000000 +0100
> -+++ linux-mm/kernel/kgdbstub.c	2004-02-22 21:49:11.000000000 +0100
> +--- clean.2.5/kernel/kgdb.c	2004-02-17 11:38:39.000000000 +0100
> ++++ linux-mm/kernel/kgdb.c	2004-02-22 21:49:11.000000000 +0100
>  @@ -0,0 +1,1268 @@
>  +/*
>  + * This program is free software; you can redistribute it and/or modify
> it @@ -1488,7 +1488,7 @@
>   obj-$(CONFIG_COMPAT) += compat.o
>   obj-$(CONFIG_IKCONFIG) += configs.o
>   obj-$(CONFIG_IKCONFIG_PROC) += configs.o
> -+obj-$(CONFIG_KGDB) += kgdbstub.o
> ++obj-$(CONFIG_KGDB) += kgdb.o
>
>   ifneq ($(CONFIG_IA64),y)
>   # According to Alan Modra <alan@linuxcare.com.au>, the
> -fno-omit-frame-pointer is Index: i386-lite.patch
> ===================================================================
> RCS file: /cvsroot/kgdb/kgdb-2/i386-lite.patch,v
> retrieving revision 1.2
> diff -u -u -r1.2 i386-lite.patch
> --- i386-lite.patch	23 Feb 2004 21:48:55 -0000	1.2
> +++ i386-lite.patch	24 Feb 2004 12:58:45 -0000
> @@ -23,8 +23,8 @@
>   config FRAME_POINTER
>   	bool "Compile the kernel with frame pointers"
>   	help
> ---- clean.2.5/arch/i386/kernel/i386-stub.c	2004-02-17 11:39:06.000000000
> +0100 -+++ linux-mm/arch/i386/kernel/i386-stub.c	2004-02-22
> 21:42:55.000000000 +0100 +--- clean.2.5/arch/i386/kernel/kgdb.c	2004-02-17
> 11:39:06.000000000 +0100 ++++ linux-mm/arch/i386/kernel/kgdb.c	2004-02-22
> 21:42:55.000000000 +0100 @@ -0,0 +1,373 @@
>  +/*
>  + *
> @@ -407,7 +407,7 @@
>   obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
>   obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
>   obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
> -+obj-$(CONFIG_KGDB)		+= i386-stub.o
> ++obj-$(CONFIG_KGDB)		+= kgdb.o
>
>   EXTRA_AFLAGS   := -traditional
>
> Index: x86_64.patch
> ===================================================================
> RCS file: /cvsroot/kgdb/kgdb-2/x86_64.patch,v
> retrieving revision 1.2
> diff -u -u -r1.2 x86_64.patch
> --- x86_64.patch	19 Feb 2004 08:52:25 -0000	1.2
> +++ x86_64.patch	24 Feb 2004 12:58:50 -0000
> @@ -119,7 +119,7 @@
>   obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
>
>   obj-$(CONFIG_MODULES)		+= module.o
> -+obj-$(CONFIG_KGDB)		+= x86_64-stub.o
> ++obj-$(CONFIG_KGDB)		+= kgdb.o
>
>   obj-y				+= topology.o
>
> @@ -208,10 +208,10 @@
>   	notify_die(DIE_DEBUG, "debug", regs, error_code, 1, SIGTRAP);
>   	return;
>
> -Index: linux-2.6.3-kgdb/arch/x86_64/kernel/x86_64-stub.c
> +Index: linux-2.6.3-kgdb/arch/x86_64/kernel/kgdb.c
>  ===================================================================
> ---- linux-2.6.3-kgdb.orig/arch/x86_64/kernel/x86_64-stub.c	2003-01-30
> 15:54:37.000000000 +0530 -+++
> linux-2.6.3-kgdb/arch/x86_64/kernel/x86_64-stub.c	2004-02-19
> 14:09:24.234743240 +0530 +---
> linux-2.6.3-kgdb.orig/arch/x86_64/kernel/kgdb.c	2003-01-30
> 15:54:37.000000000 +0530 ++++
> linux-2.6.3-kgdb/arch/x86_64/kernel/kgdb.c	2004-02-19 14:09:24.234743240
> +0530 @@ -0,0 +1,454 @@
>  +/*
>  + *

