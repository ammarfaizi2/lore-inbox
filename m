Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbUCNBl6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 20:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbUCNBl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 20:41:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36584 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263241AbUCNBl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 20:41:57 -0500
Date: Sat, 13 Mar 2004 20:41:42 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040314011920.GG655@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0403132039340.15971-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2004, William Lee Irwin III wrote:

> [hugetlb at same address]

Well, we can find this merely by looking at the page tables
themselves, so that shouldn't be a problem.

> Searching the COW sharing group isn't how everything works, but in those
> cases where additionally you can find mm's that don't map the page at
> that virtual address and may have different vmas cover it, this can
> arise.

This could only happen when you truncate a file that's
been mapped by various nonlinear VMAs, so truncate can't
get rid of the pages...

I suspect there are two ways to fix that:
1) on truncate, scan ALL the ptes inside nonlinear VMAs
   and remove the pages
2) don't allow truncate on a file that's mapped with
   nonlinear VMAs

Either would work.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

