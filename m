Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbVGKVRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVGKVRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVGKVO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:14:29 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:15822 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262706AbVGKVNt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:13:49 -0400
Subject: [PATCH 28/29v2] Eliminate sparse warnings in SA client
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110441.4389.5040.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 17:06:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate sparse warnings in SA client

Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 20/29.

-- 
 core/sa_query.c |    6 +++--
 include/ib_sa.h |   10 +++++--
 2 files changed, 8 insertions(+), 8 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1-27/drivers/infiniband/core/sa_query.c linux-2.6.13-rc2-mm1-28/drivers/infiniband/core/sa_query.c
-- linux-2.6.13-rc2-mm1-27/drivers/infiniband/core/sa_query.c	2005-07-10 16:41:32.000000000 -0400
+++ linux-2.6.13-rc2-mm1-28/drivers/infiniband/core/sa_query.c	2005-07-11 13:55:40.000000000 -0400
@@ -600,7 +600,7 @@ static void ib_sa_path_rec_release(struc
 int ib_sa_path_rec_get(struct ib_device *device, u8 port_num,
 		       struct ib_sa_path_rec *rec,
 		       ib_sa_comp_mask comp_mask,
-		       int timeout_ms, int gfp_mask,
+		       int timeout_ms, unsigned int __nocast gfp_mask,
 		       void (*callback)(int status,
 					struct ib_sa_path_rec *resp,
 					void *context),
@@ -702,7 +702,7 @@ static void ib_sa_service_rec_release(st
 int ib_sa_service_rec_query(struct ib_device *device, u8 port_num, u8 method,
 			    struct ib_sa_service_rec *rec,
 			    ib_sa_comp_mask comp_mask,
-			    int timeout_ms, int gfp_mask,
+			    int timeout_ms, unsigned int __nocast gfp_mask,
 			    void (*callback)(int status,
 					     struct ib_sa_service_rec *resp,
 					     void *context),
@@ -785,7 +785,7 @@ int ib_sa_mcmember_rec_query(struct ib_d
 			     u8 method,
 			     struct ib_sa_mcmember_rec *rec,
 			     ib_sa_comp_mask comp_mask,
-			     int timeout_ms, int gfp_mask,
+			     int timeout_ms, unsigned int __nocast gfp_mask,
 			     void (*callback)(int status,
 					      struct ib_sa_mcmember_rec *resp,
 					      void *context),
diff -uprN linux-2.6.13-rc2-mm1-27/drivers/infiniband/include/ib_sa.h linux-2.6.13-rc2-mm1-28/drivers/infiniband/include/ib_sa.h
-- linux-2.6.13-rc2-mm1-27/drivers/infiniband/include/ib_sa.h	2005-07-10 16:40:43.000000000 -0400
+++ linux-2.6.13-rc2-mm1-28/drivers/infiniband/include/ib_sa.h	2005-07-11 13:55:37.000000000 -0400
@@ -256,7 +256,7 @@ void ib_sa_cancel_query(int id, struct i
 int ib_sa_path_rec_get(struct ib_device *device, u8 port_num,
 		       struct ib_sa_path_rec *rec,
 		       ib_sa_comp_mask comp_mask,
-		       int timeout_ms, int gfp_mask,
+		       int timeout_ms, unsigned int __nocast gfp_mask,
 		       void (*callback)(int status,
 					struct ib_sa_path_rec *resp,
 					void *context),
@@ -267,7 +267,7 @@ int ib_sa_mcmember_rec_query(struct ib_d
 			     u8 method,
 			     struct ib_sa_mcmember_rec *rec,
 			     ib_sa_comp_mask comp_mask,
-			     int timeout_ms, int gfp_mask,
+			     int timeout_ms, unsigned int __nocast gfp_mask,
 			     void (*callback)(int status,
 					      struct ib_sa_mcmember_rec *resp,
 					      void *context),
@@ -278,7 +278,7 @@ int ib_sa_service_rec_query(struct ib_de
 			 u8 method,
 			 struct ib_sa_service_rec *rec,
 			 ib_sa_comp_mask comp_mask,
-			 int timeout_ms, int gfp_mask,
+			 int timeout_ms, unsigned int __nocast gfp_mask,
 			 void (*callback)(int status,
 					  struct ib_sa_service_rec *resp,
 					  void *context),
@@ -313,7 +313,7 @@ static inline int
 ib_sa_mcmember_rec_set(struct ib_device *device, u8 port_num,
 		       struct ib_sa_mcmember_rec *rec,
 		       ib_sa_comp_mask comp_mask,
-		       int timeout_ms, int gfp_mask,
+		       int timeout_ms, unsigned int __nocast gfp_mask,
 		       void (*callback)(int status,
 					struct ib_sa_mcmember_rec *resp,
 					void *context),
@@ -355,7 +355,7 @@ static inline int
 ib_sa_mcmember_rec_delete(struct ib_device *device, u8 port_num,
 			  struct ib_sa_mcmember_rec *rec,
 			  ib_sa_comp_mask comp_mask,
-			  int timeout_ms, int gfp_mask,
+			  int timeout_ms, unsigned int __nocast gfp_mask,
 			  void (*callback)(int status,
 					   struct ib_sa_mcmember_rec *resp,
 					   void *context),


