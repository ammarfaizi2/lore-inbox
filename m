Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVCFWpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVCFWpd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVCFWnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:43:00 -0500
Received: from coderock.org ([193.77.147.115]:14768 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261589AbVCFWiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:38:25 -0500
Subject: [patch 6/8] drivers/isdn/hisax/* - compile warning cleanup
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
       domen@coderock.org, yrgrknmxpzlk@gawab.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:38:15 +0100
Message-Id: <20050306223816.667791EFA4@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


compile warning cleanup - handle copy_to/from_user error 
returns

Signed-off-by: Stephen Biggs <yrgrknmxpzlk@gawab.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/isdn/hisax/config.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff -puN drivers/isdn/hisax/config.c~return_code-drivers_isdn_hisax drivers/isdn/hisax/config.c
--- kj/drivers/isdn/hisax/config.c~return_code-drivers_isdn_hisax	2005-03-05 16:13:06.000000000 +0100
+++ kj-domen/drivers/isdn/hisax/config.c	2005-03-05 16:13:06.000000000 +0100
@@ -631,7 +631,12 @@ int HiSax_readstatus(u_char __user *buf,
 		count = cs->status_end - cs->status_read + 1;
 		if (count >= len)
 			count = len;
-		copy_to_user(p, cs->status_read, count);
+		if (copy_to_user(p, cs->status_read, count)) {
+			printk(KERN_ERR
+				"HiSax:%s: copy_to_user failed!\n",
+				__FUNCTION__);
+			return -EFAULT;
+		}
 		cs->status_read += count;
 		if (cs->status_read > cs->status_end)
 			cs->status_read = cs->status_buf;
@@ -642,7 +647,12 @@ int HiSax_readstatus(u_char __user *buf,
 				cnt = HISAX_STATUS_BUFSIZE;
 			else
 				cnt = count;
-			copy_to_user(p, cs->status_read, cnt);
+			if (copy_to_user(p, cs->status_read, cnt)) {
+				printk(KERN_ERR
+					"HiSax:%s: copy_to_user failed!\n",
+					__FUNCTION__);
+				return -EFAULT;
+			}
 			p += cnt;
 			cs->status_read += cnt % HISAX_STATUS_BUFSIZE;
 			count -= cnt;
_
