Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbUL3I7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbUL3I7y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 03:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbUL3I6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 03:58:42 -0500
Received: from smtp.knology.net ([24.214.63.101]:35549 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261586AbUL3Ish (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:37 -0500
Date: Thu, 30 Dec 2004 03:48:36 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 13/22] typhoon: Make the ipsec descriptor match actual usage
Message-Id: <20041230035000.22@ori.thedillows.org>
References: <20041230035000.21@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 00:53:15-05:00 dave@thedillows.org 
#   Make the crypto structures better match actual usage.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# drivers/net/typhoon.h
#   2004/12/30 00:52:57-05:00 dave@thedillows.org +13 -11
#   Make the crypto structures better match actual usage.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/drivers/net/typhoon.h b/drivers/net/typhoon.h
--- a/drivers/net/typhoon.h	2004-12-30 01:09:36 -05:00
+++ b/drivers/net/typhoon.h	2004-12-30 01:09:36 -05:00
@@ -210,7 +210,10 @@
  * flags:	descriptor type
  * numDesc:	must be 1
  * ipsecFlags:	bit 0: 0 -- generate IV, 1 -- use supplied IV
- * sa1, sa2:	Security Association IDs for this packet
+ * sa[0]:	the inner AH header offload cookie (or ESP if no AH)
+ * sa[1]:	the inner ESP header offload cookie (or 0 if no AH)
+ * sa[2]:	the outer AH header offload cookie (or ESP if no AH)
+ * sa[3]:	the outer ESP header offload cookie (or 0 if no AH)
  * reserved:	set to 0
  */
 struct ipsec_desc {
@@ -219,8 +222,7 @@
 	u16 ipsecFlags;
 #define TYPHOON_IPSEC_GEN_IV	__constant_cpu_to_le16(0x0000)
 #define TYPHOON_IPSEC_USE_IV	__constant_cpu_to_le16(0x0001)
-	u32 sa1;
-	u32 sa2;
+	u16 sa[4];
 	u32 reserved;
 } __attribute__ ((packed));
 
@@ -268,14 +270,14 @@
 #define TYPHOON_RX_FILTER_MASK		__constant_cpu_to_le16(0x7fff)
 #define TYPHOON_RX_FILTERED		__constant_cpu_to_le16(0x8000)
 	u16 ipsecResults;
-#define TYPHOON_RX_OUTER_AH_GOOD	__constant_cpu_to_le16(0x0001)
-#define TYPHOON_RX_OUTER_ESP_GOOD	__constant_cpu_to_le16(0x0002)
-#define TYPHOON_RX_INNER_AH_GOOD	__constant_cpu_to_le16(0x0004)
-#define TYPHOON_RX_INNER_ESP_GOOD	__constant_cpu_to_le16(0x0008)
-#define TYPHOON_RX_OUTER_AH_FAIL	__constant_cpu_to_le16(0x0010)
-#define TYPHOON_RX_OUTER_ESP_FAIL	__constant_cpu_to_le16(0x0020)
-#define TYPHOON_RX_INNER_AH_FAIL	__constant_cpu_to_le16(0x0040)
-#define TYPHOON_RX_INNER_ESP_FAIL	__constant_cpu_to_le16(0x0080)
+#define TYPHOON_RX_AH1_GOOD		__constant_cpu_to_le16(0x0001)
+#define TYPHOON_RX_ESP1_GOOD		__constant_cpu_to_le16(0x0002)
+#define TYPHOON_RX_AH2_GOOD		__constant_cpu_to_le16(0x0004)
+#define TYPHOON_RX_ESP2_GOOD		__constant_cpu_to_le16(0x0008)
+#define TYPHOON_RX_AH1_FAIL		__constant_cpu_to_le16(0x0010)
+#define TYPHOON_RX_ESP1_FAIL		__constant_cpu_to_le16(0x0020)
+#define TYPHOON_RX_AH2_FAIL		__constant_cpu_to_le16(0x0040)
+#define TYPHOON_RX_ESP2_FAIL		__constant_cpu_to_le16(0x0080)
 #define TYPHOON_RX_UNKNOWN_SA		__constant_cpu_to_le16(0x0100)
 #define TYPHOON_RX_ESP_FORMAT_ERR	__constant_cpu_to_le16(0x0200)
 	u32 vlanTag;
