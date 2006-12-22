Return-Path: <linux-kernel-owner+w=401wt.eu-S1753194AbWLVWvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbWLVWvB (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 17:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbWLVWvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 17:51:00 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:41713 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbWLVWu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 17:50:58 -0500
Message-id: <1141328742697215348@wsc.cz>
In-reply-to: <2548619677109123490@wsc.cz>
Subject: [PATCH 3/3] Char: mxser_new, remove useless spinlock
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri, 22 Dec 2006 23:51:10 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, remove useless spinlock

gm_lock is useless, since ISA is configured at init time and there it's
serialized.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 5f93193574c932263132e3262853be671e9d1642
tree 94693e221836fd7234e290b9911757357889a580
parent 04a4dbf03a9fdc4c53282ab7e1db146389140c3b
author Jiri Slaby <jirislaby@gmail.com> Fri, 22 Dec 2006 23:04:17 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 22 Dec 2006 23:04:17 +0059

 drivers/char/mxser_new.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 2f173e9..103f0b5 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -313,7 +313,6 @@ static int mxvar_diagflag;
 static unsigned char mxser_msr[MXSER_PORTS + 1];
 static struct mxser_mon_ext mon_data_ext;
 static int mxser_set_baud_method[MXSER_PORTS + 1];
-static spinlock_t gm_lock;
 
 #ifdef CONFIG_PCI
 static int __devinit CheckIsMoxaMust(int io)
@@ -1377,7 +1376,6 @@ static int __init mxser_program_mode(int port)
 {
 	int id, i, j, n;
 
-	spin_lock(&gm_lock);
 	outb(0, port);
 	outb(0, port);
 	outb(0, port);
@@ -1385,7 +1383,6 @@ static int __init mxser_program_mode(int port)
 	(void)inb(port);
 	outb(0, port);
 	(void)inb(port);
-	spin_unlock(&gm_lock);
 
 	id = inb(port + 1) & 0x1F;
 	if ((id != C168_ASIC_ID) &&
@@ -2684,7 +2681,6 @@ static int __init mxser_module_init(void)
 	mxvar_sdriver = alloc_tty_driver(MXSER_PORTS + 1);
 	if (!mxvar_sdriver)
 		return -ENOMEM;
-	spin_lock_init(&gm_lock);
 
 	printk(KERN_INFO "MOXA Smartio/Industio family driver version %s\n",
 		MXSER_VERSION);
