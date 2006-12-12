Return-Path: <linux-kernel-owner+w=401wt.eu-S932197AbWLLLOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWLLLOF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 06:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWLLLOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 06:14:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41300 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932197AbWLLLOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 06:14:03 -0500
Date: Tue, 12 Dec 2006 03:13:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-mm@kvack.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Lumpy Reclaim V3
Message-Id: <20061212031312.e4c91778.akpm@osdl.org>
In-Reply-To: <exportbomb.1165424343@pinky>
References: <exportbomb.1165424343@pinky>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 16:59:04 +0000
Andy Whitcroft <apw@shadowen.org> wrote:

> This is a repost of the lumpy reclaim patch set.

more...

One concern is that when the code goes to reclaim a lump and fails, we end
up reclaiming a number of pages which we didn't really want to reclaim. 
Regardless of the LRU status of those pages.

I think what we should do here is to add the appropriate vmstat counters
for us to be able to assess the frequency of this occurring, then throw a
spread of workloads at it.  If that work indicates that there's a problem
then we should look at being a bit smarter about whether all the pages look
to be reclaimable and if not, restore them all and give up.

Also, I suspect it would be cleaner and faster to pass the `active' flag
into isolate_lru_pages(), rather than calculating it on the fly.  And I
don't think we need to calculate it on every pass through the loop?


We really do need those vmstat counters to let us see how effective this
thing is being.  Basic success/fail stuff.  Per-zone, I guess.

