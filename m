Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbTDTSNu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263656AbTDTSNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:13:50 -0400
Received: from hera.cwi.nl ([192.16.191.8]:46776 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263655AbTDTSNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:13:47 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 20 Apr 2003 20:25:47 +0200 (MEST)
Message-Id: <UTC200304201825.h3KIPlr18093.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] compilation fix: spin_lock_irqsave uses unsigned long
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
--- a/drivers/block/paride/pcd.c	Tue Apr  8 09:36:36 2003
+++ b/drivers/block/paride/pcd.c	Sun Apr 20 19:55:24 2003
@@ -761,7 +761,7 @@
 
 static inline void next_request(int success)
 {
-	long saved_flags;
+	unsigned long saved_flags;
 
 	spin_lock_irqsave(&pcd_lock, saved_flags);
 	end_request(pcd_req, success);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
--- a/drivers/block/paride/pd.c	Tue Apr  8 09:36:36 2003
+++ b/drivers/block/paride/pd.c	Sun Apr 20 19:54:47 2003
@@ -757,7 +757,7 @@
 
 static int pd_next_buf(void)
 {
-	long saved_flags;
+	unsigned long saved_flags;
 
 	pd_count--;
 	pd_run--;
@@ -777,7 +777,7 @@
 
 static inline void next_request(int success)
 {
-	long saved_flags;
+	unsigned long saved_flags;
 
 	spin_lock_irqsave(&pd_lock, saved_flags);
 	end_request(pd_req, success);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
--- a/drivers/block/paride/pf.c	Sun Apr 20 12:59:31 2003
+++ b/drivers/block/paride/pf.c	Sun Apr 20 19:57:04 2003
@@ -812,7 +812,7 @@
 
 static int pf_next_buf(void)
 {
-	long saved_flags;
+	unsigned long saved_flags;
 
 	pf_count--;
 	pf_run--;
@@ -832,7 +832,8 @@
 
 static inline void next_request(int success)
 {
-	long saved_flags;
+	unsigned long saved_flags;
+
 	spin_lock_irqsave(&pf_spin_lock, saved_flags);
 	end_request(pf_req, success);
 	pf_busy = 0;
