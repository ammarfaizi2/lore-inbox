Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVAESvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVAESvr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbVAESvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:51:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63465 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262554AbVAESvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:51:45 -0500
Date: Wed, 5 Jan 2005 13:50:51 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
In-Reply-To: <20050105180651.GD4597@dualathlon.random>
Message-ID: <Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>
 <20050105020859.3192a298.akpm@osdl.org> <20050105180651.GD4597@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005, Andrea Arcangeli wrote:

> Another unrelated problem I have in this same area and that can explain
> VM troubles at least theoretically, is that blk_congestion_wait is
> broken by design. First we cannot wait on random I/O not related to
> write back. Second blk_congestion_wait gets trivially fooled by
> direct-io for example. Plus the timeout may cause it to return too early
> with slow blkdev.

Or the IO that just finished, finished for pages in
another memory zone, or pages we won't scan again in
our current go-around through the VM...

> blk_congestion_wait is a fundamental piece to get oom detection right
> during writeback and unfortunately it's fundamentally fragile in 2.6
> (this as usual wasn't the case in 2.4).

Indeed ;(

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
