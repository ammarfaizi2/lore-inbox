Return-Path: <linux-kernel-owner+w=401wt.eu-S1752733AbWLRDqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbWLRDqs (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 22:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbWLRDqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 22:46:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4288 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752721AbWLRDqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 22:46:34 -0500
Date: Mon, 18 Dec 2006 04:46:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/vc_screen.c: proper prototypes
Message-ID: <20061218034634.GB10316@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds proper prototypes for two functions in 
drivers/char/vc_screen.c

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/vt.c       |    3 ---
 include/linux/console.h |    4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.20-rc1-mm1/include/linux/console.h.old	2006-12-18 03:16:32.000000000 +0100
+++ linux-2.6.20-rc1-mm1/include/linux/console.h	2006-12-18 03:26:43.000000000 +0100
@@ -21,6 +21,7 @@
 struct console_font_op;
 struct console_font;
 struct module;
+struct tty_struct;
 
 /*
  * this is what the terminal answers to a ESC-Z or csi0c query.
@@ -132,6 +133,9 @@
 int mda_console_init(void);
 void prom_con_init(void);
 
+void vcs_make_sysfs(struct tty_struct *tty);
+void vcs_remove_sysfs(struct tty_struct *tty);
+
 /* Some debug stub to catch some of the obvious races in the VT code */
 #if 1
 #define WARN_CONSOLE_UNLOCKED()	WARN_ON(!is_console_locked() && !oops_in_progress)
--- linux-2.6.20-rc1-mm1/drivers/char/vt.c.old	2006-12-18 03:18:11.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/char/vt.c	2006-12-18 03:18:22.000000000 +0100
@@ -136,9 +136,6 @@
 #define DEFAULT_BELL_PITCH	750
 #define DEFAULT_BELL_DURATION	(HZ/8)
 
-extern void vcs_make_sysfs(struct tty_struct *tty);
-extern void vcs_remove_sysfs(struct tty_struct *tty);
-
 struct vc vc_cons [MAX_NR_CONSOLES];
 
 #ifndef VT_SINGLE_DRIVER

