Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272058AbRIOFOA>; Sat, 15 Sep 2001 01:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272012AbRIOFNv>; Sat, 15 Sep 2001 01:13:51 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:12292 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272058AbRIOFN3> convert rfc822-to-8bit; Sat, 15 Sep 2001 01:13:29 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>,
        DRI-Devel <dri-devel@lists.sourceforge.net>
In-Reply-To: <200109150444.f8F4iEG19063@zero.tech9.net>
In-Reply-To: <200109140302.f8E32LG13400@zero.tech9.net>
	<1000442113.3897.19.camel@phantasy> 
	<200109150444.f8F4iEG19063@zero.tech9.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.18.39 (Preview Release)
Date: 15 Sep 2001 01:14:07 -0400
Message-Id: <1000530869.32365.21.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-15 at 00:25, Dieter Nützel wrote:
> > > >  ReiserFS may be another problem.
> > > Can't wait for that.
> Most wanted, now.

I am working on it, but I am unfamilar with it all.

Are you seeing any specific problems, now?  With the latest preemption
patch on 2.4.10-pre9, do you crash? oops?

The only outstanding issue now is ReiserFS issues.

> Tried it and it works so far.
> 
> It seems to be that kswap put some additional "load" on the disk from time
> to time. Or is it the ReiserFS thing, again?

I don't think its related to ReiserFS.

What sort of activity are you seeing?  How often?  How do you know its
kswapd?

> Have you a copy of my posted ksymoops file?
> But the oopses seems to be cured.

Yah, I just am having a problem sorting  who said what running what and
when :)

I am glad the patch fixed it, the final version of that is going into
the next preemption patch.  Stay tuned.

> I don't know exactly 'cause kernel hacking is not my main focus.
> 
> But have you thought about the MMX/3DNow! stuff in Mesa/OpenGL (XFree86 DRI)?
> And what do you think about the XFree86 Xv extentions (video) or the whole 
> MPEG2/3/4, Ogg-Vorbis, etc. (multimedia stuff)?
> 
> Do all these libraries (progs) need some preempt patches?
> That's why I cross posted to the DRI-Devel List (sorry).

No, these are unrelated.

Sorry for the cross-post, DRI :)

The kernel takes care of saving state for FPU operations for userspace. 
Indeed, it takes care of everything for userspace.  In kernel land, we
don't have that beauty, we have to worry about everything we do and
everything we change, and thus we have this problem.

What exactly happens is another operation is preempting the current
process during an FPU operation, when the CPU is in a different state,
and then everything barfs since it is not as it wants to be.

This is not an issue for userspace.

> I understand ;-)
> It seems to calm it.

Good.

> Now, here are my results.
> <snip>

These results are pretty good.  Throughput seems down 2-3% in many
cases, although latency is greatly improved.  Look at those latency
changes!  From thousands of ms to hundreds of us in bonnie.  Wow.

Even if you don't care about latency (I'm not an audio person or
anything), these changes should be worth it.

> Deleting with ReiserFS and the preempt kernel is GREAT!

Good. I/O latency should be great now, with little change in
throughput...

> But I get some hiccup during noatun (mp3, ogg, etc. player for KDE-2.2) or 
> plaympeg together with dbench (16, 32). ReiserFS needs some preemption
> fixes, too?

You may still get some small hiccups ( < 1 second?) even with the
preemption patch, as kernel locks prevent preemption (the patch can't
guarentee low latency, just preemption outside of the locks).

However, how bad was the hiccups with preemption disabled?  I have heard
reports where it is 3-5sec at times.

As the kernel becomes more scalable (finer-grain locking), preemption
will improve.  Past that, perhaps during 2.5, we can work on some other
things to improve preemption.

> I've attached two small compressed bonnie++ HTML files.

These were neat, thanks.

Thank you for your feedback and support.  Stay current with the kernel
and the preemption patches, and I will try to figure the ReiserFS
crashes out.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

