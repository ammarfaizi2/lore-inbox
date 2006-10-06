Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbWJFXCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbWJFXCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbWJFXCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:02:41 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:64666 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S932660AbWJFXCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:02:40 -0400
Message-id: <34287982344@wsc.cz>
Subject: [PATCH 4/6] Char: mxser_new, don't check tty_unregister retval
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat,  7 Oct 2006 01:02:39 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, don't check tty_unregister retval

Like other drivers silently unregister_tty_driver and put_tty_driver. It
shouldn't be busy when module release function is called, since we are not
bsd, no refs shouldn't be held.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 24213aff7a051554d9e489db5d60605e1a6ae7ab
tree b1bad2212060583b3bf4322e64bf6cf18a6c7cf2
parent 39c9825cc56a093e7779780e2928cf8944cb1148
author Jiri Slaby <jirislaby@gmail.com> Sat, 07 Oct 2006 00:11:04 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 07 Oct 2006 00:11:04 +0200

 drivers/char/mxser_new.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 073926e..25c5091 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -2994,15 +2994,12 @@ static int __init mxser_module_init(void
 
 static void __exit mxser_module_exit(void)
 {
-	int i, err;
+	unsigned int i;
 
 	pr_debug("Unloading module mxser ...\n");
 
-	err = tty_unregister_driver(mxvar_sdriver);
-	if (!err)
-		put_tty_driver(mxvar_sdriver);
-	else
-		printk(KERN_ERR "Couldn't unregister MOXA Smartio/Industio family serial driver\n");
+	tty_unregister_driver(mxvar_sdriver);
+	put_tty_driver(mxvar_sdriver);
 
 	for (i = 0; i < MXSER_BOARDS; i++)
 		if (mxser_boards[i].board_type != -1)
