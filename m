Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264731AbTIJIJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbTIJIJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:09:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:16541 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264731AbTIJIJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:09:53 -0400
Date: Wed, 10 Sep 2003 13:46:57 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: How reliable is SLAB_HWCACHE_ALIGN?
Message-ID: <20030910081654.GA1129@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was assuming that if you create a slab cache with SLAB_HWCACHE_ALIGN,
objects are guaranteed to be aligned to L1 cacheline.  But this piece
of code in kmem_cache_create has raised doubts.

----------------------------------------------------------------------------
        if (flags & SLAB_HWCACHE_ALIGN) {
                /* Need to adjust size so that objs are cache aligned. */
                /* Small obj size, can get at least two per cache line. */
                while (size < align/2)
                        align /= 2;
                size = (size+align-1)&(~(align-1));
        }
----------------------------------------------------------------------------

Am I missing something or can there really be two objects on the same 
cacheline even when SLAB_HWCACHE_ALIGN is specified?

Thanks,
Kiran
