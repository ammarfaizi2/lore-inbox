Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWBAN7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWBAN7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWBAN7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:59:35 -0500
Received: from [212.76.87.146] ([212.76.87.146]:47620 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1161049AbWBAN7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:59:33 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Date: Wed, 1 Feb 2006 16:58:10 +0300
User-Agent: KMail/1.5
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602011658.10418.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your detailed responses!

Kyle Moffett wrote:
> BTW, unless you have a patch or something to propose, let's take this
> off-list, it's getting kind of OT now.

No patches yet, but even if there were, would they get accepted?

> On Jan 31, 2006, at 10:56, Al Boldi wrote:
> > Kyle Moffett wrote:
> >> Is it necessarily faulty?  It seems to me that the current way
> >> works pretty well so far, and unless you can prove a really strong
> >> point the other way, there's no point in changing.  You have to
> >> remember that change introduces bugs which then have to be located
> >> and removed again, so change is not necessarily cheap.
> >
> > Faulty, because we are currently running a legacy solution to
> > workaround an 8,16,(32) arch bits address space limitation, which
> > does not exist in 64bits+ archs for most purposes.
>
> There are a lot of reasons for paging, only _one_ of them is/was to
> deal with too-small address spaces.  Other reasons are that sometimes
> you really _do_ want a nonlinear mapping of data/files/libs/etc.  It
> also allows easy remapping of IO space or video RAM into application
> address spaces, etc.  If you have a direct linear mapping from
> storage into RAM, common non-linear mappings become _extremely_
> complex and CPU-intensive.
>
> Besides, you never did address the issue of large changes causing
> large bugs.  Any large change needs to have advantages proportional
> to the bugs it will cause, and you have not yet proven this case.

How could reverting a workaround introduce large bugs?

> > Trying to defend the current way would be similar to rejecting the
> > move from  16bit to 32bit. Do you remember that time?  One of the
> > arguments used was:  the current way works pretty well so far.
>
> Arbitrary analogies do not prove things.

Analogies are there to make a long story short.

> Can you cite examples that
> clearly indicate how paged-memory is to direct-linear-mapping as 16-
> bit processors are to 32-bit processors?

I mentioned this in a previous message.

> > There is a lot to gain, for one there is no more swapping w/ all
> > its related side-effects.
>
> This is *NOT* true.  When you have more data than RAM, you have to
> put data on disk, which means swapping, regardless of the method in
> which it is done.
>
> > You're dealing with memory only.  You can also run your fs inside
> > memory, like tmpfs, which is definitely faster.
>
> Not on Linux.  We have a whole unique dcache system precisely so that
> a frequently accessed filesystem _is_ as fast as tmpfs (Unless you're
> writing and syncing a lot, in which case you still need to wait for
> disk hardware to commit data).

This is true, and may very well explain why dcache is so CPU intensive.

> > And there may be lots of other advantages, due to the simplified
> > architecture applied.
>
> Can you describe in detail your "simplified architecture"?? I can't
> see any significant complexity advantages over the standard paging
> model that Linux has.
>
> >>> Why would you think that the shortest path between two points is
> >>> complicated, when you have the ability to fly?
> >>
> >> Bad analogy.
> >
> > If you didn't understand it's meaning.  The shortest path meaning
> > accessing hw w/o running workarounds; using 64bits+ to fly over
> > past limitations.
>
> This makes *NO* technical sense and is uselessly vague.  Applying
> vague indirect analogies to technical topics is a fruitless
> endeavor.  Please provide technical points and reasons why it _is_
> indead shorter/better/faster, and then you can still leave out the
> analogy because the technical argument is sufficient.
>
> >>>> But unless the stumbling block since 1980 has been that it was too
> >>>> hard to get/make a CPU with a 64 bit address space, I don't see
> >>>> what's different today.
> >>>
> >>> You are hitting the nail right on it's head here. Nothing moves the
> >>> masses like mass-production.
> >>
> >> Uhh, no, you misread his argument: If there were other reasons that
> >> this was not done in the past than lack of 64-bit CPUS, then this is
> >> probably still not practical/feasible/desirable.
> >
> > Uhh?
> > The point here is: Even if there were 64bit archs available in the
> > past, this did not mean that moving into native 64bits would be
> > commercially viable, due to its unavailability on the mass-market.
>
> Are you even reading these messages?

Bryan Henderson wrote:
> >1) IF the ONLY reason this was not done before is that 64-bit archs
> >were hard to get, then you are right.
> >
> >2) IF there were OTHER reasons, then you are not correct.
> >
> >This is the argument.  You keep discussing how 64-bit archs were not
> >easily available before and are now, and I AGREE, but that is NOT
> >RELEVANT to the point he made.
>
> As I remember it, my argument was that single level storage was known and
> practical for 25 years and people did not flock to it, therefore they must
> not see it as useful.  So if 64 bit processors were not available enough
> during that time, that blows away my argument, because people might have
> liked the idea but just couldn't afford the necessary address width.  It
> doesn't matter if there were other reasons to shun the technology; all it
> takes is one.  And if 64 bit processors are more available today, that
> might tip the balance in favor of making the change away from multilevel
> storage.

Thanks for clarifying this!

> But I don't really buy that 64 bit processors weren't available until
> recently.  I think they weren't produced in commodity fashion because
> people didn't have a need for them.  They saw what you can do with 128 bit
> addresses (i.e. single level storage) in the IBM I Series line, but
> weren't impressed.  People added lots of other new technology to the
> mainstream CPU lines, but not additional address bits.  Not until they
> wanted to address more than 4G of main memory at a time did they see any
> reason to make 64 bit processors in volume.

True, so with 64bits=16MTB what reason would there be to stick with a swapped 
memory model?

Jamie Lokier wrote:
> Al Boldi wrote:
> > There is a lot to gain, for one there is no more swapping w/ all its
> > related side-effects.  You're dealing with memory only.
>
> I'm sorry, I think I don't understand.  My weakness.  Can you please
> explain?
>
> Presumably you will want access to more data than you have RAM,
> because RAM is still limited to a few GB these days, whereas a typical
> personal data store is a few 100s of GB.
>
> 64-bit architecture doesn't change this mismatch.  So how do you
> propose to avoid swapping to/from a disk, with all the time delays and
> I/O scheduling algorithms that needs?

This is exactly what a linear-mapped memory model avoids.
Everything is already mapped into memory/disk.

Lennart Sorensen wrote:
> Of course there is swapping.  The cpu only executes thigns from physical
> memory, so at some point you have to load stuff from disk to physical
> memory.  That seems amazingly much like the definition of swapping too.
> Sometimes you call it loading.  Not much difference really.  If
> something else is occupying physical memory so there isn't room, it has
> to be put somewhere, which if it is just caching some physical disk
> space, you just dump it, but if it is some giant chunk of data you are
> currently generating, then it needs to go to some other place that
> handles temporary data that doesn't already have a palce in the
> filesystem.  Unless you have infinite physical memory, at some point you
> will have to move temporary data from physical memory to somewhere else.
> That is swapping no matter how you view the system's address space.
> Making it be called something else doesn't change the facts.

Would you call reading and writing to memory/disk swapping?

> Applications don't currently care if they are swapped to disk or in
> physical memory.  That is handled by the OS and is transparent to the
> application.

Yes, a linear-mapped memory model extends this transparency to the OS.

> > If you didn't understand it's meaning.  The shortest path meaning
> > accessing hw w/o running workarounds; using 64bits+ to fly over past
> > limitations.
>
> THe OS still has to map the address space to where it physically exists.
> Mapping all disk space into the address space may actually be a lot less
> efficient than using the filesystem interface for a block device.

Did you try tmpfs?

> > Uhh?
> > The point here is: Even if there were 64bit archs available in the past,
> > this did not mean that moving into native 64bits would be commercially
> > viable, due to its unavailability on the mass-market.
> >
> > So with 64bits widely available now, and to let Linux spread its wings
> > and really fly, how could tmpfs merged w/ swap be tweaked to provide
> > direct mapped access into this linear address space?
>
> Applications can mmap files if they want to.  Your idea seems likely to
> make the OS much more complex, and waste a lot of resources on mapping
> disk space to the address space, and from the applications point of view
> it doesn't seem to make any difference at all.  It might be a fun idea
> for some academic research OS somewhere to go work out the kinks and see
> if it has any efficiency at all in real use.  Given Linux runs on lots
> of architectures, trying to make it work completely differently on 64bit
> systems doesn't make that much sense really, especially when there is no
> apparent benefit to the change.

Arch bits have nothing to do with a linear-mapped memory model, they only 
limit its usefulness.  So with 8,16,(32) bits this linear-mapped model isn't 
really viable because of its address-space limit.  But with a 64bit+ arch 
the limits are wide enough to make a linear-mapped model viable.  A 32bit 
arch is inbetween, so for some a 4GB limit may be acceptable.

Barry K. Nathan wrote:
> On 1/31/06, Al Boldi <a1426z@gawab.com> wrote:
> > Faulty, because we are currently running a legacy solution to workaround
> > an 8,16,(32) arch bits address space limitation, which does not exist in
> > 64bits+ archs for most purposes.
>
> In the early 1990's (and maybe even the mid 90's), the typical hard
> disk's storage could theoretically be byte-addressed using 32-bit
> addresses -- just as (if I understand you correctly) you are arguing
> that today's hard disks can be byte-addressed using 64-bit addresses.
>
> If this was going to be practical ever (on commodity hardware anyway),
> I would have expected someone to try it on a 32-bit PC or Mac when
> hard drives were in the 100MB-3GB range... That suggests to me that
> there's a more fundamental reason (i.e. other than lack of address
> space) that caused people to stick with the current scheme.

32bits is in brackets - 8,16,(32) - to high-light that it's an inbetween.

> tmpfs isn't "definitely faster". Remember those benchmarks where Linux
> ext2 beat Solaris tmpfs?

Linux tmpfs is faster because it can short-circuit dcache, in effect doing an 
o_sync.  It slows down when swapping kicks in.

> Also, the only way I see where "there is no more swapping" and
> "[y]ou're dealing with memory only" is if the disk *becomes* main
> memory, and main memory becomes an L3 (or L4) cache for the CPU [and
> as a consequence, main memory also becomes the main form of long-term
> storage]. Is that what you're proposing?

In the long-term yes, maybe even move it into hardware.  But for the 
short-term there is no need to blow things out of proportion, a simple 
tweaking of tmpfs merged w/ swap may do the trick quick and easy.

> If so, then it actually makes *less* sense to me than before -- with
> your scheme, you've reduced the speed of main memory by 100x or more,
> then you try to compensate with a huge cache. IOW, you've reduced the
> speed of *main* memory to (more or less) the speed of today's swap!
> Suddenly it doesn't sound so good anymore...

There really isn't anything new here; we do swap and access the fs on disk 
and compensate with a huge dcache now.  All this idea implies, is to remove 
certain barriers that could not be easily passed before, thus move swap and 
fs into main memory.

Can you see how removing barriers would aid performance?

Thanks!

--
Al

