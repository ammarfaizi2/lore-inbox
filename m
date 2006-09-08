Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWIHW5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWIHW5k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWIHW5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:57:38 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:19083 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751238AbWIHWzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:55:14 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-Id: <20060908225513.9340.61761.sendpatchset@kaori.pdx.zabbo.net>
In-Reply-To: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
References: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
Subject: [PATCH 7/10] dell_rbu: fix pr_debug argument warnings
Date: Fri,  8 Sep 2006 15:55:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dell_rbu: fix pr_debug argument warnings

Use size_t length modifier when outputting size_t and use %p instead of %lu for
'u8 *'.

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 drivers/firmware/dell_rbu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6.18-rc6-debug-args/drivers/firmware/dell_rbu.c
===================================================================
--- 2.6.18-rc6-debug-args.orig/drivers/firmware/dell_rbu.c
+++ 2.6.18-rc6-debug-args/drivers/firmware/dell_rbu.c
@@ -227,7 +227,7 @@ static int packetize_data(void *data, si
 	int packet_length;
 	u8 *temp;
 	u8 *end = (u8 *) data + length;
-	pr_debug("packetize_data: data length %d\n", length);
+	pr_debug("packetize_data: data length %zd\n", length);
 	if (!rbu_data.packetsize) {
 		printk(KERN_WARNING
 			"dell_rbu: packetsize not specified\n");
@@ -249,7 +249,7 @@ static int packetize_data(void *data, si
 		if ((rc = create_packet(temp, packet_length)))
 			return rc;
 
-		pr_debug("%lu:%lu\n", temp, (end - temp));
+		pr_debug("%p:%lu\n", temp, (end - temp));
 		temp += packet_length;
 	}
 
