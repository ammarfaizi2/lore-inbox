Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbTF1Ud7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 16:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbTF1Ud7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 16:33:59 -0400
Received: from arbi.Informatik.uni-oldenburg.de ([134.106.1.7]:51986 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id S265395AbTF1Ud6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 16:33:58 -0400
Subject: Patch 2.4.21 fix use of pid in capabillity.c
To: linux-kernel@vger.kernel.org
Date: Sat, 28 Jun 2003 22:48:13 +0200 (MEST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19WMcH-000CqP-00@grossglockner.Informatik.Uni-Oldenburg.DE>
From: "Walter Harms" <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi liste,
this is a small patch to fix functions that do not use the 
correct type for pid. daniele bellucci and i have worked this 
out. 

walter


--- kernel/capability.c.org	2003-06-25 22:27:44.000000000 +0200
+++ kernel/capability.c	2003-06-25 22:32:08.000000000 +0200
@@ -21,7 +21,8 @@
 
 asmlinkage long sys_capget(cap_user_header_t header, cap_user_data_t dataptr)
 {
-     int error, pid;
+     int error;
+     pid_t pid;
      __u32 version;
      struct task_struct *target;
      struct __user_cap_data_struct data;
@@ -131,7 +132,8 @@
      kernel_cap_t inheritable, permitted, effective;
      __u32 version;
      struct task_struct *target;
-     int error, pid;
+     int error;
+     pid_t pid;
 
      if (get_user(version, &header->version))
 	     return -EFAULT; 
-- 
