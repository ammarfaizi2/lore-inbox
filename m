Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273830AbRIREjQ>; Tue, 18 Sep 2001 00:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273831AbRIREjH>; Tue, 18 Sep 2001 00:39:07 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:17192 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273830AbRIREi4>; Tue, 18 Sep 2001 00:38:56 -0400
Date: Tue, 18 Sep 2001 06:39:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918063910.U698@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109171608310.1108-100000@penguin.transmeta.com> <20010917211834.A31693@redhat.com> <20010918035055.J698@athlon.random> <20010917221653.B31693@redhat.com> <20010918052201.N698@athlon.random> <20010918000132.C885@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010918000132.C885@redhat.com>; from bcrl@redhat.com on Tue, Sep 18, 2001 at 12:01:32AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 12:01:32AM -0400, Benjamin LaHaise wrote:
> Every single kernel since the dawn of 1.0 has died under OOM.  Optimizing for 

try 2.2 once.

> 2.2 doesn't matter any more.  Any work I'm doing now is 2.4 based.

It still matters for me. Critical servers with very high vm loads still
have to run 2.2 to be stable and fast unfortunately.

> I am being real.  I don't expect single massive patches to ever be applied, 
> and am shocked I've even had to comment on this.

Your aio patch is massive too.

andrea@athlon:~ > wc -l aio-v2.4.0-20010123.diff 
   2951 aio-v2.4.0-20010123.diff

Now if you think I'm unreal and you are real, feed me the aio patch in
self contained pieces of 10 lines each as you expect from me. And note
that if they're not self contained they will just make my life harder.

I'd be glad to be proved wrong and to get aio from you in small self
contained pieces really, I planned to look into aio as one of the next
things to merge in -aa but as usual the size of the patch makes things
harder to merge due the larger implications. feel free to cc l-k, I'm
sure other people is interested in aio too.

> I want robust and not likely to corrupt my data randomly.  The latter is more 

Forget the corruption. So far the only scary report I had is from
Marcelo's 2G machine which is nothin compared to corruption, I don't
have x86 machines with more than 1G, I tested alpha with 3G (but it has
only 1 zone). I think Marcelo identified the problematic part before
even testing it, so the fix should be fairly immediate, I'll address it
ASAP unless he beats me on it (at the moment I'm still resynching).

> That isn't the one I'm talking about.  You changed the swapcache code.  That 
> code is fragile.  These changes aren't documented.

I didn't changed the swapcache locking rules. I only fixed the VM to
properly clear the dirty bit before freeing a page. Anybody freeing a
page that is dirty was a plain vm bug. That was quite strightforward and
correct change. Infact I was horrified by seeing __free_pages_ok
clearing the dirty bit (not to talk about the referenced bit which was
useless to change).

> The vm rewrite was not posted in public, nor described in public.  It just 

It obviously was. How do you think Linus got it? I said I didn't sent it
to Linus privately.

> appeared and got merged.  Could you at least describe *ALL* of the changes?

I'll be glad to do that over the time, right now I'm strict in time and
I also needed to go to sleep a few hours ago so I won't inline the reply
to this email right now, sorry.

> And we agreed that this is 2.5 material.

the O_DIRECT and blkdev in pagecache yes but definitely not the VM one
but people needed those features in production anyways so that was good
and they were well tested.

Andrea
