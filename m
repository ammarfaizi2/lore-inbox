Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263632AbTCUO7E>; Fri, 21 Mar 2003 09:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263633AbTCUO7E>; Fri, 21 Mar 2003 09:59:04 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:16018 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S263632AbTCUO7D>; Fri, 21 Mar 2003 09:59:03 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 21 Mar 2003 16:18:27 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5 vm bugfix
Message-ID: <20030321151827.GA9387@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

2.5.x kernels don't look at the VM_DONTEXPAND flag when merging
multiple vmas into one.  Fix below.

  Gerd

--- linux-2.5.65/mm/mmap.c	2003-03-21 13:03:28.377764776 +0100
+++ linux/mm/mmap.c	2003-03-21 13:09:52.981296152 +0100
@@ -379,6 +379,8 @@
 can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
 	struct file *file, unsigned long vm_pgoff, unsigned long size)
 {
+	if ((vma->vm_flags & VM_DONTEXPAND) || (vm_flags & VM_DONTEXPAND))
+		return 0;
 	if (vma->vm_file == file && vma->vm_flags == vm_flags) {
 		if (!file)
 			return 1;	/* anon mapping */
@@ -396,6 +398,8 @@
 can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
 	struct file *file, unsigned long vm_pgoff)
 {
+	if ((vma->vm_flags & VM_DONTEXPAND) || (vm_flags & VM_DONTEXPAND))
+		return 0;
 	if (vma->vm_file == file && vma->vm_flags == vm_flags) {
 		unsigned long vma_size;
 
