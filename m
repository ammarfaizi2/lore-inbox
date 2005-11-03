Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030515AbVKCXLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbVKCXLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030520AbVKCXLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:11:10 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22347 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030515AbVKCXLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:11:09 -0500
Subject: [git patch review 1/7] [IB] ucm: 32/64 compatibility fixes
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 03 Nov 2005 23:10:59 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131059459422-6013455baf532b88@cisco.com>
X-OriginalArrivalTime: 03 Nov 2005 23:11:00.0464 (UTC) FILETIME=[DADA2700:01C5E0CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix structure layouts to ensure same size on 32-bit and 64-bit architectures.
This permits 32-bit userspace apps on a 64-bit kernel.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 include/rdma/ib_user_cm.h |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

applies-to: ecb02f68e1055343bb45fc38350a8e33c827efc9
7b28b0d000eeb62d77add636f5d6eb0da04e48aa
diff --git a/include/rdma/ib_user_cm.h b/include/rdma/ib_user_cm.h
index 3037588..19be116 100644
--- a/include/rdma/ib_user_cm.h
+++ b/include/rdma/ib_user_cm.h
@@ -38,7 +38,7 @@
 
 #include <linux/types.h>
 
-#define IB_USER_CM_ABI_VERSION 3
+#define IB_USER_CM_ABI_VERSION 4
 
 enum {
 	IB_USER_CM_CMD_CREATE_ID,
@@ -84,6 +84,7 @@ struct ib_ucm_create_id_resp {
 struct ib_ucm_destroy_id {
 	__u64 response;
 	__u32 id;
+	__u32 reserved;
 };
 
 struct ib_ucm_destroy_id_resp {
@@ -93,6 +94,7 @@ struct ib_ucm_destroy_id_resp {
 struct ib_ucm_attr_id {
 	__u64 response;
 	__u32 id;
+	__u32 reserved;
 };
 
 struct ib_ucm_attr_id_resp {
@@ -164,6 +166,7 @@ struct ib_ucm_listen {
 	__be64 service_id;
 	__be64 service_mask;
 	__u32 id;
+	__u32 reserved;
 };
 
 struct ib_ucm_establish {
@@ -219,7 +222,7 @@ struct ib_ucm_req {
 	__u8  rnr_retry_count;
 	__u8  max_cm_retries;
 	__u8  srq;
-	__u8  reserved[1];
+	__u8  reserved[5];
 };
 
 struct ib_ucm_rep {
@@ -236,6 +239,7 @@ struct ib_ucm_rep {
 	__u8  flow_control;
 	__u8  rnr_retry_count;
 	__u8  srq;
+	__u8  reserved[4];
 };
 
 struct ib_ucm_info {
@@ -245,7 +249,7 @@ struct ib_ucm_info {
 	__u64 data;
 	__u8  info_len;
 	__u8  data_len;
-	__u8  reserved[2];
+	__u8  reserved[6];
 };
 
 struct ib_ucm_mra {
@@ -273,6 +277,7 @@ struct ib_ucm_sidr_req {
 	__u16 pkey;
 	__u8  len;
 	__u8  max_cm_retries;
+	__u8  reserved[4];
 };
 
 struct ib_ucm_sidr_rep {
@@ -284,7 +289,7 @@ struct ib_ucm_sidr_rep {
 	__u64 data;
 	__u8  info_len;
 	__u8  data_len;
-	__u8  reserved[2];
+	__u8  reserved[6];
 };
 /*
  * event notification ABI structures.
@@ -295,7 +300,7 @@ struct ib_ucm_event_get {
 	__u64 info;
 	__u8  data_len;
 	__u8  info_len;
-	__u8  reserved[2];
+	__u8  reserved[6];
 };
 
 struct ib_ucm_req_event_resp {
@@ -315,6 +320,7 @@ struct ib_ucm_req_event_resp {
 	__u8  rnr_retry_count;
 	__u8  srq;
 	__u8  port;
+	__u8  reserved[7];
 };
 
 struct ib_ucm_rep_event_resp {
@@ -329,7 +335,7 @@ struct ib_ucm_rep_event_resp {
 	__u8  flow_control;
 	__u8  rnr_retry_count;
 	__u8  srq;
-	__u8  reserved[1];
+	__u8  reserved[5];
 };
 
 struct ib_ucm_rej_event_resp {
@@ -374,6 +380,7 @@ struct ib_ucm_event_resp {
 	__u32 id;
 	__u32 event;
 	__u32 present;
+	__u32 reserved;
 	union {
 		struct ib_ucm_req_event_resp req_resp;
 		struct ib_ucm_rep_event_resp rep_resp;
---
0.99.9
