Return-Path: <linux-kernel-owner+w=401wt.eu-S1751543AbWLLQZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWLLQZV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWLLQYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:24:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3402 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751517AbWLLQYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:24:25 -0500
Date: Tue, 12 Dec 2006 17:24:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/loopback.c: convert to module_init()
Message-ID: <20061212162435.GW28443@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts drivers/net/loopback.c to using module_init().

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/Space.c    |   11 -----------
 drivers/net/loopback.c |    4 +++-
 2 files changed, 3 insertions(+), 12 deletions(-)

--- linux-2.6.19-mm1/drivers/net/loopback.c.old	2006-12-12 15:59:02.000000000 +0100
+++ linux-2.6.19-mm1/drivers/net/loopback.c	2006-12-12 16:02:11.000000000 +0100
@@ -229,9 +229,11 @@
 };
 
 /* Setup and register the loopback device. */
-int __init loopback_init(void)
+static int __init loopback_init(void)
 {
 	return register_netdev(&loopback_dev);
 };
 
+module_init(loopback_init);
+
 EXPORT_SYMBOL(loopback_dev);
--- linux-2.6.19-mm1/drivers/net/Space.c.old	2006-12-12 15:59:11.000000000 +0100
+++ linux-2.6.19-mm1/drivers/net/Space.c	2006-12-12 16:01:35.000000000 +0100
@@ -345,22 +345,11 @@
 #endif
 
 
-/*
- *	The loopback device is global so it can be directly referenced
- *	by the network code. Also, it must be first on device list.
- */
-extern int loopback_init(void);
-
 /*  Statically configured drivers -- order matters here. */
 static int __init net_olddevs_init(void)
 {
 	int num;
 
-	if (loopback_init()) {
-		printk(KERN_ERR "Network loopback device setup failed\n");
-	}
-
-
 #ifdef CONFIG_SBNI
 	for (num = 0; num < 8; ++num)
 		sbni_probe(num);

