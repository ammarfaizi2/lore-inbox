Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266310AbVBDTtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbVBDTtd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 14:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263822AbVBDTp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:45:27 -0500
Received: from holomorphy.com ([66.93.40.71]:45257 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266363AbVBDTnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 14:43:04 -0500
Date: Fri, 4 Feb 2005 11:42:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Mr. Berkley Shands" <bshands@exegy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 Kernel BUG at hugetlbpage:212 (x86_64 and i386)
Message-ID: <20050204194255.GO24805@holomorphy.com>
References: <42023352.9040309@dssimail.com> <Pine.LNX.4.61.0502041634090.10535@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502041634090.10535@goblin.wat.veritas.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 04:39:02PM +0000, Hugh Dickins wrote:
> Patch below (against 2.6.11-rc3, applies at offset to 2.6.10) fixes
> the unmap_hugepage_range BUGs I could generate: does it fix yours?
> The hugetlb_page test in do_munmap is too permissive.  It checks start
> vma, but forgets that end vma might be different and huge though start
> is not: so hits unmap_hugepage_range BUG if misaligned end was given.
> And it's too restrictive: munmap has always succeeded on unmapped areas
> within its range, why should it behave differently near a hugepage vma?
> And the additional checks in is_aligned_hugepage_range are irrelevant
> here, when the hugepage vma already exists.  But the function is still
> required (on some arches), as the default for prepare_hugepage_range -
> leave renaming cleanup to another occasion.
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

As usual, excellent work. Thanks for fixing this up.

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
