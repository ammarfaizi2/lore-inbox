Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271480AbRHPEzQ>; Thu, 16 Aug 2001 00:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271478AbRHPEzG>; Thu, 16 Aug 2001 00:55:06 -0400
Received: from trained-monkey.org ([209.217.122.11]:39416 "EHLO
	savage.trained-monkey.org") by vger.kernel.org with ESMTP
	id <S271476AbRHPEzB>; Thu, 16 Aug 2001 00:55:01 -0400
Date: Thu, 16 Aug 2001 00:53:19 -0400
Message-Id: <200108160453.f7G4rJ219579@savage.trained-monkey.org>
From: <jes@trained-monkey.org>
To: alan@redhat.com
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] 64 bit bug in video1394.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

More i2o 64 bit bugs.

Jes

--- drivers/message/i2o/i2o_config.c~	Wed Aug  8 00:08:04 2001
+++ drivers/message/i2o/i2o_config.c	Thu Aug 16 00:50:28 2001
@@ -790,7 +790,7 @@
 	struct i2o_cfg_info *p = NULL;
 	struct i2o_evt_get *uget = (struct i2o_evt_get*)arg;
 	struct i2o_evt_get kget;
-	unsigned int flags;
+	unsigned long flags;
 
 	for(p = open_files; p; p = p->next)
 		if(p->q_id == id)
@@ -819,7 +819,7 @@
 {
 	struct i2o_cfg_info *tmp = 
 		(struct i2o_cfg_info *)kmalloc(sizeof(struct i2o_cfg_info), GFP_KERNEL);
-	unsigned int flags;
+	unsigned long flags;
 
 	if(!tmp)
 		return -ENOMEM;
@@ -845,7 +845,7 @@
 {
 	u32 id = (u32)file->private_data;
 	struct i2o_cfg_info *p1, *p2;
-	unsigned int flags;
+	unsigned long flags;
 
 	lock_kernel();
 	p1 = p2 = NULL;
--- drivers/message/i2o/i2o_core.c~	Wed Aug  8 00:08:04 2001
+++ drivers/message/i2o/i2o_core.c	Thu Aug 16 00:51:26 2001
@@ -890,7 +890,7 @@
 	struct reply_info *reply = (struct reply_info *) reply_data;
 	u32 *msg = reply->msg;
 	struct i2o_controller *c = NULL;
-	int flags;
+	unsigned long flags;
 
 	lock_kernel();
 	daemonize();
@@ -2535,7 +2535,7 @@
 	DECLARE_WAIT_QUEUE_HEAD(wq_i2o_post);
 	int complete = 0;
 	int status;
-	int flags = 0;
+	unsigned long flags = 0;
 	struct i2o_post_wait_data *wait_data =
 		kmalloc(sizeof(struct i2o_post_wait_data), GFP_KERNEL);
 
