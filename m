Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263070AbTCSPWN>; Wed, 19 Mar 2003 10:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263073AbTCSPWN>; Wed, 19 Mar 2003 10:22:13 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27602 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263070AbTCSPWL>; Wed, 19 Mar 2003 10:22:11 -0500
Date: Wed, 19 Mar 2003 16:33:04 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.65-mjb1: lkcd: EXTRA_TARGETS is obsolete
Message-ID: <20030319153304.GC23258@fs.tum.de>
References: <8230000.1047975763@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8230000.1047975763@[10.10.2.4]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 12:22:43AM -0800, Martin J. Bligh wrote:
>...
> lkcd						LKCD team
> 	Linux kernel crash dump support
>...

EXTRA_TARGETS is obsolete in 2.5.

The following should do the same:

--- linux-2.5.65-mjb1/init/Makefile.old	2003-03-19 08:30:22.000000000 +0100
+++ linux-2.5.65-mjb1/init/Makefile	2003-03-19 08:31:22.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the linux kernel.
 #
-ifdef CONFIG_CRASH_DUMP
-EXTRA_TARGETS := kerntypes.o
-CFLAGS_kerntypes.o := -gstabs
-endif
 
 obj-y				:= main.o version.o mounts.o initramfs.o
 mounts-y			:= do_mounts.o
@@ -12,6 +8,9 @@
 mounts-$(CONFIG_BLK_DEV_RAM)	+= do_mounts_rd.o
 mounts-$(CONFIG_BLK_DEV_MD)	+= do_mounts_md.o
 
+obj-$(CONFIG_CRASH_DUMP)	+= kerntypes.o
+CFLAGS_kerntypes.o		:= -gstabs
+
 # files to be removed upon make clean
 clean-files := ../include/linux/compile.h
 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

