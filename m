Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273824AbRIREBb>; Tue, 18 Sep 2001 00:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273825AbRIREBW>; Tue, 18 Sep 2001 00:01:22 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:60113 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S273824AbRIREBI>; Tue, 18 Sep 2001 00:01:08 -0400
Date: Tue, 18 Sep 2001 00:01:32 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918000132.C885@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0109171608310.1108-100000@penguin.transmeta.com> <20010917211834.A31693@redhat.com> <20010918035055.J698@athlon.random> <20010917221653.B31693@redhat.com> <20010918052201.N698@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010918052201.N698@athlon.random>; from andrea@suse.de on Tue, Sep 18, 2001 at 05:22:01AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 05:22:01AM +0200, Andrea Arcangeli wrote:
> try compiling 2.4.10pre10aa1 with egcs 1.1.2 before complaing about lack
> of testing, the tests were run on 2.4.10pre10aa1, not on 2.4.10pre11
> that didn't even existed at that time.

If I spent the time testing every random kernel patch that comes across, then 
I wouldn't have any time left to develop other useful things.  What I see is 
that what was merged didn't deal with things sanely.

> So I'm not surprised by the fact you weren't horrified by the previous
> VM that was looping forever in such a case.  unfortunately not everybody
> out there (mainly simulations) knows how much memory they will alloc.

Every single kernel since the dawn of 1.0 has died under OOM.  Optimizing for 
it seems rather stupid when a well maintained box WON'T OOM.

> > Then why wasn't it added to the generic code?
> 
> see above.

So merging crap is now acceptable?  Great, I'll write messy code from now on.

> > on their individual merit.  All or nothing is *not* the approach that should 
> > be taken at present.  (Hint, stability is acheived gradually.)
> 
> You can find a very big split if you check into the 2.4.10pre10aa1/
> directory in my ftp area, of course if you look at 2.4.10pre11 it is all
> at once.

Yes, all of the vm patches are in one big 3300 line patch, which is about the 
same size as the entire aio patch which adds a new subsystem.

> For the vm changes properly splitting them it's quite a pain, mainly due
> the way they're developed. For everything that is not a pain to keep
> separated I try to do so.

Bull shit.  People do it every day because Linus dictates it so.  There is 
nothing magical in you patch that can't be split up into human-readable 
chunks.

> > > again and you'll see, as said 2.2.19 does the same write throttling.
> > 
> > And it does so in a fashion which is completely broken.
> 
> Then send Alan the fix against 2.2.20pre10 if it's completly broken. I
> never got a complain about it yet and I look forward to see your fix.

2.2 doesn't matter any more.  Any work I'm doing now is 2.4 based.

> 
> > Then make it a seperate patch.  It shouldn't be part of the do-everything 
> 
> Please get real, it is a 3 thousand lines patch, if for every single
> change like this (orthogonal with the rest) I should make 1 patch it
> would take hours just to run the diffs. Not to tell if then I make a
> controversial changes.

I am being real.  I don't expect single massive patches to ever be applied, 
and am shocked I've even had to comment on this.

> What kind of workload is applied during the measurement, and what
> NULL/MEM/FILE_IO/PROCESS means? Is this benchmark available somewhere?
> What fields are you looking at exactly? I can see some field going up
> and low and I cannot evaluate those numbers very well without more info.

Go do the work yourself.  If you can't be bothered to develop benchmarks that 
simulate users on the vm subsystem, how can you claim your vm patches are 
correct?

> Except for the vm rewrite there was extensive testing. Probably not from
> RedHat Inc if this is the point that you are making. And the vm rewrite
> is so obviously better and much cleaner that I think this was a fine
> integration. I'm pretty sure no stability problem can arise because of
> the vm integration, if there could be problems as worse they could be
> specific to slower performance in some workload which we can address
> over the time without any pain. anyways as said dbench runs exactly
> twice faster so it cannot be obviously wrong in terms of performance
> either.

So the vm rewrite wasn't well tested, but it should be merged into a stable 
kernel?  Please say it ain't so.

> Linus merged everything without asking me and I think his move was very
> good IMHO. Face it: users cannot live anymore with workloads slowing
> down at every runs of benchmarks, with kswapd looping forever, with
> swapout storms, with swap filled by unused swapcache etc... What I did
> is the less intrusive change to the code that could at least address
> those critical problems and I'm pretty sure it did, as worse as said we
> may need some little tweak over the time but the new infrastructure
> should be robust enough now.

I want robust and not likely to corrupt my data randomly.  The latter is more 
important to me and everyone else in the world, so I think you should play 
by rules that enforce that.


> Ben, the true mess is the 2.4 VM before 2.4.10pre11. Period.

Sure.

> If you
> check the new code you'll see how much cleaner it is.

Hardly.  You don't even define your basic terms.  WTF is a classzone?  A 
comment somewhere would be nice.

> Those locking changes are bugfixes. Try to growsdown on a file backed
> vma with 2.4.9 using two threads and you'll run into troubles eventually
> (see the thread on l-k).

That isn't the one I'm talking about.  You changed the swapcache code.  That 
code is fragile.  These changes aren't documented.

> Just in case it wasn't obvious I do things gradually and in public,
> check ftp.kernel.org. If something you're the one that doesn't care
> about what I do in public.

The vm rewrite was not posted in public, nor described in public.  It just 
appeared and got merged.  Could you at least describe *ALL* of the changes?

> I recall I also described you some of the O_DIRECT
> stuff and blkdev pagecache work on Ottawa a few months ago. I get lots
> of feedback and also bugfixes from many places, to mention one company
> that cares about what I do in public there's IBM, they did auditing and
> I got several O_DIRECT small fixes from them incrementally to my very
> open patches. I think -aa I'm even more open than -ac since I keep all
> the stuff separated so it's much easier to understand and pick the
> interesting parts. I do my best effort to make every patch self
> contained just for the purpose of making merging and auditing easier,
> and it payed off so far. Furthmore it's not just in public but also in
> production, for istsance all SuSE server users happily runs things like
> O_DIRECT and blkdev in pagecache for several months now. The latter was
> needed from a few I/O intensive applications using blkdevs as files and
> needing heavy readhead for exploiting the full bandwith of many-ways
> raid arrays for example. The only other way would been to basically
> duplicate the readahead of filemap.c in block_dev.c, the hack was as
> complex as the long term fix.

And we agreed that this is 2.5 material.

> > Not at the expense of stability.  Do it in 2.5, or do it gradually.
> 
> Ben, instead of writing complains could you grab 2.4.10pre11, put it on
> your desktop while doing your daily work and let me know when you run
> into stability troubles? I could have said the same thing of the ext2
> directory metadata in pagecache, I grabbed it, put it on my desktop, it
> never given me a problem so far so I didn't complained. And the directory
> in pagecache wasn't fixing _any_ problem for the end user, here we're
> instead fixing _real_life_ showstopper problems with mysql, postgres (I
> wonder you care about postrgres these days?) and the other db not using
> rawio+lvm, so this was kind of needed in 2.4 eventually anyways if not
> today (I was flooded by bugreports of such kind, I'm sure you got them
> too). So the earlier the better. I think users would been not happy to
> wait until 2.6.

I'm sorry, but I'm not going to run it right now since I have other 
priorities.  I'm sure users will post their pass/fails over the next few 
days, but until I see some evidence that it doesn't eat my data, I'll hold 
back.

		-ben
