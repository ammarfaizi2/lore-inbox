Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbULQGER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbULQGER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 01:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbULQGER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 01:04:17 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:18380 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262760AbULQGD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 01:03:56 -0500
Date: Fri, 17 Dec 2004 07:03:53 +0100
From: Andi Kleen <ak@suse.de>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       alan@lxorguk.ukuu.org.uk, riel@redhat.com, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-ID: <20041217060353.GC12049@wotan.suse.de>
References: <20041216102652.6a5104d2.akpm@osdl.org> <E1Cf2k0-00069l-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Cf2k0-00069l-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 09:00:52PM +0000, Ian Pratt wrote:
>  
> > I guess if we were to go the way which Ian is proposing it would be
> > 
> > a) Add arch/xen
> > 
> > b) Spend N weeks integrating xen into arch/i386, while also separately
> >    maintaining arch/xen.
> > 
> > c) Remove arch/xen
> > 
> > So...  why not skip a), c) and half of b)?
> 
> That's not quite what I'm proposing. 
> 
> Once arch/xen is in the tree, we'd start submitting patches that
> try and unify more of arch xen and i386 to reduce the number of
> files that we have to modify. 

IMHO reducing the number of files to modify should be done
first before attempting a mainline merge. That is how a lot
of other more intrusive changes have been merged in the past.

There was a intensive review process and eventually the interfaces
were cleaned up a lot of and the thing was merged piece by piece
after considerable changes. 

> 
> I think we'd then have to make a decision as to whether merging
> i386 and xen/i386 is feasible. Further, we'd have to make a
> decision as to whether what is really wanted is a single kernel
> that's able to boot-time switch between native i386 and xen,
> rather than just having a single source base. The two options
> would probably result in rather different implementations.

Even without boot time switch but only CONFIG switch 
a more shared code base would be probably the only saner
way long time. I'm not sure a run time switch is really
that good an idea, it would essentially require to run
most of pgtable.h etc. through function pointers and 
I don't like this idea very much. But at least doing the
reorganization on the source code level would probably
clean up the interface considerably.

> 
> In short, merging is far from trivial, and its not even clear
> quite what is wanted. 
> 
> I'm not convinced that maintaining xen/i386 in its current form
> is going to be as hard as Andi thinks. We already share many
> files unmodified from i386. Keeping i386 and xen/i386 in sync is
> fairly mechanical: we can apply most of the patches to i386 to
> xen/i386 directly. 

Perhaps for now, but eventually this will not work anymore due
to inevitable code drift (I went exactly through the same phase for a year
or so on x86-64. These days I have to redo most patches unless
i'm lucky enough that the contributor does both) 

And with also supporting x86-64 it will not really work this
way well because you would need to merge from two sources. 
I can't see any mechanical scheme handling that.
The only sane way to maintain the merging scheme you proposed
would be then arch/xen64, multiplying work again.

-Andi
