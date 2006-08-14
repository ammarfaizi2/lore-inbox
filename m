Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751981AbWHNKSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbWHNKSn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 06:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbWHNKSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 06:18:43 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:13546 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751981AbWHNKSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 06:18:42 -0400
Date: Mon, 14 Aug 2006 18:18:39 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, okuji@enbug.org
Subject: Re: [PATCH] failslab - failmalloc for slab allocator
Message-ID: <20060814101839.GA8049@miraclelinux.com>
References: <20060813102219.GA8784@miraclelinux.com> <20060813121702.78e72c1a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813121702.78e72c1a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 12:17:02PM -0700, Andrew Morton wrote:
> We would benefit from having some faul-injection capabilities in the
> mainline kernel.
> 
> - kmalloc failures
> 
> - alloc_pages() failures
> 
> - disk IO errors (there are rumours of a DM module for this, but I
>   haven't seen it).

What shold I do for this?
Should we have faul-injection capability in generic_make_request()
like this patch?

Index: work-failmalloc/block/ll_rw_blk.c
===================================================================
--- work-failmalloc.orig/block/ll_rw_blk.c
+++ work-failmalloc/block/ll_rw_blk.c
@@ -3077,6 +3077,9 @@ end_io:
 		if (unlikely(test_bit(QUEUE_FLAG_DEAD, &q->queue_flags)))
 			goto end_io;
 
+		if (should_fail(&fail_make_request, bio->bi_size))
+			goto end_io;
+
 		/*
 		 * If this device has partitions, remap block n
 		 * of partition p to block n+start(p) of the disk.


> They would need to be lightweight, clean and enabled/configured at runtime,
> not at boot time.

I'll make it configurable at runtime with using debugfs.

