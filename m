Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbUADAU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 19:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUADAU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 19:20:56 -0500
Received: from [193.138.115.2] ([193.138.115.2]:61967 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S264356AbUADAUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 19:20:54 -0500
Date: Sun, 4 Jan 2004 01:18:11 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [minor & trivial patch] kill some potential warnings about inline
 keyword placement - 2.6.1-rc1-mm1
In-Reply-To: <20040104000955.B11953@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.56.0401040115350.4664@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401040046450.4664@jju_lnx.backbone.dif.dk>
 <20040104000955.B11953@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Jan 2004, Russell King wrote:

> On Sun, Jan 04, 2004 at 01:01:26AM +0100, Jesper Juhl wrote:
> > --- linux-2.6.1-rc1-mm1-orig/include/linux/efi.h        2003-12-31 05:48:26.000000000 +0100
> > +++ linux-2.6.1-rc1-mm1/include/linux/efi.h     2004-01-04 00:29:48.000000000 +0100
> > @@ -297,8 +297,8 @@ extern u64 efi_mem_attributes (unsigned
> >  extern void efi_initialize_iomem_resources(struct resource *code_resource,
> >                                         struct resource *data_resource);
> >  extern efi_status_t phys_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
> > -extern unsigned long inline __init efi_get_time(void);
> > -extern int inline __init efi_set_rtc_mmss(unsigned long nowtime);
> > +inline extern unsigned long __init efi_get_time(void);
> > +inline extern int __init efi_set_rtc_mmss(unsigned long nowtime);
>
> For the sake of consistency, can we keep these the same as the rest
> of the kernel code please?  IOW:
>
> extern inline unsigned long __init efi_get_time(void);
>

Sure, I don't have a problem with that - good point, consistency is
important.

Here's the patch for efi.h again redone that way.

--- linux-2.6.1-rc1-mm1-orig/include/linux/efi.h        2003-12-31 05:48:26.000000000 +0100
+++ linux-2.6.1-rc1-mm1/include/linux/efi.h     2004-01-04 01:25:40.000000000 +0100
@@ -297,8 +297,8 @@ extern u64 efi_mem_attributes (unsigned
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
                                        struct resource *data_resource);
 extern efi_status_t phys_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
-extern unsigned long inline __init efi_get_time(void);
-extern int inline __init efi_set_rtc_mmss(unsigned long nowtime);
+extern inline unsigned long __init efi_get_time(void);
+extern inline int __init efi_set_rtc_mmss(unsigned long nowtime);
 extern struct efi_memory_map memmap;

 #ifdef CONFIG_EFI



/Jesper Juhl

