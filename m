Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUCSOiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 09:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUCSOiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 09:38:13 -0500
Received: from holomorphy.com ([207.189.100.168]:35716 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261891AbUCSOiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 09:38:11 -0500
Date: Fri, 19 Mar 2004 06:38:08 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <20040319143808.GP2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0403182317050.16911-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403182317050.16911-100000@localhost.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 11:21:07PM +0000, Hugh Dickins wrote:
> First of six patches implementing full object-based rmap over 2.6.5-rc1,
> reviving my anonmm method to compare against Andrea's anon_vma method.
> I've not yet implemented Linus' early-COW solution to the mremap move
> issue, that will follow; handling of non-linear obj vmas also to follow.
> Sorry, not yet checked against wli's tree, he may have some fixes to it.

It would actually take serious rereading to verify that what issues I'd
fixed weren't ones I introduced myself. In that set of patches,
anobjrmap appeared alongside a page allocator rewrite, a top-down vma
allocation policy for i386, an arch/i386/mm/pgtable.c rewrite, wrapping
every modification to userspace ptes to track statistics wanted by
/proc/, highpmd, something that RCU'd inode->i_mmap{,_shared} missing
the needed smp_read_barrier_depends() calls, and using wrappers around
rwlocks to allow mapping->page_lock to be configured as an rwlock or
spinlock at compile-time thrown in for good measure, so there isn't
much of a way to rule out my own hacks. There was even experimental
junk at some point e.g. to remove files_lock in addition to a fair
number of other quetionable/buggy patches I dumped instead of debugging.

The story of that tree is too tortuous and sad to tell. I'll put up a
new tree with a substantially different emphasis, comprised of
completely different patches, when I have enough material to warrant it.


-- wli
