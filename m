Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbUDRWXW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 18:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264200AbUDRWXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 18:23:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14355 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264196AbUDRWXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 18:23:17 -0400
Date: Sun, 18 Apr 2004 23:23:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] Clean up asm/pgalloc.h include
Message-ID: <20040418232314.A2045@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20040418231720.C12222@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040418231720.C12222@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:17:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
drivers/ subtree.  drivers/char/mem.c has been compile tested;
the others have not, since they are for non-x86 and non-ARM
architectures.

This patch is part of a larger patch aiming towards getting the
include of asm/pgtable.h out of linux/mm.h, so that asm/pgtable.h
can sanely get at things like mm_struct and friends.

I suggest testing in -mm for a while to ensure there aren't any
hidden arch issues.

 drivers/char/mem.c                  |    1 -
 drivers/net/82596.c                 |    1 -
 drivers/net/lasi_82596.c            |    1 -
 drivers/net/macsonic.c              |    1 -
 drivers/net/sun3lance.c             |    1 -
 drivers/parisc/ccio-dma.c           |    1 -
 drivers/parisc/ccio-rm-dma.c        |    1 -
 drivers/video/console/sticore.c     |    1 -
 sound/oss/dmasound/dmasound_atari.c |    1 -
 9 files changed, 9 deletions(-)

--- orig/drivers/char/mem.c	Thu Apr  1 19:33:15 2004
+++ linux/drivers/char/mem.c	Sun Apr 18 17:44:40 2004
@@ -26,7 +26,6 @@
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
-#include <asm/pgalloc.h>
 
 #ifdef CONFIG_IA64
 # include <linux/efi.h>
--- orig/drivers/net/82596.c	Sat Mar 20 09:22:30 2004
+++ linux/drivers/net/82596.c	Sun Apr 18 23:11:16 2004
@@ -58,7 +58,6 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 
 static char version[] __initdata =
 	"82596.c $Revision: 1.5 $\n";
--- orig/drivers/net/lasi_82596.c	Sat Mar 20 09:22:33 2004
+++ linux/drivers/net/lasi_82596.c	Sun Apr 18 23:11:27 2004
@@ -87,7 +87,6 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/irq.h>
 #include <asm/pdc.h>
 #include <asm/cache.h>
--- orig/drivers/net/macsonic.c	Wed Feb 18 22:34:13 2004
+++ linux/drivers/net/macsonic.c	Sun Apr 18 23:11:39 2004
@@ -53,7 +53,6 @@
 #include <asm/macintosh.h>
 #include <asm/macints.h>
 #include <asm/mac_via.h>
-#include <asm/pgalloc.h>
 
 #define SREGS_PAD(n)    u16 n;
 
--- orig/drivers/net/sun3lance.c	Fri Mar 19 11:56:02 2004
+++ linux/drivers/net/sun3lance.c	Sun Apr 18 23:11:50 2004
@@ -42,7 +42,6 @@ static char *version = "sun3lance.c: v1.
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/dvma.h>
 #include <asm/idprom.h>
 #include <asm/machines.h>
--- orig/drivers/parisc/ccio-dma.c	Fri Mar 19 11:56:11 2004
+++ linux/drivers/parisc/ccio-dma.c	Sun Apr 18 23:12:29 2004
@@ -44,7 +44,6 @@
 #include <asm/byteorder.h>
 #include <asm/cache.h>		/* for L1_CACHE_BYTES */
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/page.h>
 #include <asm/dma.h>
 #include <asm/io.h>
--- orig/drivers/parisc/ccio-rm-dma.c	Fri Mar 19 11:56:11 2004
+++ linux/drivers/parisc/ccio-rm-dma.c	Sun Apr 18 23:12:39 2004
@@ -40,7 +40,6 @@
 #include <linux/pci.h>
 
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 
 #include <asm/io.h>
 #include <asm/hardware.h>
--- orig/drivers/video/console/sticore.c	Wed Feb 18 22:34:50 2004
+++ linux/drivers/video/console/sticore.c	Sun Apr 18 23:12:50 2004
@@ -22,7 +22,6 @@
 #include <linux/pci.h>
 #include <linux/font.h>
 
-#include <asm/pgalloc.h>
 #include <asm/hardware.h>
 #include <asm/parisc-device.h>
 #include <asm/cacheflush.h>
--- orig/sound/oss/dmasound/dmasound_atari.c	Mon Sep  8 23:38:50 2003
+++ linux/sound/oss/dmasound/dmasound_atari.c	Sun Apr 18 23:14:09 2004
@@ -22,7 +22,6 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 
-#include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/atariints.h>
 #include <asm/atari_stram.h>


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
