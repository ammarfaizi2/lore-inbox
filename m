Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSFJMSY>; Mon, 10 Jun 2002 08:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSFJMSX>; Mon, 10 Jun 2002 08:18:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:31238 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311885AbSFJMSW>; Mon, 10 Jun 2002 08:18:22 -0400
Message-ID: <3D048B4C.7080107@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:19:40 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 "I can't get no compilation"
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010403090902010905020906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010403090902010905020906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The subject says it all...

Contrary to other proposed patches I realized that there is
no such thing as vmalloc_dma.

--------------010403090902010905020906
Content-Type: text/plain;
 name="compile-2.5.21-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="compile-2.5.21-1.diff"

diff -urN linux-2.5.21/drivers/media/video/tda9875.c linux/drivers/media/video/tda9875.c
--- linux-2.5.21/drivers/media/video/tda9875.c	2002-06-09 07:29:29.000000000 +0200
+++ linux/drivers/media/video/tda9875.c	2002-06-09 19:24:06.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/videodev.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
+#include <linux/init.h>
 
 #include "bttv.h"
 #include "audiochip.h"
diff -urN linux-2.5.21/drivers/pnp/pnpbios_proc.c linux/drivers/pnp/pnpbios_proc.c
--- linux-2.5.21/drivers/pnp/pnpbios_proc.c	2002-06-09 07:31:26.000000000 +0200
+++ linux/drivers/pnp/pnpbios_proc.c	2002-06-09 17:57:42.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/pnpbios.h>
+#include <linux/init.h>
 
 static struct proc_dir_entry *proc_pnp = NULL;
 static struct proc_dir_entry *proc_pnp_boot = NULL;
diff -urN linux-2.5.21/include/linux/vmalloc.h linux/include/linux/vmalloc.h
--- linux-2.5.21/include/linux/vmalloc.h	2002-06-09 07:31:29.000000000 +0200
+++ linux/include/linux/vmalloc.h	2002-06-09 18:44:41.000000000 +0200
@@ -28,7 +28,6 @@
  */
 
 extern void * vmalloc(unsigned long size);
-extern void * vmalloc_dma(unsigned long size);
 extern void * vmalloc_32(unsigned long size);
 
 /*
diff -urN linux-2.5.21/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.5.21/kernel/ksyms.c	2002-06-09 07:26:33.000000000 +0200
+++ linux/kernel/ksyms.c	2002-06-09 18:43:30.000000000 +0200
@@ -108,6 +108,8 @@
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);
+EXPORT_SYMBOL(vmalloc);
+EXPORT_SYMBOL(vmalloc_32);
 EXPORT_SYMBOL(vmalloc_to_page);
 EXPORT_SYMBOL(mem_map);
 EXPORT_SYMBOL(remap_page_range);

--------------010403090902010905020906--

