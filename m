Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVBKUnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVBKUnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 15:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVBKUnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 15:43:33 -0500
Received: from holomorphy.com ([66.93.40.71]:14227 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262332AbVBKUn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 15:43:29 -0500
Date: Fri, 11 Feb 2005 12:43:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "Mr. Berkley Shands" <bshands@exegy.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] general split_vma hugetlb fix
Message-ID: <20050211204321.GM13009@holomorphy.com>
References: <Pine.LNX.4.61.0502112001070.16247@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502112001070.16247@goblin.wat.veritas.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 08:06:08PM +0000, Hugh Dickins wrote:
> My recent do_munmap hugetlb fix has proved inadequate.  There are
> other places (madvise, mbind, mlock, mprotect) where split_vma is
> called.  Only mprotect excludes a hugetlb vma: the others are in
> danger of splitting at a misaligned address, causing later BUGs.
> So move the ~HPAGE_MASK check from do_munmap to split_vma itself;
> and fix up those places (madvise and mlock) which expect split_vma
> can fail only with -ENOMEM, and wish to convert that to -EAGAIN.
> (It appears genuine that some of these syscalls should be failing
> with -ENOMEM and some with -EAGAIN, so respect those behaviours.)
> madvise_dontneed doesn't use split_vma, but is equally in danger
> of causing a hugetlb BUG via zap_page_range.  Whereas elsewhere the
> patch is permissive (allowing the operation on a hugetlb vma even when
> pointless, so long as it doesn't missplit it), here we must use -EINVAL
> on any hugetlb vma, since a page fault would hit the BUG in its nopage.
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

As usual, excellent work, Hugh. akpm, Linus, please apply.

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
