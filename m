Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVKKDDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVKKDDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 22:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVKKDDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 22:03:54 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:51390 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751243AbVKKDDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 22:03:53 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: [PATCH] plugsched - update Kconfig
Date: Fri, 11 Nov 2005 14:05:33 +1100
User-Agent: KMail/1.8.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
References: <434F01EA.6060709@bigpond.net.au>
In-Reply-To: <434F01EA.6060709@bigpond.net.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9pAdDZU0sLBR6Zi"
Message-Id: <200511111405.33762.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_9pAdDZU0sLBR6Zi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Peter et al

I find the Kconfig menu layout a little confusing and suggest the following 
patch.

Cheers,
Con

--Boundary-00=_9pAdDZU0sLBR6Zi
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="plugsched-6.1.3-update-Kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="plugsched-6.1.3-update-Kconfig.patch"

Update the Kconfig menu for plugsched

Make the default cpu scheduler choice depend on the presence of that scheduler
being configured in rather than selecting it since the default is for all to
be built in unless manually deselected in the embedded menu.

Make a submenu for spa schedulers instead of having a flat list.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 Kconfig |   32 ++++++++++++--------------------
 1 files changed, 12 insertions(+), 20 deletions(-)

Index: linux-2.6.14-plugsched/init/Kconfig
===================================================================
--- linux-2.6.14-plugsched.orig/init/Kconfig	2005-11-11 13:35:06.000000000 +1100
+++ linux-2.6.14-plugsched/init/Kconfig	2005-11-11 13:45:25.000000000 +1100
@@ -276,28 +276,28 @@ choice
 
 config CPUSCHED_DEFAULT_INGO
 	bool "Ingosched cpu scheduler"
-	select CPUSCHED_INGO
+	depends on CPUSCHED_INGO
 	---help---
 	  This is the default cpu scheduler which is an O(1) dual priority
 	  array scheduler with a hybrid interactive design.
 
 config CPUSCHED_DEFAULT_STAIRCASE
 	bool "Staircase cpu scheduler"
-	select CPUSCHED_STAIRCASE
+	depends on CPUSCHED_STAIRCASE
 	---help---
 	  This scheduler is an O(1) single priority array with a foreground-
 	  background interactive design.
 
 config CPUSCHED_DEFAULT_SPA_NF
 	bool "Single priority array (SPA) cpu scheduler (no frills)"
-	select CPUSCHED_SPA_NF
+	depends on CPUSCHED_SPA_NF
 	---help---
 	  This is a simple round robin scheduler with a O(1) single priority
 	  array.
 
 config CPUSCHED_DEFAULT_SPA_WS
 	bool "Single priority array (SPA) cpu scheduler (work station)"
-	select CPUSCHED_SPA_WS
+	depends on CPUSCHED_SPA_WS
 	---help---
 	  This is a scheduler with a O(1) single priority array intended for
 	  use on work stations.  It has modifications to improve interactive
@@ -305,7 +305,7 @@ config CPUSCHED_DEFAULT_SPA_WS
 
 config CPUSCHED_DEFAULT_SPA_SVR
 	bool "Single priority array (SPA) cpu scheduler (server)"
-	select CPUSCHED_SPA_SVR
+	depends on CPUSCHED_SPA_SVR
 	---help---
 	  This is a scheduler with a O(1) single priority array intended for
 	  use on server.  It has modifications to reduce CPU delay at moderate
@@ -313,7 +313,7 @@ config CPUSCHED_DEFAULT_SPA_SVR
 
 config CPUSCHED_DEFAULT_ZAPHOD
 	bool "Zaphod cpu scheduler"
-	select CPUSCHED_ZAPHOD
+	depends on CPUSCHED_ZAPHOD
 	---help---
 	  This scheduler is an O(1) single priority array with interactive
 	  bonus, throughput bonus, soft and hard CPU rate caps and a runtime
@@ -322,7 +322,7 @@ config CPUSCHED_DEFAULT_ZAPHOD
 
 config CPUSCHED_DEFAULT_NICK
 	bool "Nicksched cpu scheduler"
-	select CPUSCHED_NICK
+	depends on CPUSCHED_NICK
 	---help---
 	  This is the default cpu scheduler which is an O(1) dual priority
 	  array scheduler with a hybrid interactive design as modified by
@@ -358,7 +358,7 @@ config CPUSCHED_STAIRCASE
 	  To boot this cpu scheduler, if it is not the default, use the
 	  bootparam "cpusched=staircase".
 
-config CPUSCHED_SPA
+menuconfig CPUSCHED_SPA
 	bool "SPA cpu schedulers" if EMBEDDED
 	depends on PLUGSCHED
 	default y
@@ -366,9 +366,7 @@ config CPUSCHED_SPA
 	  Support for O(1) single priority array schedulers.
 
 config CPUSCHED_SPA_NF
-	bool "SPA cpu scheduler (no frills)" if EMBEDDED
-	depends on PLUGSCHED
-	select CPUSCHED_SPA
+	bool "SPA cpu scheduler (no frills)" if CPUSCHED_SPA
 	default y
 	---help---
 	  This scheduler is a simple round robin O(1) single priority array
@@ -379,9 +377,7 @@ config CPUSCHED_SPA_NF
 	  bootparam "cpusched=spa_no_frills".
 
 config CPUSCHED_SPA_WS
-	bool "SPA cpu scheduler (work station)" if EMBEDDED
-	depends on PLUGSCHED
-	select CPUSCHED_SPA
+	bool "SPA cpu scheduler (work station)" if CPUSCHED_SPA
 	default y
 	---help---
 	  This is a scheduler with a O(1) single priority array intended for
@@ -391,9 +387,7 @@ config CPUSCHED_SPA_WS
 	  bootparam "cpusched=spa_ws".
 
 config CPUSCHED_SPA_SVR
-	bool "SPA cpu scheduler (server)" if EMBEDDED
-	depends on PLUGSCHED
-	select CPUSCHED_SPA
+	bool "SPA cpu scheduler (server)" if CPUSCHED_SPA
 	default y
 	---help---
 	  This is a scheduler with a O(1) single priority array intended for
@@ -403,9 +397,7 @@ config CPUSCHED_SPA_SVR
 	  bootparam "cpusched=spa_svr".
 
 config CPUSCHED_ZAPHOD
-	bool "Zaphod cpu scheduler" if EMBEDDED
-	depends on PLUGSCHED
-	select CPUSCHED_SPA
+	bool "Zaphod cpu scheduler" if CPUSCHED_SPA
 	default y
 	---help---
 	  This scheduler is an O(1) single priority array with interactive

--Boundary-00=_9pAdDZU0sLBR6Zi--
