Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVKKRp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVKKRp2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 12:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVKKRp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 12:45:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:16077 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750922AbVKKRp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 12:45:28 -0500
Date: Fri, 11 Nov 2005 09:43:22 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Con Kolivas <kernel@kolivas.org>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, alokk@calsoftinc.com
Subject: Re: [RFC, PATCH] Slab counter troubles with swap prefetch?
In-Reply-To: <200511111450.07396.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.62.0511110941050.20360@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511101351120.16380@schroedinger.engr.sgi.com>
 <200511111007.12872.kernel@kolivas.org> <Pine.LNX.4.62.0511101510240.16588@schroedinger.engr.sgi.com>
 <200511111450.07396.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005, Con Kolivas wrote:

> One last thing. Swap prefetch works off the accounting of total memory and is 
> only a single kernel thread rather than a thread per cpu or per pgdat unlike 
> kswapd. Currently it just cares about total slab data and total ram. 
> Depending on where this thread is scheduled (which node) your accounting 
> change will alter the behaviour of it. Does this affect the relevance of this 
> patch to you?

Yes, if its a truly global value then we would not need the patch. 
But then the prefetch code would have to add up all the nr_slab field for 
all processors and use that result for comparison. If you do this in a 
node specific fashion then the problem comes up again.



