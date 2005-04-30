Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVD3UOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVD3UOr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 16:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVD3UOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 16:14:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9999 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261408AbVD3UI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 16:08:29 -0400
Date: Sat, 30 Apr 2005 22:08:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/tty_io.c: make a function static
Message-ID: <20050430200827.GT3571@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 17 Apr 2005

 drivers/char/tty_io.c |    5 +++--
 include/linux/tty.h   |    2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc2-mm3-full/include/linux/tty.h.old	2005-04-17 18:30:17.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/include/linux/tty.h	2005-04-17 18:30:24.000000000 +0200
@@ -337,8 +337,6 @@
 extern void console_init(void);
 extern int vcs_init(void);
 
-extern int tty_paranoia_check(struct tty_struct *tty, struct inode *inode,
-			      const char *routine);
 extern char *tty_name(struct tty_struct *tty, char *buf);
 extern void tty_wait_until_sent(struct tty_struct * tty, long timeout);
 extern int tty_check_change(struct tty_struct * tty);
--- linux-2.6.12-rc2-mm3-full/drivers/char/tty_io.c.old	2005-04-17 18:30:32.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/tty_io.c	2005-04-17 18:30:51.000000000 +0200
@@ -186,8 +186,9 @@
 
 EXPORT_SYMBOL(tty_name);
 
-inline int tty_paranoia_check(struct tty_struct *tty, struct inode *inode,
-			      const char *routine)
+static inline int tty_paranoia_check(struct tty_struct *tty,
+				     struct inode *inode,
+				     const char *routine)
 {
 #ifdef TTY_PARANOIA_CHECK
 	if (!tty) {

