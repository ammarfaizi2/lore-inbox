Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269031AbUIYHFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269031AbUIYHFs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 03:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269144AbUIYHFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 03:05:48 -0400
Received: from holomorphy.com ([207.189.100.168]:49125 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269031AbUIYHFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 03:05:40 -0400
Date: Sat, 25 Sep 2004 00:05:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 5/76] convert igafb.c to use remap_pfn_range()
Message-ID: <20040925070536.GA9106@holomorphy.com>
References: <20040925065335.GV9106@holomorphy.com> <20040925065816.GW9106@holomorphy.com> <20040925065959.GX9106@holomorphy.com> <20040925070151.GY9106@holomorphy.com> <20040925070346.GZ9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925070346.GZ9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 12:03:46AM -0700, William Lee Irwin III wrote:
> Convert the SGI DBE framebuffer driver to use remap_pfn_range().

Convert the IGA 1682 framebuffer driver to use remap_pfn_range().


Index: mm3-2.6.9-rc2/drivers/video/igafb.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/video/igafb.c	2004-09-24 17:37:14.000000000 -0700
+++ mm3-2.6.9-rc2/drivers/video/igafb.c	2004-09-24 22:09:34.845643848 -0700
@@ -262,8 +262,8 @@
 		pgprot_val(vma->vm_page_prot) &= ~(par->mmap_map[i].prot_mask);
 		pgprot_val(vma->vm_page_prot) |= par->mmap_map[i].prot_flag;
 
-		if (remap_page_range(vma, vma->vm_start + page, map_offset,
-				     map_size, vma->vm_page_prot))
+		if (remap_pfn_range(vma, vma->vm_start + page,
+			map_offset >> PAGE_SHIFT, map_size, vma->vm_page_prot))
 			return -EAGAIN;
 
 		page += map_size;
