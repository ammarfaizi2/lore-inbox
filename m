Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUCITSe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbUCITRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:17:49 -0500
Received: from palrel10.hp.com ([156.153.255.245]:1471 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262107AbUCITIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:08:24 -0500
Date: Tue, 9 Mar 2004 11:08:23 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] (8/14) crc16 symbol exports
Message-ID: <20040309190823.GI14543@bougret.hpl.hp.com>
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

ir264_irsyms_08_crc.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(8/14) crc16 symbol exports   

Move crc16 exports out of irsyms. Make type __u16 rather than
unsigned short to match input parameter.



diff -u -p -r linux/include/net/irda.s7/crc.h linux/include/net/irda/crc.h
--- linux/include/net/irda.s7/crc.h	Wed Dec 17 18:58:38 2003
+++ linux/include/net/irda/crc.h	Mon Mar  8 19:10:29 2004
@@ -28,6 +28,6 @@ static inline __u16 irda_fcs(__u16 fcs, 
 }
 
 /* Recompute the FCS with len bytes appended. */
-unsigned short irda_calc_crc16( __u16 fcs, __u8 const *buf, size_t len);
+__u16 irda_calc_crc16( __u16 fcs, __u8 const *buf, size_t len);
 
 #endif
diff -u -p -r linux/net/irda.s7/crc.c linux/net/irda/crc.c
--- linux/net/irda.s7/crc.c	Wed Dec 17 18:58:41 2003
+++ linux/net/irda/crc.c	Mon Mar  8 19:10:29 2004
@@ -14,6 +14,7 @@
  ********************************************************************/
 
 #include <net/irda/crc.h>
+#include <linux/module.h>
 
 /*
  * This mysterious table is just the CRC of each possible byte.  It can be
@@ -56,10 +57,12 @@ __u16 const irda_crc16_table[256] =
 	0xf78f, 0xe606, 0xd49d, 0xc514, 0xb1ab, 0xa022, 0x92b9, 0x8330,
 	0x7bc7, 0x6a4e, 0x58d5, 0x495c, 0x3de3, 0x2c6a, 0x1ef1, 0x0f78
 };
+EXPORT_SYMBOL(irda_crc16_table);
 
-unsigned short irda_calc_crc16( __u16 fcs, __u8 const *buf, size_t len) 
+__u16 irda_calc_crc16( __u16 fcs, __u8 const *buf, size_t len) 
 {
 	while (len--)
                 fcs = irda_fcs(fcs, *buf++);
 	return fcs;
 }
+EXPORT_SYMBOL(irda_calc_crc16);
diff -u -p -r linux/net/irda.s7/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.s7/irsyms.c	Mon Mar  8 19:08:50 2004
+++ linux/net/irda/irsyms.c	Mon Mar  8 19:10:29 2004
@@ -97,8 +97,6 @@ EXPORT_SYMBOL(irda_task_execute);
 EXPORT_SYMBOL(irda_task_next_state);
 EXPORT_SYMBOL(irda_task_delete);
 
-EXPORT_SYMBOL(irda_calc_crc16);
-EXPORT_SYMBOL(irda_crc16_table);
 EXPORT_SYMBOL(irda_start_timer);
 
 #ifdef CONFIG_IRDA_DEBUG
