Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbTDEKAi (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 05:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbTDEKAi (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 05:00:38 -0500
Received: from holomorphy.com ([66.224.33.161]:39829 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261978AbTDEKAh (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 05:00:37 -0500
Date: Sat, 5 Apr 2003 02:11:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
       Andrew Morton <akpm@digeo.com>, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030405101126.GH993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jamie Lokier <jamie@shareable.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@digeo.com>,
	mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain> <20030404105417.3a8c22cc.akpm@digeo.com> <20030404214547.GB16293@dualathlon.random> <20030404150744.7e213331.akpm@digeo.com> <20030405000352.GF16293@dualathlon.random> <20030404163154.77f19d9e.akpm@digeo.com> <20030405013143.GJ16293@dualathlon.random> <20030404205248.C21819@redhat.com> <20030405022250.GM16293@dualathlon.random> <20030405100113.GA15766@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405100113.GA15766@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 11:01:13AM +0100, Jamie Lokier wrote:
> 1. You missed the "fast" in "fast bochs".
> The idea is to have a file representing the simulated RAM (anything up
> to 64G in size), and to map that the same way as the simulated page tables.
> Then the virtual machine can address the memory directly, which is very fast.
> Doing it your way, the virtual machine would have to do a virtual TLB
> lookup for every memory access, which slows down the simulation considerably.

This is probably the only feasible method of getting general access to
hardware of that kind.


On Sat, Apr 05, 2003 at 11:01:13AM +0100, Jamie Lokier wrote:
> 2. Another use of non-linear mappings is when you want different per
> page memory protections.  In this case you don't need different
> pg_offset per page, you just want to write protect and unprotect
> individual pages.  This comes up in the context of some garbage
> collector algorithms.
> Again, the idea is that the mapping (and in this case SIGSEGV
> handling) costs a little, but it is less than the cost of checking
> each memory access in the main code.

This is a novel use for it that may require an extension to support.
It's worthwhile but I'm terrified enough of the invariants broken by
the code as it stands, even disregarding further extension.


On Sat, Apr 05, 2003 at 11:01:13AM +0100, Jamie Lokier wrote:
> Both of these use many thousands of VMAs when done using mmap().  I
> don't think either of these uses of non-linear mappings are covered by
> your suggestion to use a 64 bit address space.

The 64GB simulation on 64-bit sort of is, but isn't really since the
additional minor faults would be taken with the ordinary mmap()
approach, incurring one or two additional round trips through the
kernel and actually blocking at the time of access instead of pre-
populated (prefaulted). The access is also likely to be sparse which
raises the spectre of pagetable fragmentation yet again...

Thanks for the good insights.


-- wli
