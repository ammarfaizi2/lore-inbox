Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbUKJEya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbUKJEya (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 23:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUKJEya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 23:54:30 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:8389 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S261878AbUKJEyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 23:54:11 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] 2.6.10-rc1-mm4 xircom_tulip_cb.c doesn't compile
Date: Wed, 10 Nov 2004 05:48:49 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_x2ZkBpg6PbgiQo0"
Message-Id: <200411100548.49627.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_x2ZkBpg6PbgiQo0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

SSIA, fix attached.

LLaP
bero

--Boundary-00=_x2ZkBpg6PbgiQo0
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.10-rc1-mm4-compile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.10-rc1-mm4-compile.patch"

--- linux-2.6.9/drivers/net/tulip/xircom_tulip_cb.c.ark	2004-11-10 05:06:58.000000000 +0100
+++ linux-2.6.9/drivers/net/tulip/xircom_tulip_cb.c	2004-11-10 05:17:48.000000000 +0100
@@ -33,6 +33,13 @@
 
 /* A few user-configurable values. */
 
+#define xircom_debug debug
+#ifdef XIRCOM_DEBUG
+static int xircom_debug = XIRCOM_DEBUG;
+#else
+static int xircom_debug = 1;
+#endif
+
 /* Maximum events (Rx packets, etc.) to handle at each interrupt. */
 static int max_interrupt_work = 25;
 
@@ -125,18 +132,11 @@
 module_param(csr0, int, 0);
 
 static int num_units;
-module_param_array(options, num_units, int, 0);
-module_param_array(full_duplex, num_units, int, 0);
+module_param_array(options, int, &num_units, 0);
+module_param_array(full_duplex, int, &num_units, 0);
 
 #define RUN_AT(x) (jiffies + (x))
 
-#define xircom_debug debug
-#ifdef XIRCOM_DEBUG
-static int xircom_debug = XIRCOM_DEBUG;
-#else
-static int xircom_debug = 1;
-#endif
-
 /*
 				Theory of Operation
 

--Boundary-00=_x2ZkBpg6PbgiQo0--
