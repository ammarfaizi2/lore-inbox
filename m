Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbUCURky (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 12:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbUCURky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 12:40:54 -0500
Received: from holomorphy.com ([207.189.100.168]:56972 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263628AbUCURkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 12:40:53 -0500
Date: Sun, 21 Mar 2004 09:40:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm1
Message-ID: <20040321174050.GY2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040321015412.491cd2cd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040321015412.491cd2cd.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 01:54:12AM -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc2/2.6.5-rc2-mm1/
> - Dave Jones's agpgart and cpufreq trees will henceforth be included in -mm
>   kernels.
> - Various speedups, cleanups and fixes to the writeback, ext2 and ext3 code.
> - The usual bunch of random fixes

The following oddity needs a fixup to properly interact with PG_compound.
It's trying to partially free "unused" pieces of a higher-order page.
OTOH, who knows if this thing even compiles anymore.


Index: mm2-2.6.5-rc2-1/drivers/video/acornfb.c
===================================================================
--- mm2-2.6.5-rc2-1.orig/drivers/video/acornfb.c	2004-03-19 16:11:51.000000000 -0800
+++ mm2-2.6.5-rc2-1/drivers/video/acornfb.c	2004-03-21 09:22:59.000000000 -0800
@@ -1343,10 +1343,6 @@
 		/* Mark the framebuffer pages as reserved so mmap will work. */
 		for (page = base; page < PAGE_ALIGN(base + size); page += PAGE_SIZE)
 			SetPageReserved(virt_to_page(page));
-		/* Hand back any excess pages that we allocated. */
-		for (page = base + size; page < top; page += PAGE_SIZE)
-			free_page(page);
-
 		fb_info.screen_base = (char *)base;
 		fb_info.fix.smem_start = virt_to_phys(fb_info.screen_base);
 	}
