Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVFWH1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVFWH1B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVFWH0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:26:00 -0400
Received: from [24.22.56.4] ([24.22.56.4]:14054 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262269AbVFWGSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:42 -0400
Message-Id: <20050623061801.424124000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:28 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net
Subject: [patch 36/38] CKRM e18: Classification Engine Configuration Support cleanup
Content-Disposition: inline; filename=ckrm-ce-config
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the configuration interface more accurately reflect the relationship between RBCE and CRBCE. Only the following 4 configurations are allowed:

  | CONFIG_RBCE | CONFIG_CRBCE |
--+-------------+--------------|
1 |      m      |       m      |
2 |      y      |       n      |
3 |      n      |       y      |
4 |      n      |       n      |

Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

---------------------------------------------------------------------

Index: linux-2.6.12-ckrm1/init/Kconfig
===================================================================
--- linux-2.6.12-ckrm1.orig/init/Kconfig	2005-06-20 15:04:52.000000000 -0700
+++ linux-2.6.12-ckrm1/init/Kconfig	2005-06-20 16:01:28.000000000 -0700
@@ -204,29 +204,44 @@ config CKRM_RES_NUMTASKS
 	  Say N if unsure, Y to use the feature.
 
 
+choice
+	prompt "Classification Engine"
+	depends on CKRM && RCFS_FS
+	default CKRM_RBCE
+	optional
+	help
+	 Select a classification engine (CE) that assists in
+	 automatic classification of kernel objects managed by CKRM when
+	 they are created. Without a CE, a user must manually
+	 classify objects into classes. Processes inherit their parent's
+	 classification.
+
+	 Only one engine can be built into the kernel though all can be
+	 built as modules (only one will load).
+
+ 	 Classification engines are optional component of CKRM.
+	 If unsure, say N.
+
 config CKRM_RBCE
-	tristate "Vanilla Rule-based Classification Engine (RBCE)"
-	depends on CKRM && RCFS_FS && CKRM_CRBCE != y
-	default m
-	help
-	  Provides an optional module to support creation of rules for automatic
-	  classification of kernel objects. Rules are created/deleted/modified
-	  through an rcfs interface. RBCE is not required for CKRM.
-
-	  If unsure, say N.
-
+	tristate "Rule-based Classification Engine (RBCE)"
+	help
+	  Vanilla Rule-based Classification Engine (RBCE). Rules for
+	  classifying kernel objects are created/deleted/modified through
+	  a RCFS directory using a filesystem interface.
+
 config CKRM_CRBCE
-	tristate "Enhanced Rule-based Classification Engine (RBCE)"
-	depends on CKRM && RCFS_FS && DELAY_ACCT && CKRM_RBCE != y && NET
-	default m
-	help
-	  Provides an optional module to support creation of rules for automatic
-	  classification of kernel objects, just like RBCE above. In addition,
-	  CRBCE provides per-process delay data (requires DELAY_ACCT configured)
-	  enabled) and makes information on significant kernel events available
-	  to userspace tools through netlink.
-
-	  If unsure, say N.
+	tristate "Enhanced Rule-based Classification Engine (CRBCE)"
+	depends on DELAY_ACCT && NET
+	help
+ 	  Enhanced Rule-based Classification Engine (CRBCE). Like the Vanilla
+ 	  RBCE, rules for classifying kernel objects are created, deleted and
+ 	  modified through a RCFS directory using a filesystem interface
+ 	  (requires CKRM_RCFS configured).
+
+ 	  In addition, CRBCE provides per-process delay data
+ 	  (requires DELAY_ACCT configured) and makes information on significant
+ 	  kernel events available to userspace tools through netlink.
+endchoice
 endmenu
 
 config SYSCTL

--
