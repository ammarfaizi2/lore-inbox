Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbWBHHLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbWBHHLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWBHHLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:11:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39325 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161053AbWBHHLQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:11:16 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] type-safe min() in prism54
Cc: jgarzik@pobox.com
Message-Id: <E1F6jTw-0002fW-2W@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:11:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138794148 -0500

we do min() on u8 and small integer constant; cast the latter to u8.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/net/wireless/prism54/isl_ioctl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

bf82a44949339c9af7bd61bb58847774e42e531e
diff --git a/drivers/net/wireless/prism54/isl_ioctl.c b/drivers/net/wireless/prism54/isl_ioctl.c
index c5cd61c..e5bb9f5 100644
--- a/drivers/net/wireless/prism54/isl_ioctl.c
+++ b/drivers/net/wireless/prism54/isl_ioctl.c
@@ -748,7 +748,7 @@ prism54_get_essid(struct net_device *nde
 	if (essid->length) {
 		dwrq->flags = 1;	/* set ESSID to ON for Wireless Extensions */
 		/* if it is to big, trunk it */
-		dwrq->length = min(IW_ESSID_MAX_SIZE, essid->length);
+		dwrq->length = min((u8)IW_ESSID_MAX_SIZE, essid->length);
 	} else {
 		dwrq->flags = 0;
 		dwrq->length = 0;
-- 
0.99.9.GIT

