Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVAaRoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVAaRoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVAaRnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:43:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10508 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261287AbVAaRlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:41:07 -0500
Date: Mon, 31 Jan 2005 18:41:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/tty_io.c: remove console_use_vt
Message-ID: <20050131174105.GW18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The global variable console_use_vt never changed its' value.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/tty_io.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

--- linux-2.6.11-rc2-mm2-full/drivers/char/tty_io.c.old	2005-01-31 15:45:20.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/tty_io.c	2005-01-31 15:45:56.000000000 +0100
@@ -131,8 +131,6 @@
    vt.c for deeply disgusting hack reasons */
 DECLARE_MUTEX(tty_sem);
 
-int console_use_vt = 1;
-
 #ifdef CONFIG_UNIX98_PTYS
 extern struct tty_driver *ptm_driver;	/* Unix98 pty masters; for /dev/ptmx */
 extern int pty_limit;		/* Config limit on Unix98 ptys */
@@ -2962,19 +2960,17 @@
 #endif
 
 #ifdef CONFIG_VT
-	if (console_use_vt) {
-		cdev_init(&vc0_cdev, &console_fops);
-		if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
-		    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1,
-					   "/dev/vc/0") < 0)
-			panic("Couldn't register /dev/tty0 driver\n");
-		devfs_mk_cdev(MKDEV(TTY_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR,
-			      "vc/0");
-		class_simple_device_add(tty_class, MKDEV(TTY_MAJOR, 0), NULL,
-					"tty0");
+	cdev_init(&vc0_cdev, &console_fops);
+	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
+	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1,
+				   "/dev/vc/0") < 0)
+		panic("Couldn't register /dev/tty0 driver\n");
+	devfs_mk_cdev(MKDEV(TTY_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR,
+		      "vc/0");
+	class_simple_device_add(tty_class, MKDEV(TTY_MAJOR, 0), NULL,
+				"tty0");
 
-		vty_init();
-	}
+	vty_init();
 #endif
 	return 0;
 }

