Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVBFXfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVBFXfG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 18:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVBFXdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 18:33:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29202 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261325AbVBFXdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 18:33:12 -0500
Date: Mon, 7 Feb 2005 00:33:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jani Monoses <jani@iv.ro>, Antonino Daplas <adaplas@pol.net>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6 patch] tridentfb.c: make some code static
Message-ID: <20050206233309.GH3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/tridentfb.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

This patch was already sent on:
- 21 Nov 2004

--- linux-2.6.10-rc2-mm2-full/drivers/video/tridentfb.c.old	2004-11-21 15:01:33.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/tridentfb.c	2004-11-21 15:03:19.000000000 +0100
@@ -31,7 +31,7 @@
 	void __iomem * io_virt;	//iospace virtual memory address
 };
 
-unsigned char eng_oper;		//engine operation...
+static unsigned char eng_oper;		//engine operation...
 static struct fb_ops tridentfb_ops;
 
 static struct tridentfb_par default_par;
@@ -91,7 +91,7 @@
 static int chip3D;
 static int chipcyber;
 
-int is3Dchip(int id)
+static int is3Dchip(int id)
 {
 	return 	((id == BLADE3D) || (id == CYBERBLADEE4) ||
 		 (id == CYBERBLADEi7) || (id == CYBERBLADEi7D) ||
@@ -104,7 +104,7 @@
 		 (id ==	CYBERBLADEXPAi1));
 }
 
-int iscyber(int id)
+static int iscyber(int id)
 {
 	switch (id) {
 		case CYBER9388:		
@@ -1223,9 +1223,9 @@
 	.remove		= __devexit_p(trident_pci_remove)
 };
 
-int tridentfb_setup(char *options);
+static int tridentfb_setup(char *options);
 
-int __init tridentfb_init(void)
+static int __init tridentfb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -1238,7 +1238,7 @@
 	return pci_module_init(&tridentfb_pci_driver);
 }
 
-void __exit tridentfb_exit(void)
+static void __exit tridentfb_exit(void)
 {
 	pci_unregister_driver(&tridentfb_pci_driver);
 }
@@ -1249,7 +1249,8 @@
  * example:
  * 	video=trident:800x600,bpp=16,noaccel
  */
-int tridentfb_setup(char *options)
+#ifndef MODULE
+static int tridentfb_setup(char *options)
 {
 	char * opt;
 	if (!options || !*options)
@@ -1279,6 +1280,7 @@
 	}
 	return 0;
 }
+#endif
 
 static struct fb_ops tridentfb_ops = {
 	.owner	= THIS_MODULE,

