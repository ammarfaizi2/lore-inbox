Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbTIOOZS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbTIOOZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:25:17 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:20353 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S261413AbTIOOZK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:25:10 -0400
Date: Mon, 15 Sep 2003 16:25:06 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: "David S. Miller" <davem@redhat.com>
cc: mroos@linux.ee, <linux-kernel@vger.kernel.org>
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
In-Reply-To: <20030915011159.250f3346.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0309151623090.24675-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patch below fixes the Atyfb problems on the Sparc.

Greetings,

Daniël Mantione



diff -urN linux-2.4.22-bk18/drivers/video/aty/atyfb_base.c linux-2.4.22-bk18.fixed/drivers/video/aty/atyfb_base.c
--- linux-2.4.22-bk18/drivers/video/aty/atyfb_base.c	Mon Sep 15 16:10:41 2003
+++ linux-2.4.22-bk18.fixed/drivers/video/aty/atyfb_base.c	Mon Sep 15 13:55:25 2003
@@ -2481,6 +2479,8 @@
             info->frame_buffer = (unsigned long) addr + 0x800000UL;
             info->frame_buffer_phys = addr + 0x800000UL;

+            aty_init_register_array(info);
+
             /*
              * Figure mmap addresses from PCI config space.
              * Split Framebuffer in big- and little-endian halfs.
@@ -2671,6 +2671,7 @@

                 default_var.pixclock = 1000000000 / T;
             }
+
 #else /* __sparc__ */

             aux_app = 0;
diff -urN linux-2.4.22-bk18/drivers/video/aty/mach64_ct.c linux-2.4.22-bk18.fixed/drivers/video/aty/mach64_ct.c
--- linux-2.4.22-bk18/drivers/video/aty/mach64_ct.c	Mon Sep 15 16:10:41 2003
+++ linux-2.4.22-bk18.fixed/drivers/video/aty/mach64_ct.c	Sun Sep 14 11:35:37 2003
@@ -86,7 +86,7 @@

 u8 stdcall aty_ld_pll(int offset, const struct fb_info_aty *info)
 {
-    u32 addr;
+    unsigned long addr;

     addr = info->ati_regbase + CLOCK_CNTL + 1;
     /* write addr byte */
@@ -98,7 +98,7 @@

 static void stdcall aty_st_pll(int offset, u8 val, const struct fb_info_aty *info)
 {
-    u32 addr;
+    unsigned long addr;
     addr = info->ati_regbase + CLOCK_CNTL + 1;
     /* write addr byte */
     writeb((offset << 2) | PLL_WR_EN,addr);

