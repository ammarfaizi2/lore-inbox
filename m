Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVHWVur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVHWVur (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVHWVn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:43:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8374 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932434AbVHWVnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:43:53 -0400
To: torvalds@osdl.org
Subject: [PATCH] (26/43) alpha gcc4 warnings
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gbg-0007Ce-Uv@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on UP smp_call_function() is expanded to expression.  Alpha oprofile
calls that puppy and ignores the return value.  And has -Werror for
arch/*...

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-envctrl/arch/alpha/oprofile/common.c RC13-rc6-git13-alpha-warnings/arch/alpha/oprofile/common.c
--- RC13-rc6-git13-envctrl/arch/alpha/oprofile/common.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-alpha-warnings/arch/alpha/oprofile/common.c	2005-08-21 13:17:09.000000000 -0400
@@ -65,7 +65,7 @@
 	model->reg_setup(&reg, ctr, &sys);
 
 	/* Configure the registers on all cpus.  */
-	smp_call_function(model->cpu_setup, &reg, 0, 1);
+	(void)smp_call_function(model->cpu_setup, &reg, 0, 1);
 	model->cpu_setup(&reg);
 	return 0;
 }
@@ -86,7 +86,7 @@
 static int
 op_axp_start(void)
 {
-	smp_call_function(op_axp_cpu_start, NULL, 0, 1);
+	(void)smp_call_function(op_axp_cpu_start, NULL, 0, 1);
 	op_axp_cpu_start(NULL);
 	return 0;
 }
@@ -101,7 +101,7 @@
 static void
 op_axp_stop(void)
 {
-	smp_call_function(op_axp_cpu_stop, NULL, 0, 1);
+	(void)smp_call_function(op_axp_cpu_stop, NULL, 0, 1);
 	op_axp_cpu_stop(NULL);
 }
 
