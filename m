Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTIGPOf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 11:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTIGPOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 11:14:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59073 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263322AbTIGPO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 11:14:29 -0400
Date: Sun, 7 Sep 2003 17:14:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Peter Daum <gator@cs.tu-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 with CONFIG_M686: networking broken
Message-ID: <20030907151422.GX14436@fs.tum.de>
References: <Pine.LNX.4.30.0309031227100.10173-100000@swamp.bayern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0309031227100.10173-100000@swamp.bayern.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 01:08:08PM +0200, Peter Daum wrote:

> Hi,

Hi Peter,

> It seems, like kernel version 2.4.22 introduced some weird bug,
> that causes all kinds of network malfunctions, when the kernel is
> compiled with "CONFIG_M686".
>...
> I tried lots of different options until I eventually found out,
> that the single setting that makes all the difference is the
> processor type: Independently of any other settings, all kernels
> with "CONFIG_M686" exhibit these problems; when I change this to
> "CONFIG_MPENTIUM4" and recompile, everything seems to work.

could you check whether the patch below fixes your problems?

> (By the way: the affected machines have "Pentium Pro" or "Pentium
> II" processors - is it safe to run a kernel compiled for "Pentium
> IV" on such boxes?)

No, it isn't safe.

> Regards,
>                  Peter Daum

cu
Adrian

--- linux-2.4.23-pre3-full/arch/i386/config.in.old	2003-09-07 17:10:31.000000000 +0200
+++ linux-2.4.23-pre3-full/arch/i386/config.in	2003-09-07 17:11:47.000000000 +0200
@@ -51,7 +51,7 @@
 if [ "$CONFIG_M386" = "y" ]; then
    define_bool CONFIG_X86_CMPXCHG n
    define_bool CONFIG_X86_XADD n
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
    define_bool CONFIG_X86_PPRO_FENCE y
@@ -67,21 +67,21 @@
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 fi
 if [ "$CONFIG_M486" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
 fi
 if [ "$CONFIG_M586" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
 fi
 if [ "$CONFIG_M586TSC" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_HAS_TSC y
@@ -89,7 +89,7 @@
    define_bool CONFIG_X86_F00F_WORKS_OK n
 fi
 if [ "$CONFIG_M586MMX" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_HAS_TSC y
@@ -98,7 +98,7 @@
    define_bool CONFIG_X86_F00F_WORKS_OK n
 fi
 if [ "$CONFIG_M686" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    bool 'PGE extensions (not for Cyrix/Transmeta)' CONFIG_X86_PGE
@@ -107,7 +107,7 @@
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
@@ -123,7 +123,7 @@
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -134,7 +134,7 @@
    define_bool CONFIG_MK7 y
 fi
 if [ "$CONFIG_MK7" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_3DNOW y
@@ -143,13 +143,13 @@
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 if [ "$CONFIG_MELAN" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 if [ "$CONFIG_MCYRIXIII" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_USE_3DNOW y
@@ -157,26 +157,26 @@
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 if [ "$CONFIG_MVIAC3_2" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 if [ "$CONFIG_MCRUSOE" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 if [ "$CONFIG_MWINCHIPC6" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 if [ "$CONFIG_MWINCHIP2" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -184,7 +184,7 @@
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 if [ "$CONFIG_MWINCHIP3D" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
