Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751848AbWHUKoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWHUKoG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWHUKoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:44:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3591 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751848AbWHUKoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:44:05 -0400
Date: Mon, 21 Aug 2006 12:44:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6 patch] proper prototypes for some console functions
Message-ID: <20060821104405.GI11651@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds proper prototypes to header files for three console init 
functions used on drivers/char/vt.c

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/vt.c          |    8 --------
 include/linux/console.h    |    3 +++
 include/linux/consolemap.h |    1 +
 3 files changed, 4 insertions(+), 8 deletions(-)

--- linux-2.6.18-rc4-mm1/include/linux/consolemap.h.old	2006-08-14 00:30:56.000000000 +0200
+++ linux-2.6.18-rc4-mm1/include/linux/consolemap.h	2006-08-14 00:31:10.000000000 +0200
@@ -13,3 +13,4 @@
 extern unsigned char inverse_translate(struct vc_data *conp, int glyph);
 extern unsigned short *set_translate(int m, struct vc_data *vc);
 extern int conv_uni_to_pc(struct vc_data *conp, long ucs);
+void console_map_init(void);
--- linux-2.6.18-rc4-mm1/include/linux/console.h.old	2006-08-14 00:31:33.000000000 +0200
+++ linux-2.6.18-rc4-mm1/include/linux/console.h	2006-08-14 00:32:42.000000000 +0200
@@ -124,6 +124,9 @@
 extern void suspend_console(void);
 extern void resume_console(void);
 
+int mda_console_init(void);
+void prom_con_init(void);
+
 /* Some debug stub to catch some of the obvious races in the VT code */
 #if 1
 #define WARN_CONSOLE_UNLOCKED()	WARN_ON(!is_console_locked() && !oops_in_progress)
--- linux-2.6.18-rc4-mm1/drivers/char/vt.c.old	2006-08-14 00:29:47.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/char/vt.c	2006-08-14 00:30:01.000000000 +0200
@@ -139,14 +139,6 @@
 extern void vcs_make_sysfs(struct tty_struct *tty);
 extern void vcs_remove_sysfs(struct tty_struct *tty);
 
-extern void console_map_init(void);
-#ifdef CONFIG_PROM_CONSOLE
-extern void prom_con_init(void);
-#endif
-#ifdef CONFIG_MDA_CONSOLE
-extern int mda_console_init(void);
-#endif
-
 struct vc vc_cons [MAX_NR_CONSOLES];
 
 #ifndef VT_SINGLE_DRIVER

