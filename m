Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUH0RhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUH0RhH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 13:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUH0RhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 13:37:07 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:64357 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264665AbUH0Rg7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 13:36:59 -0400
Date: Fri, 27 Aug 2004 19:38:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: maintaining DRM and using bitkeeper..
Message-ID: <20040827173807.GB7445@mars.ravnborg.org>
Mail-Followup-To: Dave Airlie <airlied@linux.ie>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408270043170.25111@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408270043170.25111@skynet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 12:57:56AM +0100, Dave Airlie wrote:
> 
> Okay I want to ask other groups of developers how they are maintaining
> subsystems away from linux-kernel list and how they get things merged?
> 
> The biggest problem we are facing with the DRM is getting things tested
> before submitting them to Linus as the last thing we want to happen is to
> destabilise the DRM code in the kernel, the two testing paths are
> a) DRM CVS, this gets picked up in DRI snapshots and tested quite heavily
> - this is by far the most successful testing path for the DRM
> b) the -mm tree is more useful for picking out non-x86 (sparc usually)
> users,
> 
> At the moment I put patches into the BK CVS first, we stabilise them, I
> take the CVS changes and patch them into bitkeeper, Andrew picks them up,
> we find more bugs I fix em in bitkeeper and put em back in CVS, now
> however the bk tree hasn't got a unique patch for a fix, it has a bunch of
> changesets that are the initial patch plus the fixes for it,
> 
> Now if I submit to Linus via the -bk tree I'm screwed when he either a)
> rejects an idea in the tree or b) doesn't respond at all, as I can't just
> have him pull up the changesets that matter as a lot of them have been
> crossed over by core kernel cleanup patches and bk is getting very shirty
> with me about undo and excluding things...if I submit patches to Linus and
> he puts them into his tree then I'll be continually dumping my bk trees
> and starting again
The bk way-of-working is to have several bk trees around each with independent
patches.


Consider the following:

linux-2.6
(bk://linux.bkbits.net/linux-2.6)
      |
      +- clone/pull --> (edit) DRM remove macros
      |                        |
      |                        +- clone/pull --> (edit) DRM add driver1
      |                        |
      |                        +- clone/pull --> (edit) DRM fix driver2
      |
      +-clone/pull --> (edit) DRM add driver3
      |
      +- clone/pull --> (wild editing) DRM sandbox
      |
      |
      |
      |
      +- clone/pull --> (pull) DRM-for-linus

DRM-for-linus is the tree you push to bk://drm.bkbits.net/for-linus
When Linus (or lkml) respond you have to do something dramatically different
you may need to drop the DRM-for-linus tree and start all over.
But you should realise that the tree named DRM-for-linus you _never_ edit in that tree.
It is only used to pull from the edited tree to collect changes to send off til Linus.

The aboce to some degree reflect branches in CVS - you just have several individual
trees in bk.

[Larry has saind many times that when you start to use several trees you have started
to understand how to use Bitkeeper efficiently].

You may also be able to convince Andrew to suck from the for-linus tree at bkbits,
so all changes you push will go into next -mm.
That works very well for kbuild for example.


Another thing you should realise is that flag-day patches are NOT welcome.
The ongoing effort removing macors are better included in the kernel as 20
small steps rather than 1 big patch.

In other words it is so much easier to get 10 small patches touching 2000 lines
in total accepted, compared to one big patch.
With smaller individual patches you also keep the history etc.


 
> So I'm asking is there a better way, considering at this stage I'm not
> *trusted*, the DRM is an unholy mess and I'm the only one stupid enough to
> step up and do anything about it ... 
s/stupid/smart/

>(you should see the DRM in CVS at the
> moment it is so much easier to work with without a lot of macros,
> unfortunately it won't go into the kernel anytime soon....)

May I ask why not?

	Sam
