Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbTJAHr2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 03:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTJAHr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 03:47:28 -0400
Received: from dp.samba.org ([66.70.73.150]:45193 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261955AbTJAHr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 03:47:27 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tim Hockin <thockin@hockin.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, braam@clusterfs.com, neilb@cse.unsw.edu.au,
       David Meybohm <dmeybohm@bellsouth.net>, sfr@canb.auug.org.au
Subject: Re: [PATCH] Many groups patch. 
In-reply-to: Your message of "Mon, 29 Sep 2003 21:11:55 MST."
             <20030929211155.A28089@hockin.org> 
Date: Wed, 01 Oct 2003 17:29:14 +1000
Message-Id: <20031001074726.A84702C0C0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030929211155.A28089@hockin.org> you write:
> On Tue, Sep 30, 2003 at 09:30:07AM +1000, Rusty Russell wrote:
> > > Why?
> > 
> > (Rusty points at Tim).
> > 
> > He has 10,000 groups.  Now me, I'm happy with the minimal fix.
> 
> I'm going to merge your thoughts and mine tomorrow and send it out.  Linus
> suggested the array of pages approah is more sane, so I'm going to try for
> it.  I'm going to comb through the diffs between your patch and mine.

Keeping the groups array as an array is a feature.  IMHO, if there are
too many for a kmalloc, vmalloc fallback makes sense: it's
conceptually simple and not that much code.

Introducing an almost-vmalloc because Linus didn't like the vmalloc
just doesn't make sense, IMHO.

> > And worse, there are the intermediate kmallocs which would need to be
> > fixed (thanks to Stephen Rothwell for pointing this out).  Fixing this
> > would make it even uglier.
> 
> Specifically?  I think my patch gets all of those.  At least all the ones I
> found.

Yep, you got them, I didn't.  I am still hoping Stephen (CC'd) will
move the IA64, S390 and Sparc64 code into kernel/compat.c which will
shrink out patches.

> > Here's an updated one (with David Meybohm's fix, too -- Thanks!),
> > Rusty.
> 
> Can you elaborate on what this extra fix is?

I screwed up a free.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
