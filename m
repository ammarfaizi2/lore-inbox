Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUCITLN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbUCITKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:10:24 -0500
Received: from palrel12.hp.com ([156.153.255.237]:5839 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262106AbUCITHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:07:49 -0500
Date: Tue, 9 Mar 2004 11:07:46 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] (7/14) wrap function exports
Message-ID: <20040309190746.GH14543@bougret.hpl.hp.com>
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

ir264_irsyms_07_wrapper.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(7/14) wrap function exports   

Move async_wrap function exports out of irsyms



diff -u -p -r linux/net/irda.s6/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.s6/irsyms.c	Mon Mar  8 19:06:24 2004
+++ linux/net/irda/irsyms.c	Mon Mar  8 19:08:50 2004
@@ -97,8 +97,6 @@ EXPORT_SYMBOL(irda_task_execute);
 EXPORT_SYMBOL(irda_task_next_state);
 EXPORT_SYMBOL(irda_task_delete);
 
-EXPORT_SYMBOL(async_wrap_skb);
-EXPORT_SYMBOL(async_unwrap_char);
 EXPORT_SYMBOL(irda_calc_crc16);
 EXPORT_SYMBOL(irda_crc16_table);
 EXPORT_SYMBOL(irda_start_timer);
diff -u -p -r linux/net/irda.s6/wrapper.c linux/net/irda/wrapper.c
--- linux/net/irda.s6/wrapper.c	Wed Dec 17 18:59:16 2003
+++ linux/net/irda/wrapper.c	Mon Mar  8 19:08:50 2004
@@ -28,6 +28,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/string.h>
+#include <linux/module.h>
 #include <asm/byteorder.h>
 
 #include <net/irda/irda.h>
@@ -151,6 +152,7 @@ int async_wrap_skb(struct sk_buff *skb, 
 
 	return n;
 }
+EXPORT_SYMBOL(async_wrap_skb);
 
 /************************* FRAME UNWRAPPING *************************/
 /*
@@ -481,4 +483,5 @@ void async_unwrap_char(struct net_device
 		break;
 	}
 }
+EXPORT_SYMBOL(async_unwrap_char);
 
