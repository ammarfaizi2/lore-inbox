Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264489AbTFQBxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 21:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTFQBwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 21:52:55 -0400
Received: from palrel12.hp.com ([156.153.255.237]:8900 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264531AbTFQBwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 21:52:21 -0400
Date: Mon, 16 Jun 2003 19:06:14 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] Export CRC routine to drivers
Message-ID: <20030617020614.GE30944@bougret.hpl.hp.com>
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

ir241_export_crc-3.diff :
	o [FEATURE] Export CRC16 helper so that drivers can use it


diff -u -p linux/include/net/irda/crc.d3.h linux/include/net/irda/crc.h
--- linux/include/net/irda/crc.d3.h	Mon Dec  2 16:02:41 2002
+++ linux/include/net/irda/crc.h	Mon Dec  2 16:03:58 2002
@@ -28,6 +28,6 @@ static inline __u16 irda_fcs(__u16 fcs, 
 }
 
 /* Recompute the FCS with len bytes appended. */
-unsigned short crc_calc( __u16 fcs, __u8 const *buf, size_t len);
+unsigned short irda_calc_crc16( __u16 fcs, __u8 const *buf, size_t len);
 
 #endif
diff -u -p linux/net/irda/crc.d3.c linux/net/irda/crc.c
--- linux/net/irda/crc.d3.c	Mon Dec  2 16:02:53 2002
+++ linux/net/irda/crc.c	Mon Dec  2 16:03:58 2002
@@ -57,7 +57,7 @@ __u16 const irda_crc16_table[256] =
 	0x7bc7, 0x6a4e, 0x58d5, 0x495c, 0x3de3, 0x2c6a, 0x1ef1, 0x0f78
 };
 
-unsigned short crc_calc( __u16 fcs, __u8 const *buf, size_t len) 
+unsigned short irda_calc_crc16( __u16 fcs, __u8 const *buf, size_t len) 
 {
 	while (len--)
                 fcs = irda_fcs(fcs, *buf++);
diff -u -p linux/net/irda/irsyms.d3.c linux/net/irda/irsyms.c
--- linux/net/irda/irsyms.d3.c	Mon Dec  2 16:03:22 2002
+++ linux/net/irda/irsyms.c	Mon Dec  2 16:04:38 2002
@@ -44,6 +44,7 @@
 #include <net/irda/wrapper.h>
 #include <net/irda/timer.h>
 #include <net/irda/parameters.h>
+#include <net/irda/crc.h>
 
 extern struct proc_dir_entry *proc_irda;
 
@@ -158,6 +159,8 @@ EXPORT_SYMBOL(irda_task_delete);
 
 EXPORT_SYMBOL(async_wrap_skb);
 EXPORT_SYMBOL(async_unwrap_char);
+EXPORT_SYMBOL(irda_calc_crc16);
+EXPORT_SYMBOL(irda_crc16_table);
 EXPORT_SYMBOL(irda_start_timer);
 EXPORT_SYMBOL(setup_dma);
 EXPORT_SYMBOL(infrared_mode);
