Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030486AbWBHDTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbWBHDTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbWBHDSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:18:43 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:59776 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751143AbWBHDSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:18:37 -0500
To: torvalds@osdl.org
Subject: [PATCH 09/29] fallout from ptrace consolidation patch: cris/arch-v10
Cc: linux-kernel@vger.kernel.org, starvik@axis.com
Message-Id: <E1F6fqn-0006CD-18@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:18:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138504631 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/cris/arch-v10/kernel/ptrace.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

c350885854c231810c06aa166b46eab039e80d97
diff --git a/arch/cris/arch-v10/kernel/ptrace.c b/arch/cris/arch-v10/kernel/ptrace.c
index f214f74..961c0d5 100644
--- a/arch/cris/arch-v10/kernel/ptrace.c
+++ b/arch/cris/arch-v10/kernel/ptrace.c
@@ -202,18 +202,18 @@ long arch_ptrace(struct task_struct *chi
 		  	int i;
 			unsigned long tmp;
 			
+			ret = 0;
 			for (i = 0; i <= PT_MAX; i++) {
 				tmp = get_reg(child, i);
 				
 				if (put_user(tmp, datap)) {
 					ret = -EFAULT;
-					goto out_tsk;
+					break;
 				}
 				
 				data += sizeof(long);
 			}
 
-			ret = 0;
 			break;
 		}
 
@@ -222,10 +222,11 @@ long arch_ptrace(struct task_struct *chi
 			int i;
 			unsigned long tmp;
 			
+			ret = 0;
 			for (i = 0; i <= PT_MAX; i++) {
 				if (get_user(tmp, datap)) {
 					ret = -EFAULT;
-					goto out_tsk;
+					break;
 				}
 				
 				if (i == PT_DCCR) {
@@ -237,7 +238,6 @@ long arch_ptrace(struct task_struct *chi
 				data += sizeof(long);
 			}
 			
-			ret = 0;
 			break;
 		}
 
-- 
0.99.9.GIT

