Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVCCFgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVCCFgl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVCCFfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:35:55 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:54897 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261503AbVCCFbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:31:32 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][3/11] IB: sparse fixes
In-Reply-To: <2005322131.5pgryiWlkZPYdcE7@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 2 Mar 2005 21:31:22 -0800
Message-Id: <2005322131.O2Ym8iporsXeypcV@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 05:31:22.0601 (UTC) FILETIME=[3C496590:01C51FB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Duffy <tduffy@sun.com>

Fix some sparse warnings by making sure we have appropriate "extern"
declarations visible.

Signed-off-by: Tom Duffy <tduffy@sun.com>
Signed-off-by: Hal Rosenstock (<halr@voltaire.com>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/core/agent.c	2005-03-02 20:26:10.599187430 -0800
+++ linux-export/drivers/infiniband/core/agent.c	2005-03-02 20:26:11.456001445 -0800
@@ -45,14 +45,11 @@
 #include "smi.h"
 #include "agent_priv.h"
 #include "mad_priv.h"
-
+#include "agent.h"
 
 spinlock_t ib_agent_port_list_lock;
 static LIST_HEAD(ib_agent_port_list);
 
-extern kmem_cache_t *ib_mad_cache;
-
-
 /*
  * Caller must hold ib_agent_port_list_lock
  */
--- linux-export.orig/drivers/infiniband/core/cache.c	2005-03-02 20:26:03.085818330 -0800
+++ linux-export/drivers/infiniband/core/cache.c	2005-03-02 20:26:11.456001445 -0800
@@ -37,6 +37,8 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 
+#include <ib_cache.h>
+
 #include "core_priv.h"
 
 struct ib_pkey_cache {
--- linux-export.orig/drivers/infiniband/core/mad_priv.h	2005-03-02 20:26:10.980104746 -0800
+++ linux-export/drivers/infiniband/core/mad_priv.h	2005-03-02 20:26:11.457001228 -0800
@@ -192,4 +192,6 @@
 	struct ib_mad_qp_info qp_info[IB_MAD_QPS_CORE];
 };
 
+extern kmem_cache_t *ib_mad_cache;
+
 #endif	/* __IB_MAD_PRIV_H__ */
--- linux-export.orig/drivers/infiniband/core/smi.c	2005-03-02 20:26:03.085818330 -0800
+++ linux-export/drivers/infiniband/core/smi.c	2005-03-02 20:26:11.458001011 -0800
@@ -37,7 +37,7 @@
  */
 
 #include <ib_smi.h>
-
+#include "smi.h"
 
 /*
  * Fixup a directed route SMP for sending

