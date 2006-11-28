Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757955AbWK1XbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757955AbWK1XbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 18:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757962AbWK1XbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 18:31:03 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:7070 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1757955AbWK1Xaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 18:30:55 -0500
Subject: Re: [PATCH 5/6] ext2 balloc: say rb_entry not list_entry
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611281742470.29701@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061114184919.GA16020@skynet.ie>
	 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	 <20061114113120.d4c22b02.akpm@osdl.org>
	 <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
	 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com>
	 <20061115232228.afaf42f2.akpm@osdl.org>
	 <1163666960.4310.40.camel@localhost.localdomain>
	 <20061116011351.1401a00f.akpm@osdl.org>
	 <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
	 <20061116132724.1882b122.akpm@osdl.org>
	 <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
	 <1164073652.20900.34.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611210508270.22957@blonde.wat.veritas.com>
	 <1164156193.3804.48.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611281659190.29701@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611281742470.29701@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 28 Nov 2006 15:30:50 -0800
Message-Id: <1164756650.6538.6.camel@dyn9047017103.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 17:43 +0000, Hugh Dickins wrote:
> The reservations tree is an rb_tree not a list, so it's less confusing to
> use rb_entry() than list_entry() - though they're both just container_of().
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> ---
> 

Acked.

Thanks,
Mingming
>  fs/ext2/balloc.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- 2.6.19-rc6-mm2/fs/ext2/balloc.c	2006-11-24 08:18:02.000000000 +0000
> +++ linux/fs/ext2/balloc.c	2006-11-27 19:28:41.000000000 +0000
> @@ -156,7 +156,7 @@ restart:
> 
>  	printk("Block Allocation Reservation Windows Map (%s):\n", fn);
>  	while (n) {
> -		rsv = list_entry(n, struct ext2_reserve_window_node, rsv_node);
> +		rsv = rb_entry(n, struct ext2_reserve_window_node, rsv_node);
>  		if (verbose)
>  			printk("reservation window 0x%p "
>  				"start: %lu, end: %lu\n",
> @@ -753,7 +753,7 @@ static int find_next_reservable_window(
> 
>  		prev = rsv;
>  		next = rb_next(&rsv->rsv_node);
> -		rsv = list_entry(next,struct ext2_reserve_window_node,rsv_node);
> +		rsv = rb_entry(next,struct ext2_reserve_window_node,rsv_node);
> 
>  		/*
>  		 * Reached the last reservation, we can just append to the
> @@ -995,7 +995,7 @@ static void try_to_extend_reservation(st
>  	if (!next)
>  		my_rsv->rsv_end += size;
>  	else {
> -		next_rsv = list_entry(next, struct ext2_reserve_window_node, rsv_node);
> +		next_rsv = rb_entry(next, struct ext2_reserve_window_node, rsv_node);
> 
>  		if ((next_rsv->rsv_start - my_rsv->rsv_end - 1) >= size)
>  			my_rsv->rsv_end += size;

