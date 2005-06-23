Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVFWHxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVFWHxh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVFWHwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:52:51 -0400
Received: from [24.22.56.4] ([24.22.56.4]:8678 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262243AbVFWGSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:39 -0400
Message-Id: <20050623061759.446971000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:18 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 26/38] CKRM e18: Classification Engines - RBCE and CRBCE are mutually exclusive
Content-Disposition: inline; filename=ckrm-ce_modules
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that RBCE and CRBCE are only configured when the other is not
built into the kernel.

Update CRBCE help text to reflect switch from using RelayFS to netlink.

Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

--

Index: linux-2.6.12-ckrm1/init/Kconfig
===================================================================
--- linux-2.6.12-ckrm1.orig/init/Kconfig	2005-06-20 15:02:49.000000000 -0700
+++ linux-2.6.12-ckrm1/init/Kconfig	2005-06-20 15:04:52.000000000 -0700
@@ -206,7 +206,7 @@ config CKRM_RES_NUMTASKS
 
 config CKRM_RBCE
 	tristate "Vanilla Rule-based Classification Engine (RBCE)"
-	depends on CKRM && RCFS_FS
+	depends on CKRM && RCFS_FS && CKRM_CRBCE != y
 	default m
 	help
 	  Provides an optional module to support creation of rules for automatic
@@ -217,14 +217,14 @@ config CKRM_RBCE
 
 config CKRM_CRBCE
 	tristate "Enhanced Rule-based Classification Engine (RBCE)"
-	depends on CKRM && RCFS_FS && DELAY_ACCT
+	depends on CKRM && RCFS_FS && DELAY_ACCT && CKRM_RBCE != y && NET
 	default m
 	help
 	  Provides an optional module to support creation of rules for automatic
 	  classification of kernel objects, just like RBCE above. In addition,
 	  CRBCE provides per-process delay data (requires DELAY_ACCT configured)
 	  enabled) and makes information on significant kernel events available
-	  to userspace tools through relayfs (requires RELAYFS_FS configured).
+	  to userspace tools through netlink.
 
 	  If unsure, say N.
 endmenu

--
