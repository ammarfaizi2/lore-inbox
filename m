Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVKUUno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVKUUno (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVKUUno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:43:44 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:14728 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932463AbVKUUn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:43:26 -0500
Date: Mon, 21 Nov 2005 12:43:12 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: ak@suse.de, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20051121204312.10630.45598.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051121204301.10630.76569.sendpatchset@schroedinger.engr.sgi.com>
References: <20051121204301.10630.76569.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 3/4] mempolicies: unexport get_vma_policy()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the numa_maps functionality is now in mempolicy.c we no longer
need to export get_vma_policy().

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc1-mm2/mm/mempolicy.c
===================================================================
--- linux-2.6.15-rc1-mm2.orig/mm/mempolicy.c	2005-11-21 12:39:54.000000000 -0800
+++ linux-2.6.15-rc1-mm2/mm/mempolicy.c	2005-11-21 12:40:38.000000000 -0800
@@ -943,8 +943,8 @@ asmlinkage long compat_sys_mbind(compat_
 #endif
 
 /* Return effective policy for a VMA */
-struct mempolicy *
-get_vma_policy(struct task_struct *task, struct vm_area_struct *vma, unsigned long addr)
+static struct mempolicy * get_vma_policy(struct task_struct *task,
+		struct vm_area_struct *vma, unsigned long addr)
 {
 	struct mempolicy *pol = task->mempolicy;
 
Index: linux-2.6.15-rc1-mm2/include/linux/mempolicy.h
===================================================================
--- linux-2.6.15-rc1-mm2.orig/include/linux/mempolicy.h	2005-11-21 12:11:07.000000000 -0800
+++ linux-2.6.15-rc1-mm2/include/linux/mempolicy.h	2005-11-21 12:40:06.000000000 -0800
@@ -144,9 +144,6 @@ void mpol_free_shared_policy(struct shar
 struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 					    unsigned long idx);
 
-struct mempolicy *get_vma_policy(struct task_struct *task,
-			struct vm_area_struct *vma, unsigned long addr);
-
 extern void numa_default_policy(void);
 extern void numa_policy_init(void);
 extern void numa_policy_rebind(const nodemask_t *old, const nodemask_t *new);
