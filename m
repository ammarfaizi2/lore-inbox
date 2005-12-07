Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbVLGSRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbVLGSRF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbVLGSRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:17:05 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:30683
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751337AbVLGSRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:17:04 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Wed, 7 Dec 2005 12:14:25 -0600
User-Agent: KMail/1.8
Cc: Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
References: <20051203135608.GJ31395@stusta.de> <200512051158.06882.rob@landley.net> <4395DDA8.8000003@tmr.com>
In-Reply-To: <4395DDA8.8000003@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071214.26574.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 December 2005 12:51, Bill Davidsen wrote:
> Just so we're all on the same page, I think there are two sets of
> unhappy people here... one is the group who want new stuff fast and
> stable. For the most part that's not me, although I was in the "if
> you're going to add ipw2200 support, why not something that works?"
> group. But new stuff is going in faster than most people can assimilate
> it if they have a real job, so I don't see too much problem there.

My laptop has an ipw2200 but I can't get it to work in any kernel I built 
because the kernels I build aren't modular.  I hope to be able to work around 
this someday with a clever enough initramfs (if necessary, moving the 
initramfs initialization earlier in the boot sequence), but it hasn't made it 
far enough up my todo list yet.

So whether or not the driver actually works if I could get it initialized is, 
for me, a moot point.

> The other group is the people who use and depend on some feature, be it
> cryptoloop, 8k stacks, ndiswrapper, ipchains, whatever... which is

Ndiswrapper isn't a kernel feature.  Don't confuse the shark with the remoras.

The only complaint about 8k stacks I've heard is the ndiswrapper people, and 
8k isn't actually sufficient for them anyway (_their_ ad-hoc spec guarantees 
12k), so they should have been swapping to their own stack all along.  They 
should probably even statically allocate the sucker at boot time and 
serialize all drivers using it with a semaphore, because I _really_ doubt 
it's ever been preempt-safe.

Isn't ipchains obsolete since 2.2?  it was already deprecated back in 2.4.  
There has been quite adequate warning on that one, thanks very much.

I'm under the impression the problem with cryptoloop is bad cryptography:
http://lwn.net/Articles/67216/

Anybody actually using cryptography with an expoitable weakness needs all the 
wake-up calls they can get.  This is _not_ a case where you want to support 
old broken crap, that defeats the whole purpose of using cryptography in the 
first place.

Especially the cryptoloop removal was an intentional decision that the kernel 
developers made.  People raised their objections at the time, and these were 
taken into consideration when making the decision:
http://kerneltrap.org/node/2433

Re-raising the same objections over and over again when they've already been 
aired, considered, and rejections is called "whining".

> scheduled for extinction. That's a departure from the way 2.{0,2,4} were
> done, where adds happened regularly, but features were only deleted in 
> development trees.

If features were really were deleted in development trees, devfs and ipchains 
never would have made it through 2.4.  So you're talking about an idealized 
version fo the past that doesn't match what people actually did back then. 

> Deleting features leaves anyone who can't keep their 
> own tree without security fixes.

Security fixes are a separate issue.

I asked for one more security fix to flush the pending fixes queue a while 
ago:
http://seclists.org/lists/linux-kernel/2005/Nov/4187.html

On Saturday, stable series co-maintainer Chris Wright decided it might be 
worth a try:
http://seclists.org/lists/linux-kernel/2005/Dec/0740.html

  > About the only thing I think is helpful in this case is perhaps 
  >  one extra -stable cycle on the last branch when newest branch is released 
  >  (basically flush the queue). That much I'm willing to do in -stable. 

To which I replied (and again I quote), "Yay, rah, cool!".

This gives you a trail of breadcrumbs to follow.  There are a series of 
incremental patches (which may have to be fixed up to apply) that address the 
known security-specific issues.

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
