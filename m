Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161228AbWJ3Khv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbWJ3Khv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbWJ3Khm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:37:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:31670 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161228AbWJ3Kh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:37:26 -0500
To: marcel@holtmann.org
Subject: [PATCH] rfcomm endianness annotations
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Message-Id: <E1GeUWD-0002X3-TD@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 30 Oct 2006 10:37:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/net/bluetooth/rfcomm.h |    4 ++--
 net/bluetooth/rfcomm/core.c    |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 89d743c..3c563f0 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -124,7 +124,7 @@ struct rfcomm_pn {
 	u8  flow_ctrl;
 	u8  priority;
 	u8  ack_timer;
-	u16 mtu;
+	__le16 mtu;
 	u8  max_retrans;
 	u8  credits;
 } __attribute__ ((packed));
@@ -136,7 +136,7 @@ struct rfcomm_rpn {
 	u8  flow_ctrl;
 	u8  xon_char;
 	u8  xoff_char;
-	u16 param_mask;
+	__le16 param_mask;
 } __attribute__ ((packed));
 
 struct rfcomm_rls {
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ddc4e9d..f3e5b7e 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1018,7 +1018,7 @@ static void rfcomm_make_uih(struct sk_bu
 
 	if (len > 127) {
 		hdr = (void *) skb_push(skb, 4);
-		put_unaligned(htobs(__len16(len)), (u16 *) &hdr->len);
+		put_unaligned(htobs(__len16(len)), (__le16 *) &hdr->len);
 	} else {
 		hdr = (void *) skb_push(skb, 3);
 		hdr->len = __len8(len);
-- 
1.4.2.GIT


