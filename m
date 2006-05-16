Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWEPRoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWEPRoq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWEPRoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:44:39 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3336 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932323AbWEPRoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:44:08 -0400
Date: Tue, 16 May 2006 19:44:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/applicom.c: proper module_{init,exit}
Message-ID: <20060516174406.GG10077@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the driver to use module_{init,exit}.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: David Woodhouse <dwmw2@infradead.org>

---

 drivers/char/applicom.c |   40 ++++------------------------------------
 1 file changed, 4 insertions(+), 36 deletions(-)

--- linux-2.6.17-rc4-mm1-full/drivers/char/applicom.c.old	2006-05-16 13:58:41.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/drivers/char/applicom.c	2006-05-16 13:59:15.000000000 +0200
@@ -166,11 +166,7 @@
 	return boardno + 1;
 }
 
-#ifdef MODULE
-
-#define applicom_init init_module
-
-void cleanup_module(void)
+static void __exit applicom_exit(void)
 {
 	unsigned int i;
 
@@ -188,9 +184,7 @@
 	}
 }
 
-#endif				/* MODULE */
-
-int __init applicom_init(void)
+static int __init applicom_init(void)
 {
 	int i, numisa = 0;
 	struct pci_dev *dev = NULL;
@@ -358,10 +352,9 @@
 	return ret;
 }
 
+module_init(applicom_init);
+module_exit(applicom_exit);
 
-#ifndef MODULE
-__initcall(applicom_init);
-#endif
 
 static ssize_t ac_write(struct file *file, const char __user *buf, size_t count, loff_t * ppos)
 {
@@ -854,28 +847,3 @@
 	return 0;
 }
 
-#ifndef MODULE
-static int __init applicom_setup(char *str)
-{
-	int ints[4];
-
-	(void) get_options(str, 4, ints);
-
-	if (ints[0] > 2) {
-		printk(KERN_WARNING "Too many arguments to 'applicom=', expected mem,irq only.\n");
-	}
-
-	if (ints[0] < 2) {
-		printk(KERN_INFO"applicom numargs: %d\n", ints[0]);
-		return 0;
-	}
-
-	mem = ints[1];
-	irq = ints[2];
-	return 1;
-}
-
-__setup("applicom=", applicom_setup);
-
-#endif				/* MODULE */
-








































