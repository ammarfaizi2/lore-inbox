Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVCUN0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVCUN0s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 08:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVCUN0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 08:26:48 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:55250 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261785AbVCUN0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 08:26:04 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050321125803.16446.51663.69576@clementine.local>
Subject: [PATCH] arlan: MODULE_PARM_DESC
Date: Mon, 21 Mar 2005 14:26:03 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some module parameter descriptions should only be present when debugging is
enabled, ie when ARLAN_ENTRY_EXIT_DEBUGGING is defined. The patch fixes this
and adds "arlan_entry_and_exit_debug" that was missing.

Error detected with section2text.rb, see autoparam patch. 

Signed-off-by: Magnus Damm <damm@opensource.se>

--- linux-2.6.12-rc1/drivers/net/wireless/arlan-main.c	2005-03-20 18:09:15.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/drivers/net/wireless/arlan-main.c	2005-03-21 13:39:53.288470352 +0100
@@ -33,8 +33,6 @@
 
 #ifdef ARLAN_DEBUGGING
 
-static int arlan_entry_debug;
-static int arlan_exit_debug;
 static int testMemory = testMemoryUNKNOWN;
 static int irq = irqUNKNOWN;
 static int txScrambled = 1;
@@ -43,8 +41,6 @@
 module_param(irq, int, 0);
 module_param(mdebug, int, 0);
 module_param(testMemory, int, 0);
-module_param(arlan_entry_debug, int, 0);
-module_param(arlan_exit_debug, int, 0);
 module_param(txScrambled, int, 0);
 MODULE_PARM_DESC(irq, "(unused)");
 MODULE_PARM_DESC(testMemory, "(unused)");
@@ -67,13 +63,15 @@
 MODULE_PARM_DESC(arlan_debug, "Arlan debug enable (0-1)");
 MODULE_PARM_DESC(retries, "Arlan maximum packet retransmisions");
 #ifdef ARLAN_ENTRY_EXIT_DEBUGGING
+static int arlan_entry_debug;
+static int arlan_exit_debug;
+static int arlan_entry_and_exit_debug;
+module_param(arlan_entry_debug, int, 0);
+module_param(arlan_exit_debug, int, 0);
+module_param(arlan_entry_and_exit_debug, int, 0);
 MODULE_PARM_DESC(arlan_entry_debug, "Arlan driver function entry debugging");
 MODULE_PARM_DESC(arlan_exit_debug, "Arlan driver function exit debugging");
 MODULE_PARM_DESC(arlan_entry_and_exit_debug, "Arlan driver function entry and exit debugging");
-#else
-MODULE_PARM_DESC(arlan_entry_debug, "(ignored)");
-MODULE_PARM_DESC(arlan_exit_debug, "(ignored)");
-MODULE_PARM_DESC(arlan_entry_and_exit_debug, "(ignored)");
 #endif
 
 struct arlan_conf_stru arlan_conf[MAX_ARLANS];
