Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425302AbWLHJtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425302AbWLHJtA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 04:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425304AbWLHJtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 04:49:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55078 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425302AbWLHJs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 04:48:59 -0500
Date: Fri, 8 Dec 2006 09:48:56 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, marcel@holtmann.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hci endianness annotations
Message-ID: <20061208094855.GR4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/net/bluetooth/hci.h |    4 ++--
 net/bluetooth/hci_sock.c    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 10a3eec..41456c1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -739,13 +739,13 @@ #define HCI_DEV_NONE	0xffff
 struct hci_filter {
 	unsigned long type_mask;
 	unsigned long event_mask[2];
-	__u16   opcode;
+	__le16   opcode;
 };
 
 struct hci_ufilter {
 	__u32   type_mask;
 	__u32   event_mask[2];
-	__u16   opcode;
+	__le16   opcode;
 };
 
 #define HCI_FLT_TYPE_BITS	31
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 711a085..dbf98c4 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -123,10 +123,10 @@ void hci_send_to_sock(struct hci_dev *hd
 			if (flt->opcode &&
 			    ((evt == HCI_EV_CMD_COMPLETE &&
 			      flt->opcode !=
-			      get_unaligned((__u16 *)(skb->data + 3))) ||
+			      get_unaligned((__le16 *)(skb->data + 3))) ||
 			     (evt == HCI_EV_CMD_STATUS &&
 			      flt->opcode !=
-			      get_unaligned((__u16 *)(skb->data + 4)))))
+			      get_unaligned((__le16 *)(skb->data + 4)))))
 				continue;
 		}
 
-- 
1.4.2.GIT
