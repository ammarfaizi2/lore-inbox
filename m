Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUC2WjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUC2WjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:39:10 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28058
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263185AbUC2WjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:39:02 -0500
Date: Tue, 30 Mar 2004 00:39:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: vrajesh@umich.edu, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040329223900.GK3808@dualathlon.random>
References: <20040325225919.GL20019@dualathlon.random> <Pine.GSO.4.58.0403252258170.4298@azure.engin.umich.edu> <20040326075343.GB12484@dualathlon.random> <Pine.LNX.4.58.0403261013480.672@ruby.engin.umich.edu> <20040326175842.GC9604@dualathlon.random> <Pine.GSO.4.58.0403271448120.28539@sapphire.engin.umich.edu> <20040329172248.GR3808@dualathlon.random> <Pine.GSO.4.58.0403291240040.14450@eecs2340u20.engin.umich.edu> <20040329180109.GW3808@dualathlon.random> <20040329124027.36335d93.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329124027.36335d93.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 12:40:27PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > There's now also a screwup in the writeback -mm changes for swapsuspend,
> > it bugs out in radix tree tag, I believe it's because it doesn't
> > insert the page in the radix tree before doing writeback I/O on it.
> 
> hmm, yes, we have pages which satisfy PageSwapCache(), but which are not
> actually in swapcache.

exactly.

> How about we use the normal pagecache APIs for this?

should work fine too and it exposes less internal vm details. I will
propose your fix for testing too.
