Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422992AbWJSOKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422992AbWJSOKZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423007AbWJSOKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:10:25 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:30140 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1422992AbWJSOKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:10:24 -0400
Date: Thu, 19 Oct 2006 16:10:10 +0200
Message-id: <3160912811766612133@muni.cz>
Subject: [PATCH 1/1] Char: mxsers, correct tty driver name
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Muni-Spam-TestIP: 147.251.51.189
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxsers, correct tty driver name

Mxser tty driver name should be ttyMI, not ttyM. Correct this in both
drivers (mxser, mxser_new) to avoid conflicts with isicom driver, which is
ttyM.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 3202b22139e878e0e4366c82fe166b51f0b920eb
tree 6126febd2a79c4b87751c259745fa40c442b5d60
parent d84ab77817b1844e1f813c58d0a0eaf2f33c3206
author Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 16:04:49 +0200
committer Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 16:04:49 +0200

 drivers/char/mxser.c     |    4 ++--
 drivers/char/mxser_new.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/mxser.c b/drivers/char/mxser.c
index 5e69e45..7416b9b 100644
--- a/drivers/char/mxser.c
+++ b/drivers/char/mxser.c
@@ -557,7 +557,7 @@ static int mxser_initbrd(int board, stru
 	n = board * MXSER_PORTS_PER_BOARD;
 	info = &mxvar_table[n];
 	/*if (verbose) */  {
-		printk(KERN_DEBUG "        ttyM%d - ttyM%d ",
+		printk(KERN_DEBUG "        ttyMI%d - ttyMI%d ",
 			n, n + hwconf->ports - 1);
 		printk(" max. baud rate = %d bps.\n",
 			hwconf->MaxCanSetBaudRate[0]);
@@ -718,7 +718,7 @@ static int mxser_init(void)
 	/* Initialize the tty_driver structure */
 	memset(mxvar_sdriver, 0, sizeof(struct tty_driver));
 	mxvar_sdriver->magic = TTY_DRIVER_MAGIC;
-	mxvar_sdriver->name = "ttyM";
+	mxvar_sdriver->name = "ttyMI";
 	mxvar_sdriver->major = ttymajor;
 	mxvar_sdriver->minor_start = 0;
 	mxvar_sdriver->num = MXSER_PORTS + 1;
diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index d212ae6..074f84c 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -2683,7 +2683,7 @@ static int __init mxser_module_init(void
 
 	/* Initialize the tty_driver structure */
 	mxvar_sdriver->magic = TTY_DRIVER_MAGIC;
-	mxvar_sdriver->name = "ttyM";
+	mxvar_sdriver->name = "ttyMI";
 	mxvar_sdriver->major = ttymajor;
 	mxvar_sdriver->minor_start = 0;
 	mxvar_sdriver->num = MXSER_PORTS + 1;
