Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUCVAqD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUCVAqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:46:03 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63114
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261576AbUCVAqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:46:01 -0500
Date: Mon, 22 Mar 2004 01:46:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: akpm@osdl.org, torvalds@osdl.org, hugh@veritas.com, mbligh@aracnet.com,
       riel@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040322004652.GF3649@dualathlon.random>
References: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain> <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 05:10:45PM -0500, Rajesh Venkatasubramanian wrote:
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=107966438414248
> 
> 	Andrea says the system may hang, however, in this case system
> 	does not hang.

It's a live lock, not a deadlock. I didn't wait more than a few minutes
every time before declaring the kernel broken and rebooting the machine.
still if the prio_tree fixed my problem it means at the very least it
reduced the contention on the locks a lot ;)

It would be curious to test it after changing the return 1 to return 0
in the page_referenced trylock failures?

the results looks great, thanks.

what about the cost of a tree rebalance, is that O(log(N)) like with the
rbtrees?
