Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275485AbTHJJGL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 05:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275487AbTHJJGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 05:06:11 -0400
Received: from waste.org ([209.173.204.2]:20111 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S275485AbTHJJGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 05:06:07 -0400
Date: Sun, 10 Aug 2003 04:05:56 -0500
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@redhat.com>
Cc: "YOSHIFUJI Hideaki / _$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       linux-kernel@vger.kernel.org
Subject: Re: virt_to_offset() (Re: [RFC][PATCH] Make cryptoapi non-optional?)
Message-ID: <20030810090556.GY31810@waste.org>
References: <20030809194627.GV31810@waste.org> <20030809131715.17a5be2e.davem@redhat.com> <20030810081529.GX31810@waste.org> <20030810.173215.102258218.yoshfuji@linux-ipv6.org> <20030810013041.679ddc4c.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810013041.679ddc4c.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 01:30:41AM -0700, David S. Miller wrote:
> On Sun, 10 Aug 2003 17:32:15 +0900 (JST)
> YOSHIFUJI Hideaki / _$B5HF#1QL@ <yoshfuji@linux-ipv6.org> wrote:
> 
> > BTW, we spread ((long) ptr & ~PAGE_MASK); it seems ugly.
> > Why don't we have vert_to_offset(ptr) or something like this?
> > #define virt_to_offset(ptr) ((unsigned long) (ptr) & ~PAGE_MASK)
> > Is this bad idea?
> 
> With some name like "virt_to_pageoff()" it sounds like a great
> idea.

Had the same thought. Nowhere good to stick it, so I put it in mm.

diff -urN -X dontdiff orig/include/linux/mm.h work/include/linux/mm.h
--- orig/include/linux/mm.h	2003-08-10 03:16:39.000000000 -0500
+++ work/include/linux/mm.h	2003-08-10 04:03:25.000000000 -0500
@@ -400,6 +400,8 @@
 #define VM_FAULT_MINOR	1
 #define VM_FAULT_MAJOR	2
 
+#define virt_to_pageoff(p) ((unsigned long)(p) & ~PAGE_MASK)
+
 extern void show_free_areas(void);
 
 struct page *shmem_nopage(struct vm_area_struct * vma,


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
