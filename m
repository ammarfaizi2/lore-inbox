Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269259AbUIYHEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269259AbUIYHEa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 03:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269255AbUIYHD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 03:03:58 -0400
Received: from holomorphy.com ([207.189.100.168]:48101 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269256AbUIYHDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 03:03:51 -0400
Date: Sat, 25 Sep 2004 00:03:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 4/76] convert sgivwfb.c to use remap_pfn_range()
Message-ID: <20040925070346.GZ9106@holomorphy.com>
References: <20040925065335.GV9106@holomorphy.com> <20040925065816.GW9106@holomorphy.com> <20040925065959.GX9106@holomorphy.com> <20040925070151.GY9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925070151.GY9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 12:01:51AM -0700, William Lee Irwin III wrote:
> Conver the SGI GBE framebuffer driver to use remap_pfn_range().

Convert the SGI DBE framebuffer driver to use remap_pfn_range().


Index: mm3-2.6.9-rc2/drivers/video/sgivwfb.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/video/sgivwfb.c	2004-09-24 02:10:27.000000000 -0700
+++ mm3-2.6.9-rc2/drivers/video/sgivwfb.c	2004-09-24 22:08:57.675294600 -0700
@@ -719,8 +719,8 @@
 	pgprot_val(vma->vm_page_prot) =
 	    pgprot_val(vma->vm_page_prot) | _PAGE_PCD;
 	vma->vm_flags |= VM_IO;
-	if (remap_page_range
-	    (vma, vma->vm_start, offset, size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start, offset >> PAGE_SHIFT,
+						size, vma->vm_page_prot))
 		return -EAGAIN;
 	vma->vm_file = file;
 	printk(KERN_DEBUG "sgivwfb: mmap framebuffer P(%lx)->V(%lx)\n",
