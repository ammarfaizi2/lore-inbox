Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWJAU10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWJAU10 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 16:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWJAU10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 16:27:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:47853 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932317AbWJAU1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 16:27:25 -0400
X-Authenticated: #704063
Subject: [Patch] Possible dereference in drivers/net/wireless/zd1201.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: pe1rxq@amsat.org
Content-Type: text/plain
Date: Sun, 01 Oct 2006 22:27:17 +0200
Message-Id: <1159734437.11887.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

if we enter the if(!zd) and set free to 1,
we dereference zd in the exit code.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git16/drivers/net/wireless/zd1201.c.orig	2006-10-01 22:21:59.000000000 +0200
+++ linux-2.6.18-git16/drivers/net/wireless/zd1201.c	2006-10-01 22:22:59.000000000 +0200
@@ -193,10 +193,8 @@ static void zd1201_usbrx(struct urb *urb
 	struct sk_buff *skb;
 	unsigned char type;
 
-	if (!zd) {
-		free = 1;
-		goto exit;
-	}
+	if (!zd)
+		return;
 
 	switch(urb->status) {
 		case -EILSEQ:


