Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWGBXel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWGBXel (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWGBXel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:34:41 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:17624 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750730AbWGBXek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:34:40 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 01:34:28 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 18a/19 2.6.17-mm5] ieee1394: fix kerneldoc of hpsb_alloc_host
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.40a2db179a3d955f@s5r6.in-berlin.de>
Message-ID: <tkrat.71b5521af3b5f550@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
 <tkrat.40a2db179a3d955f@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.908) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was stuff between the comment and the function.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
This is the version with additional fuzz by -mm's lock validator.
Just FYI.

Index: linux-2.6.17-mm5/drivers/ieee1394/hosts.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/ieee1394/hosts.c	2006-07-01 20:30:01.000000000 +0200
+++ linux-2.6.17-mm5/drivers/ieee1394/hosts.c	2006-07-02 13:55:48.000000000 +0200
@@ -90,6 +90,16 @@ static int alloc_hostnum_cb(struct hpsb_
 	return 0;
 }
 
+/*
+ * The pending_packet_queue is special in that it's processed
+ * from hardirq context too (such as hpsb_bus_reset()). Hence
+ * split the lock class from the usual networking skb-head
+ * lock class by using a separate key for it:
+ */
+static struct lock_class_key pending_packet_queue_key;
+
+static DEFINE_MUTEX(host_num_alloc);
+
 /**
  * hpsb_alloc_host - allocate a new host controller.
  * @drv: the driver that will manage the host controller
@@ -105,16 +115,6 @@ static int alloc_hostnum_cb(struct hpsb_
  * Return Value: a pointer to the &hpsb_host if successful, %NULL if
  * no memory was available.
  */
-static DEFINE_MUTEX(host_num_alloc);
-
-/*
- * The pending_packet_queue is special in that it's processed
- * from hardirq context too (such as hpsb_bus_reset()). Hence
- * split the lock class from the usual networking skb-head
- * lock class by using a separate key for it:
- */
-static struct lock_class_key pending_packet_queue_key;
-
 struct hpsb_host *hpsb_alloc_host(struct hpsb_host_driver *drv, size_t extra,
 				  struct device *dev)
 {


