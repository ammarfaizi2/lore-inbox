Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263926AbUCZEHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 23:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbUCZEHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 23:07:09 -0500
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:41940 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S263926AbUCZEHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 23:07:06 -0500
Date: Thu, 25 Mar 2004 23:06:50 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@azure.engin.umich.edu
To: Andrea Arcangeli <andrea@suse.de>
cc: akpm@osdl.org, torvalds@osdl.org, hugh@veritas.com, mbligh@aracnet.com,
       riel@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity
 fix
In-Reply-To: <20040325225919.GL20019@dualathlon.random>
Message-ID: <Pine.GSO.4.58.0403252258170.4298@azure.engin.umich.edu>
References: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain>
 <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu>
 <20040325225919.GL20019@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrea,

I am yet to look at the new -aa you released. A small change is
required below. Currently, I cannot generate a patch. Sorry. Please
fix it by hand. Thanks.

>
> -	list_for_each_entry(vma, list, shared) {
> +	vma = __vma_prio_tree_first(root, &iter, h_pgoff, h_pgoff);

This should be:
	vma = __vma_prio_tree_first(root, &iter, h_pgoff, ULONG_MAX);

> +	while (vma) {
>  		unsigned long h_vm_pgoff;
[snip]
> +		vma = __vma_prio_tree_next(vma, root, &iter, h_pgoff, h_pgoff);
>  	}

and here it should be:
		vma = __vma_prio_tree_next(vma, root, &iter,
						h_pgoff, ULONG_MAX);

Thanks,
Rajesh

