Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265881AbTGADPt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 23:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbTGADPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 23:15:49 -0400
Received: from imladris.surriel.com ([66.92.77.98]:40348 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S265881AbTGADPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 23:15:47 -0400
Date: Tue, 1 Jul 2003 03:29:54 +0000 (UTC)
From: Rik van Riel <riel@imladris.surriel.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@digeo.com>, mel@csn.ul.ie, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: What to expect with the 2.6 VM
In-Reply-To: <20030701032248.GM3040@dualathlon.random>
Message-ID: <Pine.LNX.4.55L.0307010327250.1638@imladris.surriel.com>
References: <Pine.LNX.4.53.0307010238210.22576@skynet>
 <20030701022516.GL3040@dualathlon.random> <20030630200237.473d5f82.akpm@digeo.com>
 <20030701032248.GM3040@dualathlon.random>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jul 2003, Andrea Arcangeli wrote:

> Also think if you've a 1G box, the highmem list would be very small and
> if you shrink it first, you'll waste an huge amount of cache. Maybe you
> go shrink the zone normal list first in such case of unbalance?

That's why you have low and high watermarks and try to balance
the shrinking and allocating in both zones.  Not sure how
classzone would influence this balancing though, maybe it'd be
harder maybe it'd be easier, but I guess it would be different.

> Overall I think rotating too fast a global list sounds much better in this
> respect (with less infrequent GFP_KERNELS compared to the
> highmem/pagecache/anonmemory allocation rate) as far as I can tell, but
> I admit I didn't do any math (I didn't feel the need of a demonstration
> but maybe we should?).

Remember that on large systems ZONE_NORMAL is often under much
more pressure than ZONE_HIGHMEM.  Need any more arguments ? ;)

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
