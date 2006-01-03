Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWACLbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWACLbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 06:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWACLbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 06:31:38 -0500
Received: from ns.suse.de ([195.135.220.2]:1718 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751377AbWACLbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 06:31:37 -0500
Date: Tue, 3 Jan 2006 12:31:36 +0100
From: Jan Blunck <jblunck@suse.de>
To: akpm@osdl.org, kkeil@suse.de
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de
Subject: [PATCH 3/3] __attribute__((packed)) for the CAPI message structs
Message-ID: <20060103113136.GD24131@hasse.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QwZB9vYiNIzNXIj"
Content-Disposition: inline
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The CAPI message structs itself should be packed and not the location of
single fields in the structure.

Signed-off-by: Jan Blunck <jblunck@suse.de>

--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="act2000_capi-eliminate-packed-warnings.diff"

 drivers/isdn/act2000/capi.h |   88 ++++++++++++++++++++++----------------------
 1 files changed, 44 insertions(+), 44 deletions(-)

Index: linux-2.6/drivers/isdn/act2000/capi.h
===================================================================
--- linux-2.6.orig/drivers/isdn/act2000/capi.h
+++ linux-2.6/drivers/isdn/act2000/capi.h
@@ -78,29 +78,29 @@ typedef union  actcapi_infoel {         
 typedef struct actcapi_msn {
 	__u8 eaz;
 	__u8 len;                            /* Length of MSN                */
-	__u8 msn[15] __attribute__ ((packed));
-} actcapi_msn;
+	__u8 msn[15];
+}  __attribute__((packed)) actcapi_msn;
 
 typedef struct actcapi_dlpd {
 	__u8 len;                            /* Length of structure          */
-	__u16 dlen __attribute__ ((packed)); /* Data Length                  */
-	__u8 laa __attribute__ ((packed));   /* Link Address A               */
+	__u16 dlen;                          /* Data Length                  */
+	__u8 laa;                            /* Link Address A               */
 	__u8 lab;                            /* Link Address B               */
 	__u8 modulo;                         /* Modulo Mode                  */
 	__u8 win;                            /* Window size                  */
 	__u8 xid[100];                       /* XID Information              */
-} actcapi_dlpd;
+} __attribute__((packed)) actcapi_dlpd;
 
 typedef struct actcapi_ncpd {
 	__u8   len;                          /* Length of structure          */
-	__u16  lic __attribute__ ((packed));
-	__u16  hic __attribute__ ((packed));
-	__u16  ltc __attribute__ ((packed));
-	__u16  htc __attribute__ ((packed));
-	__u16  loc __attribute__ ((packed));
-	__u16  hoc __attribute__ ((packed));
-	__u8   modulo __attribute__ ((packed));
-} actcapi_ncpd;
+	__u16  lic;
+	__u16  hic;
+	__u16  ltc;
+	__u16  htc;
+	__u16  loc;
+	__u16  hoc;
+	__u8   modulo;
+} __attribute__((packed)) actcapi_ncpd;
 #define actcapi_ncpi actcapi_ncpd
 
 /*
@@ -168,19 +168,19 @@ typedef struct actcapi_msg {
 			__u16 manuf_msg;
 			__u16 controller;
 			actcapi_msn msnmap;
-		} manufacturer_req_msn;
+		} __attribute ((packed)) manufacturer_req_msn;
 		/* TODO: TraceInit-req/conf/ind/resp and
 		 *       TraceDump-req/conf/ind/resp
 		 */
 		struct connect_req {
 			__u8  controller;
 			__u8  bchan;
-			__u32 infomask __attribute__ ((packed));
+			__u32 infomask;
 			__u8  si1;
 			__u8  si2;
 			__u8  eaz;
 			actcapi_addr addr;
-		} connect_req;
+		} __attribute__ ((packed)) connect_req;
 		struct connect_conf {
 			__u16 plci;
 			__u16 info;
@@ -192,7 +192,7 @@ typedef struct actcapi_msg {
 			__u8  si2;
 			__u8  eaz;
 			actcapi_addr addr;
-		} connect_ind;
+		} __attribute__ ((packed)) connect_ind;
 		struct connect_resp {
 			__u16 plci;
 			__u8  rejectcause;
@@ -200,14 +200,14 @@ typedef struct actcapi_msg {
 		struct connect_active_ind {
 			__u16 plci;
 			actcapi_addr addr;
-		} connect_active_ind;
+		} __attribute__ ((packed)) connect_active_ind;
 		struct connect_active_resp {
 			__u16 plci;
 		} connect_active_resp;
 		struct connect_b3_req {
 			__u16 plci;
 			actcapi_ncpi ncpi;
-		} connect_b3_req;
+		} __attribute__ ((packed)) connect_b3_req;
 		struct connect_b3_conf {
 			__u16 plci;
 			__u16 ncci;
@@ -217,12 +217,12 @@ typedef struct actcapi_msg {
 			__u16 ncci;
 			__u16 plci;
 			actcapi_ncpi ncpi;
-		} connect_b3_ind;
+		} __attribute__ ((packed)) connect_b3_ind;
 		struct connect_b3_resp {
 			__u16 ncci;
 			__u8  rejectcause;
-			actcapi_ncpi ncpi __attribute__ ((packed));
-		} connect_b3_resp;
+			actcapi_ncpi ncpi;
+		} __attribute__ ((packed)) connect_b3_resp;
 		struct disconnect_req {
 			__u16 plci;
 			__u8  cause;
@@ -241,14 +241,14 @@ typedef struct actcapi_msg {
 		struct connect_b3_active_ind {
 			__u16 ncci;
 			actcapi_ncpi ncpi;
-		} connect_b3_active_ind;
+		} __attribute__ ((packed)) connect_b3_active_ind;
 		struct connect_b3_active_resp {
 			__u16 ncci;
 		} connect_b3_active_resp;
 		struct disconnect_b3_req {
 			__u16 ncci;
 			actcapi_ncpi ncpi;
-		} disconnect_b3_req;
+		} __attribute__ ((packed)) disconnect_b3_req;
 		struct disconnect_b3_conf {
 			__u16 ncci;
 			__u16 info;
@@ -257,7 +257,7 @@ typedef struct actcapi_msg {
 			__u16 ncci;
 			__u16 info;
 			actcapi_ncpi ncpi;
-		} disconnect_b3_ind;
+		} __attribute__ ((packed)) disconnect_b3_ind;
 		struct disconnect_b3_resp {
 			__u16 ncci;
 		} disconnect_b3_resp;
@@ -265,7 +265,7 @@ typedef struct actcapi_msg {
 			__u16 plci;
 			actcapi_infonr nr;
 			actcapi_infoel el;
-		} info_ind;
+		} __attribute__ ((packed)) info_ind;
 		struct info_resp {
 			__u16 plci;
 		} info_resp;
@@ -279,8 +279,8 @@ typedef struct actcapi_msg {
 		struct select_b2_protocol_req {
 			__u16 plci;
 			__u8  protocol;
-			actcapi_dlpd dlpd __attribute__ ((packed));
-		} select_b2_protocol_req;
+			actcapi_dlpd dlpd;
+		} __attribute__ ((packed)) select_b2_protocol_req;
 		struct select_b2_protocol_conf {
 			__u16 plci;
 			__u16 info;
@@ -288,47 +288,47 @@ typedef struct actcapi_msg {
 		struct select_b3_protocol_req {
 			__u16 plci;
 			__u8  protocol;
-			actcapi_ncpd ncpd __attribute__ ((packed));
-		} select_b3_protocol_req;
+			actcapi_ncpd ncpd;
+		} __attribute__ ((packed)) select_b3_protocol_req;
 		struct select_b3_protocol_conf {
 			__u16 plci;
 			__u16 info;
 		} select_b3_protocol_conf;
 		struct listen_req {
 			__u8  controller;
-			__u32 infomask __attribute__ ((packed));  
-			__u16 eazmask __attribute__ ((packed));
-			__u16 simask __attribute__ ((packed));
-		} listen_req;
+			__u32 infomask;
+			__u16 eazmask;
+			__u16 simask;
+		} __attribute__ ((packed)) listen_req;
 		struct listen_conf {
 			__u8  controller;
-			__u16 info __attribute__ ((packed));
-		} listen_conf;
+			__u16 info;
+		} __attribute__ ((packed)) listen_conf;
 		struct data_b3_req {
 			__u16 fakencci;
 			__u16 datalen;
 			__u32 unused;
 			__u8  blocknr;
-			__u16 flags __attribute__ ((packed));
-		} data_b3_req;
+			__u16 flags;
+		} __attribute ((packed)) data_b3_req;
 		struct data_b3_ind {
 			__u16 fakencci;
 			__u16 datalen;
 			__u32 unused;
 			__u8  blocknr;
-			__u16 flags __attribute__ ((packed));
-		} data_b3_ind;
+			__u16 flags;
+		} __attribute__ ((packed)) data_b3_ind;
 		struct data_b3_resp {
 			__u16 ncci;
 			__u8  blocknr;
-		} data_b3_resp;
+		} __attribute__ ((packed)) data_b3_resp;
 		struct data_b3_conf {
 			__u16 ncci;
 			__u8  blocknr;
-			__u16 info __attribute__ ((packed));
-		} data_b3_conf;
+			__u16 info;
+		} __attribute__ ((packed)) data_b3_conf;
 	} msg;
-} actcapi_msg;
+} __attribute__ ((packed)) actcapi_msg;
 
 extern __inline__ unsigned short
 actcapi_nextsmsg(act2000_card *card)

--+QwZB9vYiNIzNXIj--
