Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937438AbWLDWfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937438AbWLDWfk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 17:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937441AbWLDWfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 17:35:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45527 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937438AbWLDWfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 17:35:39 -0500
Date: Mon, 4 Dec 2006 14:34:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: clameter@sgi.com, Andy Whitcroft <apw@shadowen.org>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
Message-Id: <20061204143435.6ab587db.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612041946460.26428@skynet.skynet.ie>
References: <20061130170746.GA11363@skynet.ie>
	<20061130173129.4ebccaa2.akpm@osdl.org>
	<Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie>
	<20061201110103.08d0cf3d.akpm@osdl.org>
	<20061204140747.GA21662@skynet.ie>
	<20061204113051.4e90b249.akpm@osdl.org>
	<Pine.LNX.4.64.0612041946460.26428@skynet.skynet.ie>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 20:34:29 +0000 (GMT)
Mel Gorman <mel@csn.ul.ie> wrote:

> > IOW: big-picture where-do-we-go-from-here stuff.
> >
> 
> Start with lumpy reclaim,

I had lumpy-reclaim in my todo-queue but it seems to have gone away.  I
think I need a lumpy-reclaim resend, please.

> then I'd like to merge page clustering piece by 
> piece, ideally with one of the people with e1000 problems testing to see 
> does it make a difference.
> 
> Assuming they are shown to help, where we'd go from there would be stuff 
> like;
> 
> 1. Keep non-movable and reapable allocations at the lower PFNs as much as
>     possible. This is so DIMMS for higher PFNs can be removed (doesn't
>     exist)

"as much as possible" won't suffice, I suspect.  If there's any chance at
all that a non-moveable page can land in a hot-unpluggable region then
there will be failure scenarios.  Easy-to-hit ones, I suspect.

> 2. Use page migration to compact memory rather than depending solely on
>     reclaim (doesn't exist)

Yup.

> 3. Introduce a mechanism for marking a group of pages as being offlined so
>     that they are not reallocated (code that does something like this
>     exists)

yup.

> 4. Resurrect the hotplug-remove code (exists, but probably very stale)

I don't even remember what that looks like.

> 5. Allow allocations for hugepages outside of the pool as long as the
>     process remains with it's locked_vm limits (patches were posted to
>     libhugetlbfs last Friday. will post to linux-mm tomorrow).

hm.


I'm not saying that we need to do memory hot-unplug immediately.  But the
overlaps between this and anti-frag and lumpiness are sufficient that I do
think that we need to work out how we'll implement hot-unplug, so we don't
screw ourselves up later on.

