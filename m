Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUHBUr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUHBUr3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 16:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUHBUr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 16:47:29 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:14220 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263147AbUHBUrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 16:47:25 -0400
Date: Mon, 2 Aug 2004 21:45:53 +0100
From: Dave Jones <davej@redhat.com>
To: Ian Romanick <idr@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
Subject: Re: DRM code reorganization
Message-ID: <20040802204553.GC12724@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ian Romanick <idr@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
	DRI developer's list <dri-devel@lists.sourceforge.net>
References: <20040802155312.56128.qmail@web14923.mail.yahoo.com> <410E81C3.2070804@us.ibm.com> <20040802185746.GA12724@redhat.com> <410E9FEE.60108@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410E9FEE.60108@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 01:11:26PM -0700, Ian Romanick wrote:

 > > > This would be *very* non-trivial to do.  Doing the DRM like this has 
 > > > come up probably a dozen times (or more) over the last 3 years.
 > >Which should ring alarm bells that something might not be quite right.
 > And that it hasn't been done all those times should be a sign of 
 > *something*. ;)

heh. I'd attribute it to the fact that it's tedious monotonous work
doing cleanup work like this, as opposed to 'sexy' work, like hacking
on something new.  Personally, I've always found something more important
to be doing.  Maybe I can find some more time to look into it soon.

 > 1. There is a lot more variability among graphics cards that there is 
 > among, say, network cards.  Look at the output of 'grep __HAVE_ | grep 
 > define' on any two <card>.h files to see what I mean.  The output for 
 > tdfx.h and radeon.h, or mga.h and savage.h is *very* different.  That, 
 > by itself, makes a huge difference on what code is needed.

The __HAVE_ stuff is another pet gripe of mine.
In particular, the mish-mash of __HAVE_AGP , __REALLY_HAVE_AGP, __MUST_HAVE_AGP
flags have bugged me for a long time.

 > 2. We have an extra dimension to our matrix.  Most other drivers don't 
 > need to worry about working on BSD.

I'm hesitant to name them, but there are drivers in the tree which
whilst not shining examples of what-to-do, they do a far better
job of running on both OS's. Some with abstraction layers and such,
but with nothing remotely as convoluted as drm IMO.

 > 3. The ever classic....It seemed like a good idea at the time.

Reminds me of someone I know who starts amusing stories with the
sentence.. "So, we had a few beers and...", though after reading
some of that code I suspect something much stronger 8-)

 > >If this kind of abuse wasn't so widespread, abstracting this code
 > >out into shared sections and driver specific parts would be a lot
 > >simpler. Sadly, this is the tip of the iceberg.
 > 
 > I think it comes down to the fact that the original DRM developers 
 > wanted templates.  C doesn't have them, so they did the "next best" thing.

I vaguelly recall the code at one point not looking quite 'so bad',
it just grew and grew into this monster.  I'm sure it was done originally
with the best of intentions, but it seems someone along the line got
a bit carried away.

 > >To give an example of just how bad some folks view on this code is:
 > >An actual conversation at OLS last week..
 > >"I found it easier to look at the C preprocessor output than the
 > > actual source code to find the types of the variables I was looking at".
 > That's not surprising.

Maybe we can introduce that code as a starting point :-)

 > That's by design.  I've been working on the 
 > open-source 3D drivers for 3 years, and I've made *maybe* 4 changes to 
 > the kernel code.

Sure. One thing that the DRM code has actually done right is to move the
bits that need arbitration to the kernel, whilst leaving all the fun
bits in userspace. (well, mostly).

 > >I'd estimate I wasn't even a fraction of the way through, and I lost
 > >the will to keep fighting.
 > 
 > That's the core question.  Everyone *knows* that the current DRM code is 
 > an ugly mess, but is it worth the effort at this point to fix it?  You 
 > seem to have come to the same conclusion that everyone else that's 
 > looked at the problem over the last 2 years has.

I think with a coordinated effort, and with an ACK by the folks who maintain
this code on a day-to-day basis, it's worth at least heading in the right
direction.

 > I think the only realistic approach is to attack the problem bit by bit, 
 > rather than en masse.  Gradual elimination of the '#if __HAVE_FOO' and 
 > gradual datatype refactoring is really the only way to attack it.  The 
 > problem is just too big and there are just too few interested developers.

Sounds realistic.  As I mentioned in my last mail, my 'work on one driver
at a time, ridding it of macros etc' led to nothing mergable, and was only
just at the stage where it was compiling again. I'd warn off anyone trying
to do what I tried. I learned a few things along the way, but the end result
wasn't where any of us want things to be.

		Dave

