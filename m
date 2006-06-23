Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751945AbWFWTEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbWFWTEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbWFWTEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:04:13 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:54223 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751945AbWFWTDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:03:52 -0400
Message-Id: <20060623185824.580412000@klappe.arndb.de>
References: <20060623185746.037897000@klappe.arndb.de>
Date: Fri, 23 Jun 2006 20:57:47 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/5] spufs: map mmio space as guarded into user space
Content-Disposition: inline; filename=spufs-map-guarded.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This fixes a bug where we don't properly map SPE MMIO space as guarded,
causing various test cases to fail, probably due to write combining and other
niceties caused by the lack of the G bit.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linus-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -204,7 +204,7 @@ static int spufs_cntl_mmap(struct file *
 
 	vma->vm_flags |= VM_RESERVED;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-				     | _PAGE_NO_CACHE);
+				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
 	vma->vm_ops = &spufs_cntl_mmap_vmops;
 	return 0;
@@ -675,7 +675,7 @@ static int spufs_signal1_mmap(struct fil
 
 	vma->vm_flags |= VM_RESERVED;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-				     | _PAGE_NO_CACHE);
+				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
 	vma->vm_ops = &spufs_signal1_mmap_vmops;
 	return 0;
@@ -762,7 +762,7 @@ static int spufs_signal2_mmap(struct fil
 	/* FIXME: */
 	vma->vm_flags |= VM_RESERVED;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-				     | _PAGE_NO_CACHE);
+				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
 	vma->vm_ops = &spufs_signal2_mmap_vmops;
 	return 0;
@@ -850,7 +850,7 @@ static int spufs_mss_mmap(struct file *f
 
 	vma->vm_flags |= VM_RESERVED;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-				     | _PAGE_NO_CACHE);
+				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
 	vma->vm_ops = &spufs_mss_mmap_vmops;
 	return 0;
@@ -899,7 +899,7 @@ static int spufs_mfc_mmap(struct file *f
 
 	vma->vm_flags |= VM_RESERVED;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-				     | _PAGE_NO_CACHE);
+				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
 	vma->vm_ops = &spufs_mfc_mmap_vmops;
 	return 0;

--

