Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752130AbWCOQbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbWCOQbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 11:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbWCOQbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 11:31:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22803 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752130AbWCOQbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 11:31:34 -0500
Date: Wed, 15 Mar 2006 17:31:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kkeil@suse.de, kai.germaschewski@gmx.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] i4l/isdn_tty.c: fix a check-after-use
Message-ID: <20060315163133.GX13973@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a check-after-use spotted by the Coverity checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc6-mm1-full/drivers/isdn/i4l/isdn_tty.c.old	2006-03-14 02:41:38.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/drivers/isdn/i4l/isdn_tty.c	2006-03-14 02:42:10.000000000 +0100
@@ -2345,12 +2345,15 @@ isdn_tty_at_cout(char *msg, modem_info *
 	u_long flags;
 	struct sk_buff *skb = NULL;
 	char *sp = NULL;
-	int l = strlen(msg);
+	int l;
 
 	if (!msg) {
 		printk(KERN_WARNING "isdn_tty: Null-Message in isdn_tty_at_cout\n");
 		return;
 	}
+
+	l = strlen(msg);
+
 	spin_lock_irqsave(&info->readlock, flags);
 	tty = info->tty;
 	if ((info->flags & ISDN_ASYNC_CLOSING) || (!tty)) {

