Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269144AbUIYHIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269144AbUIYHIj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 03:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269205AbUIYHIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 03:08:35 -0400
Received: from holomorphy.com ([207.189.100.168]:50149 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269144AbUIYHIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 03:08:25 -0400
Date: Sat, 25 Sep 2004 00:08:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 6/76] convert zr36120.c to use remap_pfn_range()
Message-ID: <20040925070820.GB9106@holomorphy.com>
References: <20040925065335.GV9106@holomorphy.com> <20040925065816.GW9106@holomorphy.com> <20040925065959.GX9106@holomorphy.com> <20040925070151.GY9106@holomorphy.com> <20040925070346.GZ9106@holomorphy.com> <20040925070536.GA9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925070536.GA9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 12:05:36AM -0700, William Lee Irwin III wrote:
> Convert the IGA 1682 framebuffer driver to use remap_pfn_range().

Conver the Zoran 36120/36125 framegrabber driver to use remap_pfn_range().

Index: mm3-2.6.9-rc2/drivers/media/video/zr36120.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/media/video/zr36120.c	2004-09-24 17:37:19.000000000 -0700
+++ mm3-2.6.9-rc2/drivers/media/video/zr36120.c	2004-09-24 22:10:34.377593616 -0700
@@ -1474,8 +1474,8 @@
 	/* start mapping the whole shabang to user memory */
 	pos = (unsigned long)ztv->fbuffer;
 	while (size>0) {
-		unsigned long page = virt_to_phys((void*)pos);
-		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
+		unsigned long pfn = virt_to_phys((void*)pos) >> PAGE_SHIFT;
+		if (remap_pfn_range(vma, start, pfn, PAGE_SIZE, PAGE_SHARED))
 			return -EAGAIN;
 		start += PAGE_SIZE;
 		pos += PAGE_SIZE;
