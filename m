Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269184AbRHBWUW>; Thu, 2 Aug 2001 18:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269188AbRHBWUN>; Thu, 2 Aug 2001 18:20:13 -0400
Received: from unthought.net ([212.97.129.24]:63170 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S269184AbRHBWUE>;
	Thu, 2 Aug 2001 18:20:04 -0400
Date: Fri, 3 Aug 2001 00:20:12 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
Message-ID: <20010803002012.F7650@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	"Jeffrey W. Baker" <jwbaker@acm.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010802234434.E7650@unthought.net> <Pine.LNX.4.33.0108021448400.21298-100000@heat.gghcwest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0108021448400.21298-100000@heat.gghcwest.com>; from jwbaker@acm.org on Thu, Aug 02, 2001 at 02:52:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 02:52:11PM -0700, Jeffrey W. Baker wrote:
> On Thu, 2 Aug 2001, Jakob Østergaard wrote:
> 
> > You fill up mem and you fill up swap, and you complain the box is
> > acting funny ??
> 
> The kernel should save whatever memory it needs to do its work.  It isn't
> my problem, from userland, to worry that I take the last page in the
> machine.  If the kernel needs pages to operate efficiently, it had better
> reserve them and not just hand them out until it locks up.

Sure, I agree,  to an extent.

If I start 50 CPU-bound jobs on my one-processor machine, I don't want the
kernel to tell me "no, you probably didn't mean to do that, I'll kill 40 of
your jobs so the others will go faster".    Same with resource usage - it's not
the kernel's job to implement that kind of policy - you have ulimits for
limiting your users, and if it's your own machine you should have enough
knowledge to know that deliberately using up every resource in the machine is
going to cause a resource shortage.

It is possible that there is a real problem and the kernel doesn't operate
efficiently in your case - I won't argue with that.   But you cannot expect
your system to perform very well if you use up all resources - maybe if you 
hit a real bug in your case, and if someone fixes it, the kernel will operate
efficiently under those circumstances - but userspace will *not* operate
very well if you want the OOM killer to regularly kill "production" jobs etc.

At least, you must be doing another kind of production that what I'm used to
  :)

> 
> > This is a clear case of "Doctor it hurts when I ..."  - Don't do it !
> >
> > I'm interested in hearing how you would accomplish graceful
> > performance degradation in a situation where you have used up any
> > possible resource on the machine.  Transparent process back-tracking ?
> > What ?
> 
> Gosh, here's an idea: if there is no memory left and someone malloc()s
> some more, have malloc() fail?

Actually, having malloc() fail is not that simple  :)

> Kill the process that required the memory?

Yes, you're perfectly right here.  If there's a critical shortage the OOM
killer should strike.

However - it should only strike the offending process (detecting that is hard
enough).  And it should not be possible for an attacker or untrusted user to
cause the OOM killer to kill anything but his own jobs.

> I can't believe the attitude I am hearing.  Userland processes should be
> able to go around doing whaever the fuck they want and the box should stay
> alive.

No offense was intended.

But if this things were really so simple, they would have been in the kernel
for ages.

I'm tempted to say:  Well your ideals seem to correlate well with the general
ideals of the LKML wrt. VM and OOM - it'd be great if you could post a patch to
fix it all properly     :)

We all want:  Perfect performance in both normal and resource-starved cases,
an OOM killer that strikes fairly when necessary and only when necessary,  a
userspace that's not just fool-proof but "very fool-proof", etc. etc.


>  Currently, if a userland process runs amok, the kernel goes into
> self-fucking mode for the rest of the week.

We know.

What is your suggestion for tackling this problem ?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
