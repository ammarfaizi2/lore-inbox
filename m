Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265778AbUGBBYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265778AbUGBBYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 21:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbUGBBYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 21:24:32 -0400
Received: from ozlabs.org ([203.10.76.45]:45231 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265778AbUGBBYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 21:24:30 -0400
Date: Fri, 2 Jul 2004 11:20:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] hugetlb MAP_PRIVATE mapping vs /dev/zero
Message-ID: <20040702012012.GC5937@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <40E43BDE.85C5D670@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E43BDE.85C5D670@tv-sign.ru>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 08:29:18PM +0400, Oleg Nesterov wrote:
> Hello.
> 
> Hugetlbfs mmap with MAP_PRIVATE becomes MAP_SHARED
> silently, but vma->vm_flags have no VM_SHARED bit.
> I think it make sense to forbid MAP_PRIVATE in
> hugetlbfs_file_mmap() because it may confuse user
> space applications. But the real bug is that reading
> from /dev/zero into hugetlb will do:
> 
> read_zero()
> 	read_zero_pagealigned()
> 		if (vma->vm_flags & VM_SHARED)
> 			break;	// OK if MAP_PRIVATE
> 		zap_page_range();
> 		zeromap_page_range();
> 
> We can fix hugetlbfs_file_mmap() or read_zero_pagealigned()
> or both.

Err... surely we need to fix both, yes?

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
