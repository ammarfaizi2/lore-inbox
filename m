Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbUCNC17 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 21:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbUCNC17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 21:27:59 -0500
Received: from holomorphy.com ([207.189.100.168]:60171 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263253AbUCNC14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 21:27:56 -0500
Date: Sat, 13 Mar 2004 18:27:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
Message-ID: <20040314022742.GH655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Rajesh Venkatasubramanian <vrajesh@umich.edu>,
	linux-kernel@vger.kernel.org
References: <20040314011920.GG655@holomorphy.com> <Pine.LNX.4.44.0403132039340.15971-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403132039340.15971-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2004, William Lee Irwin III wrote:
>> [hugetlb at same address]

On Sat, Mar 13, 2004 at 08:41:42PM -0500, Rik van Riel wrote:
> Well, we can find this merely by looking at the page tables
> themselves, so that shouldn't be a problem.

Pagetables of a kind the core understands may not be present there.
On ia32 one could in theory have a pmd_huge() check, which would in
turn not suffice for ia64 and sparc64 hugetlb. These were only examples.
Other unusual forms of mappings, e.g. VM_RESERVED and VM_IO, may also
be bad ideas to trip over by accident.


On Sat, 13 Mar 2004, William Lee Irwin III wrote:
>> Searching the COW sharing group isn't how everything works, but in those
>> cases where additionally you can find mm's that don't map the page at
>> that virtual address and may have different vmas cover it, this can
>> arise.

On Sat, Mar 13, 2004 at 08:41:42PM -0500, Rik van Riel wrote:
> This could only happen when you truncate a file that's
> been mapped by various nonlinear VMAs, so truncate can't
> get rid of the pages...
> I suspect there are two ways to fix that:
> 1) on truncate, scan ALL the ptes inside nonlinear VMAs
>    and remove the pages
> 2) don't allow truncate on a file that's mapped with
>    nonlinear VMAs
> Either would work.

I'm not sure how that came in. The issue I had in mind was strictly
a matter of tripping over things one can't make sense of from
pagetables alone in try_to_unmap().

COW-shared anonymous pages not unmappable via anonymous COW sharing
groups arising from truncate() vs. remap_file_pages() interactions and
failures to check for nonlinearly-mapped pages in pagetable walkers are
an issue in general of course, but they just aren't this issue.


-- wli
