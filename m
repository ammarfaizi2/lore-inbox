Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269810AbRHDGLR>; Sat, 4 Aug 2001 02:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269812AbRHDGLH>; Sat, 4 Aug 2001 02:11:07 -0400
Received: from tsukuba.m17n.org ([192.47.44.130]:18841 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S269811AbRHDGKz>;
	Sat, 4 Aug 2001 02:10:55 -0400
Date: Sat, 4 Aug 2001 15:10:47 +0900 (JST)
Message-Id: <200108040610.f746AlJ19336@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: linux-kernel@vger.kernel.org
Subject: The interface of flush_cache_page
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the interface is like this:

void flush_cache_page(struct vm_area_struct *vma, unsigned long address)

This doesn't work well for (virtuall indexed) physically tagged
architecture.

When it is called from vmscan.c:try_to_swap_out, as the PTE is cleared
to be zero, we have no way to know what phisical address to match.

How about adding argument: struct page *page?  With that, we have
information of physical memory.
-- 
