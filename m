Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273855AbRIRFWP>; Tue, 18 Sep 2001 01:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273854AbRIRFWF>; Tue, 18 Sep 2001 01:22:05 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:3556 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S273853AbRIRFVw>; Tue, 18 Sep 2001 01:21:52 -0400
Date: Tue, 18 Sep 2001 01:22:16 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918012216.C1249@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0109171608310.1108-100000@penguin.transmeta.com> <20010917211834.A31693@redhat.com> <20010918035055.J698@athlon.random> <20010917221653.B31693@redhat.com> <20010918052201.N698@athlon.random> <20010918000132.C885@redhat.com> <20010918063910.U698@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010918063910.U698@athlon.random>; from andrea@suse.de on Tue, Sep 18, 2001 at 06:39:10AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 06:39:10AM +0200, Andrea Arcangeli wrote:
> On Tue, Sep 18, 2001 at 12:01:32AM -0400, Benjamin LaHaise wrote:
> > Every single kernel since the dawn of 1.0 has died under OOM.  Optimizing for 
> 
> try 2.2 once.

There are still loads that 2.2 can die under (think fast network cards and 
you'll realise that you can't protect against it).  Yes, 2.2 is in far better 
state than anything else ever has been, but it's not perfect.

> > 2.2 doesn't matter any more.  Any work I'm doing now is 2.4 based.
> 
> It still matters for me. Critical servers with very high vm loads still
> have to run 2.2 to be stable and fast unfortunately.

That's where I want 2.4 to get to.

> > I am being real.  I don't expect single massive patches to ever be applied, 
> > and am shocked I've even had to comment on this.
> 
> Your aio patch is massive too.
> 
> andrea@athlon:~ > wc -l aio-v2.4.0-20010123.diff 
>    2951 aio-v2.4.0-20010123.diff
> 
> Now if you think I'm unreal and you are real, feed me the aio patch in
> self contained pieces of 10 lines each as you expect from me. And note
> that if they're not self contained they will just make my life harder.

Not 10 lines, but several hundred here and there.  Aio actually splits up 
very well since thing like the wait_queue changes are all isolated bits 
of functionality.  Even the brw_kiovec_async bit is standalone since it 
only matters to itself and brw_kiovec.  Yes, the current patch is not 
seperated, but that was my plan from the beginning on merging.

> I'd be glad to be proved wrong and to get aio from you in small self
> contained pieces really, I planned to look into aio as one of the next
> things to merge in -aa but as usual the size of the patch makes things
> harder to merge due the larger implications. feel free to cc l-k, I'm
> sure other people is interested in aio too.

It's not ready yet.  Most of the development has been on hold waiting for 
2.5 to start for cementing the ABI in stone.

> > I want robust and not likely to corrupt my data randomly.  The latter is more 
> 
> Forget the corruption. So far the only scary report I had is from
> Marcelo's 2G machine which is nothin compared to corruption, I don't
> have x86 machines with more than 1G, I tested alpha with 3G (but it has
> only 1 zone). I think Marcelo identified the problematic part before
> even testing it, so the fix should be fairly immediate, I'll address it
> ASAP unless he beats me on it (at the moment I'm still resynching).

Sure.  That's why it should remain seperate for at least a little bit.

> 
> > That isn't the one I'm talking about.  You changed the swapcache code.  That 
> > code is fragile.  These changes aren't documented.
> 
> I didn't changed the swapcache locking rules. I only fixed the VM to
> properly clear the dirty bit before freeing a page. Anybody freeing a
> page that is dirty was a plain vm bug. That was quite strightforward and
> correct change. Infact I was horrified by seeing __free_pages_ok
> clearing the dirty bit (not to talk about the referenced bit which was
> useless to change).

So why not split that fix out as a seperate patch that can then be applied 
alone?

> 
> > The vm rewrite was not posted in public, nor described in public.  It just 
> 
> It obviously was. How do you think Linus got it? I said I didn't sent it
> to Linus privately.

*nod*

> > appeared and got merged.  Could you at least describe *ALL* of the changes?
> 
> I'll be glad to do that over the time, right now I'm strict in time and
> I also needed to go to sleep a few hours ago so I won't inline the reply
> to this email right now, sorry.

Thanks!  I think we'll all be a bit calmer in the morning and better able to 
think clearly.  I'll even try to break things down a bit as there are bits 
in your patches which I think are very good.

Cheers,

		-ben
