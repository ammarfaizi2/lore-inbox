Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268326AbUIQENF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268326AbUIQENF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 00:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUIQENF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 00:13:05 -0400
Received: from [12.177.129.25] ([12.177.129.25]:4292 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268326AbUIQENB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 00:13:01 -0400
Message-Id: <200409170517.i8H5HU2J005387@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - More EINTR protection
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Sep 2004 01:17:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds retrying on EINTR to a couple more places.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/kernel/helper.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/helper.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/helper.c	2004-09-16 23:24:29.000000000 -0400
@@ -132,7 +132,7 @@
 		return(-errno);
 	}
 	if(stack_out == NULL){
-		pid = waitpid(pid, &status, 0);
+		CATCH_EINTR(pid = waitpid(pid, &status, 0));
 		if(pid < 0){
 			printk("run_helper_thread - wait failed, errno = %d\n",
 			       errno);
@@ -151,7 +151,7 @@
 {
 	int ret;
 
-	ret = waitpid(pid, NULL, WNOHANG);
+	CATCH_EINTR(ret = waitpid(pid, NULL, WNOHANG));
 	if(ret < 0){
 		printk("helper_wait : waitpid failed, errno = %d\n", errno);
 		return(-errno);

