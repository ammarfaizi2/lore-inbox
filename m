Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030590AbWJCWFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbWJCWFd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030593AbWJCWFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:05:33 -0400
Received: from av4.karneval.cz ([81.27.192.11]:54034 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1030590AbWJCWF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:05:29 -0400
Message-id: <123432033123@karneval.cz>
Subject: [PATCH 3/6] Char: mxser_new, debug printk dependent on DEBUG
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Date: Wed,  4 Oct 2006 00:05:27 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, debug printk dependent on DEBUG

Print some debug info only when DEBUG is enabled (use pr_debug macro).
Eliminate verbose kernel parameter which takes care of this.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 356ef1dec5ac5b5c73636117691c5cc6bcd64a07
tree a9dff69ee2238c0936a1424ac767778c890a1b9b
parent 1f480651fc90540603834743c1d3a598b2a0c722
author Jiri Slaby <jirislaby@gmail.com> Tue, 03 Oct 2006 22:57:17 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Tue, 03 Oct 2006 22:57:17 +0200

 drivers/char/mxser_new.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 029b7e4..3c1a21f 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -244,7 +244,6 @@ MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
 static int ioaddr[MXSER_BOARDS] = { 0, 0, 0, 0 };
 static int ttymajor = MXSERMAJOR;
 static int calloutmajor = MXSERCUMAJOR;
-static int verbose = 0;
 
 /* Variables for insmod */
 
@@ -252,7 +251,6 @@ MODULE_AUTHOR("Casper Yang");
 MODULE_DESCRIPTION("MOXA Smartio/Industio Family Multiport Board Device Driver");
 module_param_array(ioaddr, int, NULL, 0);
 module_param(ttymajor, int, 0);
-module_param(verbose, bool, 0);
 MODULE_LICENSE("GPL");
 
 struct mxser_log {
@@ -493,11 +491,9 @@ static int __init mxser_module_init(void
 {
 	int ret;
 
-	if (verbose)
-		printk(KERN_DEBUG "Loading module mxser ...\n");
+	pr_debug("Loading module mxser ...\n");
 	ret = mxser_init();
-	if (verbose)
-		printk(KERN_DEBUG "Done.\n");
+	pr_debug("Done.\n");
 	return ret;
 }
 
@@ -505,8 +501,7 @@ static void __exit mxser_module_exit(voi
 {
 	int i, err;
 
-	if (verbose)
-		printk(KERN_DEBUG "Unloading module mxser ...\n");
+	pr_debug("Unloading module mxser ...\n");
 
 	err = tty_unregister_driver(mxvar_sdriver);
 	if (!err)
@@ -532,8 +527,7 @@ static void __exit mxser_module_exit(voi
 			}
 		}
 	}
-	if (verbose)
-		printk(KERN_DEBUG "Done.\n");
+	pr_debug("Done.\n");
 }
 
 static void process_txrx_fifo(struct mxser_port *info)
@@ -562,10 +556,7 @@ static int __devinit mxser_initbrd(struc
 	unsigned int i;
 	int retval;
 
-	/*if (verbose) */  {
-		printk(" max. baud rate = %d bps.\n",
-			brd->ports[0].max_baud);
-	}
+	printk(KERN_INFO "max. baud rate = %d bps.\n", brd->ports[0].max_baud);
 
 	for (i = 0; i < brd->nports; i++) {
 		info = &brd->ports[i];
