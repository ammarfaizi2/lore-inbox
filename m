Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbWBTRgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWBTRgL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbWBTRgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:36:11 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:48644 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1161071AbWBTRgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:36:09 -0500
Date: Mon, 20 Feb 2006 18:36:08 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andreas Happe <andreashappe@snikt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220173608.GC33155@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andreas Happe <andreashappe@snikt.net>,
	linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1140437152.3429.20.camel@mindpipe> <20060220123122.GA6086@dspnet.fr.eu.org> <200602201513.23849.rjw@sisk.pl> <20060220153922.GA17362@dspnet.fr.eu.org> <slrndvjrfb.2o0.andreashappe@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrndvjrfb.2o0.andreashappe@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 04:27:24PM +0000, Andreas Happe wrote:
> through using the userspace helper he is able to use existing maintained
> libaries, something that isn't possible with kernelspace suspend. This
> is real code reduction.

The only thing that is said will be used by uswsusp that isn't already
in the kernel in lzf.  md5 is there twice, crypto is there.  lzf it
seems belongs in cryptoloop too according to some of the reactions.


> > md5 is already in the kernel (twice).  lzf is already in suspend2 (and
> > arguably useful for more things than only suspending),
> 
> Why (when LZF would be useful for other stuff) nobody proposed inclusion
> of it?

You missed all the messages of people who would like it in cryptoloop
for compressed filesystems?  Part of the problem it seems with Nigel's
code is that it is stamped "suspend2", and nobody looks for useful
code in there.


> >> The problem is to merge suspend2 we'd have to clean it up first and
> >> actually solve some problems that it works around.  That, arguably,
> >> would be more work than just implementing some _easy_ stuff in the
> >> user space.
> >
> > Stuff that is _already_ _done_ and working.
> 
> While reading this 'discussion' I get the expression that swsusp isn't
> working. But this isn't true: it works for me since I can't remember
> when. The only problems were with some modules (ieee1394 had to be
> unloaded before suspending) and minor glinches (writing the image
> sometimes _very_ slow when suspending from a powersave cpufreq
> governor..).

It hasn't worked for me reliably on any of the dell laptops we have
around.  Driver problem, irq problem, who knows.  Pavel would sure
like to have these problems fixed, no doubt about that, but uswsusp
has nothing to do with fixing them.  The entire point of uswsusp is to
have progress bars, compression and encryption.  It has _nothing_ to
do with the reliability of suspend itself.

Suspend2 already has the progress bars and stuff.  Hence the "already
done and working".


> > 1- will uswsusp solve problems suspend2 doesn't?  Real, currently
> >    encountered problems, not philosophical problems about
> >    kernel/userspace code positions[2].
> 
> swsusp works for me (TM), no problems at all, siree

That does not answer the question.  If there are no problems with
swsusp, there is no need for either suspend2 or uswsusp.


> >    In particular, since according
> >    to Pavel 90+% of the problems are driver issues, why aren't you
> >    concentrating on drivers?
> 
> so submit driver specific patches through the driver's maintainer? Where
> does Pavel enter the picture?

Pavel is the swsusp maintainer.  Pavel is the one defining the
interfaces drivers have to conform to to play ball.  Quality and
documentation of these interfaces is what makes the difference when
you have to use them in the drivers.

At that point, with the last clash with Linus, I don't really know
what has to be done with IRQs in particular.


> > 3- if the main problem is really that some parts of suspend2 should be
> >    in userspace instead of kernelspace, why aren't you working from the
> >    appropriate parts of the suspend2 code to port them to userspace use
> >    instead of going to coreutils/libLZF/etc?
> 
> code dupplication?

Duplicating what?  There are multiple implementations, some in
suspend2, some in libraries.  The suspend2 ones, as kernel routines,
are designed to work in a constrained environment, fs, network and
memory-wise.  The library ones aren't.  Uswsusp needs code that works
in a constrained environment.  So the technically clueful way is to
start from the libraries?


> > 4- why aren't you actively working at pushing the parts of suspend2
> >    that actually are good and potentially useful to uswsusp in the
> >    mainline kernel.  Do you really think nothing is worthwhile in there?
> 
> Maybe the mentioned problems with bitmaps and the module infrastructure
> could explain that. Even Nigel said that the problem with evolutionary
> patches is that suspend2 changes some fundamentals.

For some people, like you, swsusp works as-is.  Good.  For some more
people, swsusp doesn't work reliably, while suspend2 does.  So there
are some things in suspend2 that are better than the current
implementation.  I see zero effort to find out what these things are 


> > Are you really, really sure you're not rejecting suspend2 in bulk
> > because you didn't write it?  Do we need a John W. Linville as suspend
> > maintainer for things to go better?
> 
> Are you really threatening Pavel's position as maintainer? how subtle.

Am I?  I have _zero_ authority over who maintains what, you know.  I
know that, Pavel knows that, Rafael knows that.  And I never said
Pavel or Rafael were not competent, quite the contrary.  I'm just
casting some doubt on their current methods.  I don't like seeing
anymore throwing of the baby with the bathwater going on than strictly
necessary.



> > [2] Otherwise you can start net5 in userspace just because it doesn't
> > absolutely need to be in kernelspace.
> 
> it seems like "Van Jacobson's network channels" [0] would move some
> stuff to userspace. Are you volunteering? (dislaimer: I have just
> glimpsed at the article).
> 
> [0] http://lwn.net/Articles/169961/

Obviously not.  I think networking belongs to the kernel, and moving
things to userspace because it somehow magically makes maintenance
easier is complete bullshit.  I have criteria to decide what should be
in the kernel and what should be in userspace, and networking squarely
belongs in kernelspace.

  OG.

