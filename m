Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269257AbUIYHCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269257AbUIYHCF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 03:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269260AbUIYHCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 03:02:05 -0400
Received: from holomorphy.com ([207.189.100.168]:47077 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269257AbUIYHB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 03:01:56 -0400
Date: Sat, 25 Sep 2004 00:01:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 3/76] convert gbefb.c to use remap_pfn_range()
Message-ID: <20040925070151.GY9106@holomorphy.com>
References: <20040925065335.GV9106@holomorphy.com> <20040925065816.GW9106@holomorphy.com> <20040925065959.GX9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925065959.GX9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 11:59:59PM -0700, William Lee Irwin III wrote:
> Convert atyfb.c to use remap_pfn_range(). Here (as in numerous other
> cases) shifting the argument right by PAGE_SHIFT suffices.

Conver the SGI GBE framebuffer driver to use remap_pfn_range().


Index: mm3-2.6.9-rc2/drivers/video/gbefb.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/video/gbefb.c	2004-09-24 02:10:27.000000000 -0700
+++ mm3-2.6.9-rc2/drivers/video/gbefb.c	2004-09-24 22:08:19.215141432 -0700
@@ -1018,8 +1018,8 @@
 		else
 			phys_size = TILE_SIZE - offset;
 
-		if (remap_page_range
-		    (vma, addr, phys_addr, phys_size, vma->vm_page_prot))
+		if (remap_pfn_range(vma, addr, phys_addr >> PAGE_SHIFT,
+						phys_size, vma->vm_page_prot))
 			return -EAGAIN;
 
 		offset = 0;
