Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266132AbUGARBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266132AbUGARBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 13:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUGAQ7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:59:51 -0400
Received: from holomorphy.com ([207.189.100.168]:19384 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266157AbUGAQ5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:57:08 -0400
Date: Thu, 1 Jul 2004 09:56:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Gibson <david@gibson.dropbear.id.au>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] hugetlb MAP_PRIVATE mapping vs /dev/zero
Message-ID: <20040701165655.GA21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@osdl.org>
References: <40E43BDE.85C5D670@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E43BDE.85C5D670@tv-sign.ru>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 08:29:18PM +0400, Oleg Nesterov wrote:
> Hugetlbfs mmap with MAP_PRIVATE becomes MAP_SHARED
> silently, but vma->vm_flags have no VM_SHARED bit.
> I think it make sense to forbid MAP_PRIVATE in
> hugetlbfs_file_mmap() because it may confuse user
> space applications. But the real bug is that reading
> from /dev/zero into hugetlb will do:
> read_zero()
> 	read_zero_pagealigned()
> 		if (vma->vm_flags & VM_SHARED)
> 			break;	// OK if MAP_PRIVATE
> 		zap_page_range();
> 		zeromap_page_range();
> We can fix hugetlbfs_file_mmap() or read_zero_pagealigned()
> or both.

Best to fix hugetlbfs_file_mmap().


-- wli
