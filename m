Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161149AbWJOWYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbWJOWYL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 18:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWJOWYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 18:24:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:31469 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932157AbWJOWYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 18:24:10 -0400
Date: Sun, 15 Oct 2006 23:24:05 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rfcomm endianness annotations
Message-ID: <20061015222405.GW29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] rfcomm endianness annotations

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
index 468df3b..0494ff1 100644
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

