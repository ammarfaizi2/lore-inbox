Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUCVCdM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 21:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUCVCdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 21:33:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:742 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261631AbUCVCdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 21:33:10 -0500
Date: Sun, 21 Mar 2004 21:32:46 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>, <akpm@osdl.org>,
       <torvalds@osdl.org>, <hugh@veritas.com>, <mbligh@aracnet.com>,
       <mingo@elte.hu>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity
 fix
In-Reply-To: <20040322004652.GF3649@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403212131100.20045-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Andrea Arcangeli wrote:

> It would be curious to test it after changing the return 1 to return 0
> in the page_referenced trylock failures?

In the case of a trylock failure, it should probably return a
random value.  For heavily page faulting multithreaded apps,
that would mean we'd tend towards random replacement, instead
of FIFO.

Then again, the locking problems shouldn't be too bad in most
cases.  If you're swapping the program will be waiting on IO
and if it's not waiting on IO there's no problem.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

