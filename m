Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbUKQUMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbUKQUMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUKQUKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:10:19 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:37643 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262409AbUKQUHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:07:00 -0500
Date: Wed, 17 Nov 2004 20:06:35 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, <76306.1226@compuserve.com>,
       Andrea Arcangeli <andrea@novell.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Dropped patch: mm/mempolicy.c:sp_lookup()
In-Reply-To: <20041117111336.608409ef.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0411171938210.1809-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> > On Tue, Nov 16, 2004 at 10:54:09PM -0500, Chuck Ebbert wrote:
> > > On Wed, 17 Nov 2004 at 02:00:20 +0100, Andi Kleen wrote:
> > > > On Mon, Nov 15, 2004 at 11:15:51PM -0500, Chuck Ebbert wrote:
> > > > > Andrea posted this one-liner a while ago as part of a larger patch.  He said
> > > > > it fixed return of the wrong policy in some conditions.  Was this a valid fix?
> > > >
> > > > Yes it was.
> > > 
> > >   At least it wasn't dropped -- it's in -mm as part of
> > > fix-for-mpol-mm-corruption-on-tmpfs, though it's unrelated to tmpfs.
> > > (That patch contains three separate changes...)
> > > 
> > >   Should just this part, which changes '<' to '<=', be pushed upstream?
> > 
> > Yes. I'm sure Andrea will take care of that himself. 
> 
> That fix is contained within fix-for-mpol-mm-corruption-on-tmpfs.patch
> anyway, isn't it?

Yes; and Chuck is right that it's three patches not one.

I think at the least you should split it by file into mm/shmem.c
and mm/mempolicy.c parts, they're entirely independent.

I've seen Andi's ack on the '<=' fix,
I've not seen his ack on the mempolicy optimizations.

> And that patch is slated for merging once I work out
> whether Hugh and Andrea have sorted things out?

Well... it remains the case that Andrea prefers his shmem.c
patch to mine, and I prefer mine to his, while we both agree
the other's works.  I'm a lot more anxious to see the fix go
into 2.6.10 than to lose it amidst debate back and forth; and
I bet Andrea feels just the same.  Choose whichever you prefer
or find easier to go with - I expect that'll be Andrea's since
you have it there in your tree.

I'm rather more relaxed about it since observing that you now have
Steve Longerbeam's patch, acked by Andi, in your tree.  I presume
you're intending that to go in 2.6.11 or 12, rather than just putting
it there to experiment?  It's a bit silly at present since it leaves
the shmem info->policy in place, while adding a mapping->policy:
I need to go in to convert over and remove shmem's info->policy.
Whereupon the whole problem fixed by Andrea, and the area of our
disagreement, will just vanish.

Hugh

