Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUKOOdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUKOOdE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 09:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbUKOOdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 09:33:04 -0500
Received: from almesberger.net ([63.105.73.238]:5385 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261604AbUKOOc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 09:32:59 -0500
Date: Mon, 15 Nov 2004 11:32:42 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generalize prio_tree (1/3)
Message-ID: <20041115113242.R28802@almesberger.net>
References: <20041114235646.K28802@almesberger.net> <419830FD.7000007@yahoo.com.au> <20041115030750.L28802@almesberger.net> <41988CA2.8050407@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41988CA2.8050407@yahoo.com.au>; from nickpiggin@yahoo.com.au on Mon, Nov 15, 2004 at 10:01:54PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> ... but humor me, you _are_ ensuring the following doesn't get
> reordered, say:
> 
> (write, sect 100), (barrier), (write, sect 200)

Ah you found the case I didn't mention :-) Yes, that's handled
somewhere else. When the ABISS elevator sees a barrier, it just
pushes the current sort tree for non-reads (writes and weird
stuff) to a FIFO list.

So writes don't benefit that much from priorities. The good
thing is that they also happen to need them less ;-)

Hmm, I just see that power down (suspend and shutdown) sneaked out
again. Well, easy enough to fix.

> No comment on your prio tree generalization, sorry. Other than: it
> seems to be unfortunately quite ugly.

I know. Unfortunately, there doesn't seem to be a nice alternative
that doesn't either require additional fields (e.g. in MM, only half
of the key is not stored in the tree, the other half is calculated)
or *very* busy callbacks.

Of course, if Rajesh or the MM folks in general think that storing
the whole key in the tree is fine, I wouldn't complain :-)

> (eg. add the patch to the front
> of your ABISS elevator if you submit it to 2.6 or -mm).

Ah no, the ABISS elevator won't go into the kernel - it's just for
experimenting. But Jens is planning to add the overlap handling to
the block device layer. So the user is well on its way :-) It's just
more convenient if we can do this one step at a time, particularly
since prio_tree is a very general concept (much like lists or
red-black trees) anyway.

> But I don't have strong feelings on the matter. If Rajesh says its OK
> to go ahead as is, that would be fine by me :)

Cool. Thanks !

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
