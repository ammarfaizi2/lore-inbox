Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbUKUPn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUKUPn5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 10:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbUKUPnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:43:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60424 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261326AbUKUPgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:36:49 -0500
Date: Sun, 21 Nov 2004 16:36:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ghozlane Toumi <gtoumi@laposte.net>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6 patch] sstfb.c: make some code static
Message-ID: <20041121153646.GA2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 drivers/video/sstfb.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/sstfb.c.old	2004-11-21 14:59:23.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/sstfb.c	2004-11-21 16:02:43.000000000 +0100
@@ -1338,8 +1338,8 @@
 /*
  * Interface to the world
  */
-
-int  __init sstfb_setup(char *options)
+#ifndef MODULE
+static int  __init sstfb_setup(char *options)
 {
 	char *this_opt;
 
@@ -1372,6 +1372,7 @@
 	}
 	return 0;
 }
+#endif
 
 static struct fb_ops sstfb_ops = {
 	.owner		= THIS_MODULE,
@@ -1565,7 +1566,7 @@
 };
 
 
-int __devinit sstfb_init(void)
+static int __devinit sstfb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -1577,10 +1578,12 @@
 	return pci_module_init(&sstfb_driver);
 }
 
-void __devexit sstfb_exit(void)
+#ifdef MODULE
+static void __devexit sstfb_exit(void)
 {
 	pci_unregister_driver(&sstfb_driver);
 }
+#endif
 
 
 /*
