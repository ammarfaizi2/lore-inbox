Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269254AbUIYHAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269254AbUIYHAO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 03:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269257AbUIYHAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 03:00:14 -0400
Received: from holomorphy.com ([207.189.100.168]:46053 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269254AbUIYHAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 03:00:05 -0400
Date: Fri, 24 Sep 2004 23:59:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 2/76] convert atyfb.c to use remap_pfn_range()
Message-ID: <20040925065959.GX9106@holomorphy.com>
References: <20040925065335.GV9106@holomorphy.com> <20040925065816.GW9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925065816.GW9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 11:58:16PM -0700, William Lee Irwin III wrote:
> This patch introduces remap_pfn_range(), destined to replace
> remap_page_range(). In the sequel, the callers of remap_page_range()
> will be converted one at a time.

Convert atyfb.c to use remap_pfn_range(). Here (as in numerous other
cases) shifting the argument right by PAGE_SHIFT suffices.


Index: mm3-2.6.9-rc2/drivers/video/aty/atyfb_base.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/video/aty/atyfb_base.c	2004-09-24 17:37:14.000000000 -0700
+++ mm3-2.6.9-rc2/drivers/video/aty/atyfb_base.c	2004-09-24 22:07:40.573015928 -0700
@@ -1174,8 +1174,8 @@
 		    ~(par->mmap_map[i].prot_mask);
 		pgprot_val(vma->vm_page_prot) |= par->mmap_map[i].prot_flag;
 
-		if (remap_page_range(vma, vma->vm_start + page, map_offset,
-				     map_size, vma->vm_page_prot))
+		if (remap_pfn_range(vma, vma->vm_start + page,
+			map_offset >> PAGE_SHIFT, map_size, vma->vm_page_prot))
 			return -EAGAIN;
 
 		page += map_size;
