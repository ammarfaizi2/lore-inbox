Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264157AbTEOSH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 14:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTEOSH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 14:07:27 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7694 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264145AbTEOSHP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 14:07:15 -0400
Date: Thu, 15 May 2003 14:14:25 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
In-Reply-To: <Pine.LNX.4.44.0305141827200.28093-100000@home.transmeta.com>
Message-ID: <Pine.LNX.3.96.1030515140149.30631H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Andrew Morton wrote:

> Linus Torvalds <torvalds@transmeta.com> wrote:
> >
> > And do you guys actually use a recent glibc snapshot? Do you ever expect 
> >  to?
> 
> I believe this effort is more targetted at teeny little embedded gadgets -
> devices which are very remote from workstations, desktops and servers.
> 
> Presumably the people who are programming such gadgets will know if they
> need futexes or not.
> 
> 
> We've never clearly addressed the issue of just how far the mainstream
> kernel should scale down, and how pluggable the various kernel components
> should be.
> 
> Retrofitting pluggability is hard (CONFIG_BLOCK_LAYER) but at the very
> least, we should make this effort for newly-added components.
> 
> 
> Assuming, of course, that we _do_ want to make the mainstream kernel scale
> that far down.  It could be argued that this is a role for vendors or other
> specialised parties.

Certainly the great effort some vendors put in making the kernel small
doesn't belong in the main kernel. But things which can relatively be made
optional, and I think that means futex, could. I like the idea of a tiny
kernel menu, with some painful detail about what happens if you remove a
feature. In many cases "breaks glibc" isn't an issue.


On Wed, 14 May 2003, Linus Torvalds wrote:

> 
> On Wed, 14 May 2003, Christopher Hoover wrote:
> > > 
> > > (I ran a futex-free ppc64 kernel.  It worked.)
> > 
> > Yep.  I'm run an ARM kernel as well.  Works fine.
> 
> And do you guys actually use a recent glibc snapshot? Do you ever expect 
> to? Do you ever expect to run a third-party specialized web-server or 
> database library? All things that can use futex'es, and probably will. 
> 
> I will strongly argue against making futexes conditional, simply because I 
> _want_ people to be able to depend on them in modern kernels. I do not 
> want developers to fall back on SysV semaphores just because it's too 
> painful for them to use the faster alternatives.

Clearly the call is yours, but if all the optional features with
capability impact are in a single menu, as proposed, then you avoid
having people mess up by doing the removal by hand.

Making it easier to use Linux for small applications seems like a good
thing, although I admit that's an activist rather than a technical point
of view.


On Wed, 14 May 2003, Linus Torvalds wrote:

> 
> On Wed, 14 May 2003, Andrew Morton wrote:
> > 
> > I believe this effort is more targetted at teeny little embedded gadgets -
> > devices which are very remote from workstations, desktops and servers.
> 
> And even there futexes are (a) faster and (b) smaller than SYSVIPC. So 
> assuming you ever want threading in an embedded world (not unlikely at 
> all, since things like DVD playback etc are mostly done with threads), you 
> want futexes.
> 
> > Presumably the people who are programming such gadgets will know if they
> > need futexes or not.
> 
> Yes. We can make tit a CONFIG option, and then force it to always be "y" 
> in the .config file. And then the people who really know and really care 
> can turn the "y" to a "n".

I would say that having it on a "tiny Linux" menu, labeled dangerous,
with an explanatory help message is less likely to cause trouble than
letting people view it as "an undocmented Linux config option to make
the kernel smaller and faster."

If you know what you will break it's less likely to be a surprise.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

