Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWAUAgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWAUAgf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWAUAgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:36:35 -0500
Received: from free.wgops.com ([69.51.116.66]:45833 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S932319AbWAUAge convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:36:34 -0500
Date: Fri, 20 Jan 2006 17:36:21 -0700
From: Michael Loftis <mloftis@wgops.com>
To: lgb@lgb.hu, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <DA31AE528A022A540AF35840@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <20060120170851.GA11489@lgb.hu>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 <20060120170851.GA11489@lgb.hu>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 20, 2006 6:08:52 PM +0100 Gábor Lénárt <lgb@lgb.hu> wrote:

> Though I'm not a kernel developer let me allow to comment this based on
> my experiences as well.
>
> On Fri, Jan 20, 2006 at 08:17:40AM -0700, Michael Loftis wrote:
>> OK, I don't know abotu others, but I'm starting to get sick of this
>> unstable stable kernel.  Either change the statements allover that were
>
> What kind of instability have you got? I haven't had any instability since
> at least a year or so, or if there was it was some kind of hardware fault.
> In fact, many machines (like an Armada E500 notebook and some servers as
> well) seems to be stable which was NOT in case of 2.4 kernels! So for our
> experience at our workplace, 2.6 seems to be much more usable than 2.4.x
> kernels (ok, it may be caused by "newer" hardwares, on quite old machines
> I can't show major difference in stability between 2.4 and 2.6)

There's two parts of stable in most of the development world, runs on my 
hardware reliably/runs on most hardware reliably is one part, the other 
part is limited change, usually limited to bugfixes and minor feature fixes 
or updates.  This means that instead of having to take how ever many 
(probably thousands on thousands) of lines of difference, and any of those 
potential new bugs etc, to a much reduced set that just deals with specific 
subsections in order to close specific bugs.  Be it a minor change to fix 
support for a new PCI ID, or a a buffer overflow.  API changes or 
relocation of headers and such would be kept out of a stable branch.  It's 
that second part I hear see and have objections about with 2.6 as it sits. 
There's no 'place' for bugfixes to centralize.  I know that a number of my 
problems are fixed in later kernels, but there's a LOT of fairly large 
change between where I am, and where current is.  Far more than would be in 
a normal stable piece of software.

<...>

> Ah, I see your point. But is it really a BIG problem? I mean please
> mention some *real* issue/story confirm your opinion. Sure, you can find,
> but also compare it with the advantages of new development model, since
> there is nothing in the world which is only have advantages neither
> something which only has disadvantages ... The would is not black or
> white, but a great spectrum of gray shades.

Yup, from 2.6.8 sometime after 2.6.8 aic7xxx is pretty clearly broken from 
many reports I've seen, it was finally fixed in 2.6.15 (I do not know hte 
bug exactly, sorry, I'm using others reports).  In 2.6.8 it's a little 
broken, but mostly working.  If there had been a major bug between there 
and .15 that required me to upgrade to close a security hole I'd have been 
stuck, unable and impossible to upgrade, for that one reason alone.  Worse 
than that because there is so much major change now I have to stress test 
basically every kernel before we can actually start to use it at my day 
job.  We host well over 10k busy mostly dynamic (PHP, Perl, Miva, other 
stuff) web sites on a cluster of Linux based servers.  If there's subtle 
problems they show up in a big way usually, and having them in production 
is not acceptable.

If there was a stable branch with a low change rate then it's easy to track 
the changes even just 'visually' without necessarily having to go through a 
whole stress testing procedure.

I'm not saying an increased/rapid development pace is a bad thing.  I'm 
just wondering where the refuge from that is for systems that don't need, 
don't want, or really can't have that level of change happening, without 
resorting to maintaining ones own kernel fork.  It's one thing to 
compile/package ones own custom packages for a distro when you're already 
using custom kernels or not using their kernel, or even if you're just 
using your own, it's another to actually really maintain your own tree by 
oneself.

Yes I agree with what others have said, it gets to be more and more work. 
Perhaps something along the lines of 3 6 or 9 months with 1 or 2 'community 
supported stable releases'  -- in my day job i'd personally like to see 
longer terms, but ~6 months would be manageable atleast as to major change 
bumps.

>
>> Yes, I'm venting some frustrations here, but I can't be the only one.  I
>> know now I'm going to be called a troll or a naysayer but whatever.  The
>> fact is it needs saying.  I shouldn't have to do major changes to
>> accomodate sysfs in a *STABLE* kernel when going between point revs.
>> This  is just not how it's been done in the past.
>
> sysfs should not used by an average application, I guess, so it's not a
> major point

No not in itself.  I'm looking at a LOT bigger issue.  Everyone seems to 
want to look at and work with a tiny little piece, but there's the bigger 
issue of what is stable.  What does it mean to be stable.  In the minds of 
the people I've worked with directly it's always meant the two things 
outlined earlier.  Runs reliably, and is in a maintenance mode (yes, 
synonymous maybe with stagnant).  That means that it is necessarily a fork, 
away from the main line(s) of development and work.  But it serves a 
purpose in many environments.  It's utility is lost in the average desktop, 
but in the corporate desktop, in servers, embedded devices, commercial 
products, etc. it's a big win.


