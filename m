Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbTF2Uy2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264978AbTF2UyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:54:01 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:52890 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S265022AbTF2Uvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:51:41 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [RFC] My research agenda for 2.7
Date: Sat, 28 Jun 2003 23:06:59 +0200
User-Agent: KMail/1.5.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <200306271800.53487.phillips@arcor.de> <Pine.LNX.4.53.0306291953490.20655@skynet>
In-Reply-To: <Pine.LNX.4.53.0306291953490.20655@skynet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306282306.59502.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 June 2003 21:25, Mel Gorman wrote:
> As you can see, order0 allocations were a *lot* more common, at least in
> my system.

Mel,

There's no question that that's the case today.  However, there are good 
reasons for using a largish filesystem blocksize, 16K for example, once it 
becomes possible to do so.  With an active volume mounted using 16K blocks, 
you'd see that the balance of allocations shifts towards order 2.  The size 
of the shift will be workload-dependent, ranging from almost no order 2 
allocations, to almost all.  To keep things interesting, it's quite possible 
for the balance to change suddenly and/or strongly.

> Because they are so common in comparison to other orders, I
> think that putting order0 in slabs of size 2^MAX_ORDER will make
> defragmentation *so* much easier, if not plain simple, because you can
> shuffle around order0 pages in the slabs to free up one slab which frees
> up one large 2^MAX_ORDER adjacent block of pages.

But how will you shuffle those pages around?

Regards,

Daniel

