Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273964AbRIRXaY>; Tue, 18 Sep 2001 19:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273965AbRIRXaO>; Tue, 18 Sep 2001 19:30:14 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:50494 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273964AbRIRXaA> convert rfc822-to-8bit; Tue, 18 Sep 2001 19:30:00 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Chris Mason <mason@suse.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200109180406.f8I46LG02238@zero.tech9.net>
In-Reply-To: <200109140302.f8E32LG13400@zero.tech9.net>
	<200109150444.f8F4iEG19063@zero.tech9.net>
	<1000530869.32365.21.camel@phantasy> 
	<200109180406.f8I46LG02238@zero.tech9.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.13.99+cvs.2001.09.18.07.08 (Preview Release)
Date: 18 Sep 2001 19:31:22 -0400
Message-Id: <1000855884.19836.49.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-09-18 at 00:06, Dieter Nützel wrote:
> Am Samstag, 15. September 2001 07:14 schrieb Robert Love:
> > Are you seeing any specific problems, now?  With the latest preemption
> > patch on 2.4.10-pre9, do you crash? oops?
> 
> No, nothing with 2.4.10-pre9 + patch-rml-2.4.10-pre9-preempt-kernel-1 and 
> your MMX/3Dnow! fix.
> 
> 2.4.10-pre10 + patch-rml-2.4.10-pre10-preempt-kernel-1 seems to be a winner!
> 
> See my results below.

Excellent.  Note, 2.4.10-pre11 patches are out, but I don't know how
stable it is.  I am not sure I agree with ripping out the VM at this
moment.

Personally, I am using 2.4.9-ac12.  Patches are going up soon.

> > The only outstanding issue now is ReiserFS issues.
> 
> Yes, but no crash or oops for me.
> "Only" some "stalls" during MPEG/Ogg-Vorbis playback (2-5 sec) :-(

The ReiserFS issue may even be a non-issue.  Too much is going on right
now to figure that out.  I am going to keep going through it, though.

If you don't crash, its not an issue for you, at least.

> > > It seems to be that kswap put some additional "load" on the disk from
> > > time to time. Or is it the ReiserFS thing, again?
> >
> > I don't think its related to ReiserFS.
> 
> I think you are right.
> 
> > What sort of activity are you seeing?  How often?  How do you know its
> > kswapd?
> 
> I saw it with "top" at the first line (but only some few percent).
> It was during untarring some mid-sized archives (DRI) which took normally ~10 
> sec, but with kswap and 2.4.9-pre9+your patches ~30 sec. Even "sync" needed 
> some additional seconds.

I don't know what to make of this.  Your's is the first report.

> Are there some reschedule/context switch (kernel lock release) statements 
> missing in ReiserFS?

Actually, if ReiserFS was missing lock statements it would be faster :)
(but then crash, of course)

> Is this possible? Chris?
> 
> > I am glad the patch fixed it, the final version of that is going into
> > the next preemption patch.  Stay tuned.
> 
> I am very happy with patch-rml-2.4.10-pre10-preempt-kernel-1.

I am very glad.  Keep following the patches.

> > These results are pretty good.  Throughput seems down 2-3% in many
> > cases, although latency is greatly improved.  Look at those latency
> > changes!  From thousands of ms to hundreds of us in bonnie.  Wow.
> 
> So look at my latest numbers. This time preempt only, sorry.
> If you need 2.4.10-pre10 only, too please ask.

The numbers look very good, comparing them to your previous posted
results.

Next time you benchmark (for a future kernel, say), I do indeed like
seeing the non-preempt benchmarks so I can gauge things.  I realize its
a pain to compile and boot multiple kernels, though.

> > Even if you don't care about latency (I'm not an audio person or
> > anything), these changes should be worth it.
> 
> I do. Or better, one of my friend's father will do some digital video editing 
> with Linux:-)

Great :)

> > > Deleting with ReiserFS and the preempt kernel is GREAT!
> >
> > Good. I/O latency should be great now, with little change in
> > throughput...
> 
> It is.
> 
> > > But I get some hiccup during noatun (mp3, ogg, etc. player for KDE-2.2)
> > > or plaympeg together with dbench (16, 32). ReiserFS needs some preemption
> > > fixes, too?
> >
> > You may still get some small hiccups ( < 1 second?) even with the
> > preemption patch, as kernel locks prevent preemption (the patch can't
> > guarentee low latency, just preemption outside of the locks).
> 
> Sadly 2-5 seconds at the beginning of dbench and during bonnie++ block 
> operations (huge IO pressure, ~20% system, 3-5% user, 116308 kilobytes paged 
> out).
> 
> > However, how bad was the hiccups with preemption disabled?  I have heard
> > reports where it is 3-5sec at times.
> 
> Yes, nearly the same.

Hm, these we need to figure out.  We need to find what locks are held
too long or perhaps improperly -- stalls that large should not occur.

You don't use ALSA drivers, do you?

> > As the kernel becomes more scalable (finer-grain locking), preemption
> > will improve.  Past that, perhaps during 2.5, we can work on some other
> > things to improve preemption.
> 
> Is this a ReiserFS only problem? Uninteruptable IO?

No, ReiserFS is a good design.  This is in general -- in many places we
hold a very large lock -- ie, lock a whole subsystem from concurrent
access.  What we can do is lock finer and finer items, ie individual
structures, and use read/write and read locks appropriately.

Past that, we can look into replacing the use of SMP spinlocks with
other concurrency primitives for preemption.

> > > I've attached two small compressed bonnie++ HTML files.
> >
> > These were neat, thanks.
> 
> One more.
> 
> > Thank you for your feedback and support.  Stay current with the kernel
> > and the preemption patches,
> 
> I will.
> 
> > and I will try to figure the ReiserFS crashes out.
> 
> No crashes for me only the stalls.

Good.

Again, thanks a bunch for the feedback and benchmarks.  I will keep
looking into ReiserFS, but it may indeed be a non-issue.

You can keep up to date at http://tech9.net/rml/linux ... as I said, new
patches are going up in a moment.

Take care,

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

