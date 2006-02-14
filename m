Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161083AbWBNPWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbWBNPWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWBNPWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:22:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14340 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161080AbWBNPWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:22:20 -0500
Date: Tue, 14 Feb 2006 16:22:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: [2.6 patch] make INPUT a bool
Message-ID: <20060214152218.GI10701@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make INPUT a bool.

INPUT!=y is only possible if EMBEDDED=y, and in such cases it doesn't 
make that much sense to make it modular.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 3 Feb 2006

 drivers/input/Kconfig |    2 +-
 drivers/input/input.c |    8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

--- linux-2.6.16-rc1-mm5-full/drivers/input/Kconfig.old	2006-02-03 22:42:18.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/drivers/input/Kconfig	2006-02-03 22:42:29.000000000 +0100
@@ -5,7 +5,7 @@
 menu "Input device support"
 
 config INPUT
-	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
+	bool "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
 	default y
 	---help---
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
--- linux-2.6.16-rc1-mm5-full/drivers/input/input.c.old	2006-02-03 22:42:41.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/drivers/input/input.c	2006-02-03 22:47:44.000000000 +0100
@@ -984,12 +984,4 @@
 	return err;
 }
 
-static void __exit input_exit(void)
-{
-	input_proc_exit();
-	unregister_chrdev(INPUT_MAJOR, "input");
-	class_unregister(&input_class);
-}
-
 subsys_initcall(input_init);
-module_exit(input_exit);

