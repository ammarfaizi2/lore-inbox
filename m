Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUCZTRs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 14:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbUCZTRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 14:17:48 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:47021
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261181AbUCZTRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 14:17:47 -0500
Date: Fri, 26 Mar 2004 20:18:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>, akpm@osdl.org,
       torvalds@osdl.org, hugh@veritas.com, mbligh@aracnet.com,
       riel@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040326191841.GE9604@dualathlon.random>
References: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain> <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu> <20040325225919.GL20019@dualathlon.random> <20040326122636.GX791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326122636.GX791@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 04:26:36AM -0800, William Lee Irwin III wrote:
> On Thu, Mar 25, 2004 at 11:59:19PM +0100, Andrea Arcangeli wrote:
> > btw, the truncate of hugetlbfs didn't serialize correctly against the
> > do_no_page page faults, that's fixed too.
> 
> If a fault on hugetlb ever got as far as do_no_page() on ia32, the
> kernel would oops on the bogus struct page it gets out of the bogus
> pte.  I believe the way faults are handled in out-of-tree patches if by
> calling hugetlb-specific fault handling stacks instead of
> handle_mm_fault() if hugetlb vmas are found by arch code.
> 

this is certainly true, but still the pmd fault handling should have the
same locking of do_no_page, the race sounds the same, no matter if it's
a pmd or pte fill, no?
