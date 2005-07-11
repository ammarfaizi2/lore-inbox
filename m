Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVGKNta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVGKNta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 09:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVGKNta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 09:49:30 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:26565 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261209AbVGKNt3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:49:29 -0400
Subject: [PATCH 1/27] Update FMR functions
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121089070.4389.4507.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 09:41:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change some functions to return void rather than an int since they are
always returning 0, thus making checking return values rather pointless.

Signed-off-by: Tom Duffy <tduffy@sun.com>
Signed-off-by: Libor Michalek <libor@topspin.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

-- 
 core/fmr_pool.c       |    7 +++--
 include/ib_fmr_pool.h |    5 +++--
 2 files changed, 6 insertions(+), 6 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband/core/fmr_pool.c linux-2.6.13-rc2-mm1/drivers/infiniband1/core/fmr_pool.c
-- linux-2.6.13-rc2-mm1/drivers/infiniband/core/fmr_pool.c	2005-06-29 19:00:53.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband1/core/fmr_pool.c	2005-06-28 13:07:35.000000000 -0400
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -29,7 +30,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: fmr_pool.c 1349 2004-12-16 21:09:43Z roland $
+ * $Id: fmr_pool.c 2730 2005-06-28 16:43:03Z sean.hefty $
  */
 
 #include <linux/errno.h>
@@ -329,7 +330,7 @@ EXPORT_SYMBOL(ib_create_fmr_pool);
  *
  * Destroy an FMR pool and free all associated resources.
  */
-int ib_destroy_fmr_pool(struct ib_fmr_pool *pool)
+void ib_destroy_fmr_pool(struct ib_fmr_pool *pool)
 {
 	struct ib_pool_fmr *fmr;
 	struct ib_pool_fmr *tmp;
@@ -352,8 +353,6 @@ int ib_destroy_fmr_pool(struct ib_fmr_po
 
 	kfree(pool->cache_bucket);
 	kfree(pool);
-
-	return 0;
 }
 EXPORT_SYMBOL(ib_destroy_fmr_pool);
 
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband/include/ib_fmr_pool.h linux-2.6.13-rc2-mm1/drivers/infiniband1/include/ib_fmr_pool.h
-- linux-2.6.13-rc2-mm1/drivers/infiniband/include/ib_fmr_pool.h	2005-06-29 19:00:53.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband1/include/ib_fmr_pool.h	2005-06-28 13:07:34.000000000 -0400
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
+ * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -29,7 +30,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: ib_fmr_pool.h 1349 2004-12-16 21:09:43Z roland $
+ * $Id: ib_fmr_pool.h 2730 2005-06-28 16:43:03Z sean.hefty $
  */
 
 #if !defined(IB_FMR_POOL_H)
@@ -78,7 +79,7 @@ struct ib_pool_fmr {
 struct ib_fmr_pool *ib_create_fmr_pool(struct ib_pd             *pd,
 				       struct ib_fmr_pool_param *params);
 
-int ib_destroy_fmr_pool(struct ib_fmr_pool *pool);
+void ib_destroy_fmr_pool(struct ib_fmr_pool *pool);
 
 int ib_flush_fmr_pool(struct ib_fmr_pool *pool);
 


