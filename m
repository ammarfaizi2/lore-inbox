Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbSJKALf>; Thu, 10 Oct 2002 20:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262235AbSJKALW>; Thu, 10 Oct 2002 20:11:22 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:57048 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262227AbSJKAKJ>;
	Thu, 10 Oct 2002 20:10:09 -0400
Date: Thu, 10 Oct 2002 17:15:55 -0700
To: irda-users@lists.sourceforge.net, Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : ir251_export_crc-2.diff
Message-ID: <20021011001554.GD6645@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir251_export_crc-2.diff :
-----------------------
	o [FEATURE] Export CRC16 helper so that drivers can use it



diff -u -p linux/include/net/irda/crc.d3.h linux/include/net/irda/crc.h
--- linux/include/net/irda/crc.d3.h	Thu Oct 10 14:08:55 2002
+++ linux/include/net/irda/crc.h	Thu Oct 10 14:09:36 2002
@@ -28,6 +28,6 @@ static inline __u16 irda_fcs(__u16 fcs, 
 }
 
 /* Recompute the FCS with len bytes appended. */
-unsigned short crc_calc( __u16 fcs, __u8 const *buf, size_t len);
+unsigned short irda_calc_crc16( __u16 fcs, __u8 const *buf, size_t len);
 
 #endif
diff -u -p linux/net/irda/crc.d3.c linux/net/irda/crc.c
--- linux/net/irda/crc.d3.c	Thu Oct 10 14:09:09 2002
+++ linux/net/irda/crc.c	Thu Oct 10 14:09:36 2002
@@ -57,7 +57,7 @@ __u16 const irda_crc16_table[256] =
 	0x7bc7, 0x6a4e, 0x58d5, 0x495c, 0x3de3, 0x2c6a, 0x1ef1, 0x0f78
 };
 
-unsigned short crc_calc( __u16 fcs, __u8 const *buf, size_t len) 
+unsigned short irda_calc_crc16( __u16 fcs, __u8 const *buf, size_t len) 
 {
 	while (len--)
                 fcs = irda_fcs(fcs, *buf++);
diff -u -p linux/net/irda/irsyms.d3.c linux/net/irda/irsyms.c
--- linux/net/irda/irsyms.d3.c	Thu Oct 10 14:09:20 2002
+++ linux/net/irda/irsyms.c	Thu Oct 10 14:09:36 2002
@@ -42,6 +42,7 @@
 #include <net/irda/wrapper.h>
 #include <net/irda/timer.h>
 #include <net/irda/parameters.h>
+#include <net/irda/crc.h>
 
 extern struct proc_dir_entry *proc_irda;
 
@@ -163,6 +164,7 @@ EXPORT_SYMBOL(irda_task_delete);
 
 EXPORT_SYMBOL(async_wrap_skb);
 EXPORT_SYMBOL(async_unwrap_char);
+EXPORT_SYMBOL(irda_calc_crc16);
 EXPORT_SYMBOL(irda_start_timer);
 EXPORT_SYMBOL(setup_dma);
 EXPORT_SYMBOL(infrared_mode);
