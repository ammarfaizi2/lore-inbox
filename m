Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263856AbUCZHwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 02:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbUCZHwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 02:52:51 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:161
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263856AbUCZHwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 02:52:50 -0500
Date: Fri, 26 Mar 2004 08:53:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: akpm@osdl.org, torvalds@osdl.org, hugh@veritas.com, mbligh@aracnet.com,
       riel@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040326075343.GB12484@dualathlon.random>
References: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain> <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu> <20040325225919.GL20019@dualathlon.random> <Pine.GSO.4.58.0403252258170.4298@azure.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403252258170.4298@azure.engin.umich.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 11:06:50PM -0500, Rajesh Venkatasubramanian wrote:
> 
> Hi Andrea,
> 
> I am yet to look at the new -aa you released. A small change is
> required below. Currently, I cannot generate a patch. Sorry. Please
> fix it by hand. Thanks.
> 
> >
> > -	list_for_each_entry(vma, list, shared) {
> > +	vma = __vma_prio_tree_first(root, &iter, h_pgoff, h_pgoff);
> 
> This should be:
> 	vma = __vma_prio_tree_first(root, &iter, h_pgoff, ULONG_MAX);
> 
> > +	while (vma) {
> >  		unsigned long h_vm_pgoff;
> [snip]
> > +		vma = __vma_prio_tree_next(vma, root, &iter, h_pgoff, h_pgoff);
> >  	}
> 
> and here it should be:
> 		vma = __vma_prio_tree_next(vma, root, &iter,
> 						h_pgoff, ULONG_MAX);

I was missing all vmas with vm_start starting after h_pgoff.  Thanks.
