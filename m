Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWF3Rzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWF3Rzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 13:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWF3Rzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 13:55:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8684 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751172AbWF3Rzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 13:55:54 -0400
Date: Fri, 30 Jun 2006 19:55:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Rahul Karnik <rahul@genebrew.com>,
       Jens Axboe <axboe@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
Subject: suspend2 merge [was Re: [Suspend2][ 0/9] Extents support.]
Message-ID: <20060630175523.GA5939@elf.ucw.cz>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606282242.26072.nigel@suspend2.net> <84144f020606280742v348bdf53w96bd790362abaff9@mail.gmail.com> <200606290937.31174.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606290937.31174.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It's because it's all so interconnected. Adding the modular
> > > infrastructure is useless without something to use the modules. Changing
> > > to use the pageflags functionality requires modifications in both the
> > > preparation of the image and in the I/O. There are bits that could be
> > > done incrementally, but they're minor. I did start with the same codebase
> > > that Pavel forked, but then did substantial rewrites in going from the
> > > betas to 1.0 and to 2.0.
> >
> > Hmm, so, if you leave out the controversial in-kernel stuff like, user
> > interface bits, "extensible API", compression, and crypto, are you
> > saying there's nothing in suspend2 that can be merged separately?
> 
> My point was that the architecture of Suspend2 is fundamentally different to 
> that of swsusp. Suspend2 features could potentially be added to swsusp, but 
> it would require a lot of work on swsusp. I've worked hard to make

That is how kernel development works, I'm afraid. It is better to let
someone do lot of work than to have to merge 14000 lines in one go.

It sucks if that "someone" is you, I guess.

Kernel development works by evolution, unless there's really good
reason not to. And no "swap file support for suspend" is not good
enough reason. Maybe suspend2 was designed to be nice, fast, and full
of features; unfortunately it was not designed to be
mergeable. Oops. I believe you even stated that you do not want it
merged at one point.

There are two possible ways forward:

1. suspend2 stays out of tree, pretty much forever. (Or as long as you
are interested).

2. suspend2 gets complete rewrite, using code that is already present
in kernel to maximum extent. Yes, you need to do "evolution", merge
quickly, and make clear improvement with each patch. You also have to
explain why your patch is neccessary -- why current code can not do
the job. Fortunately for you,all the neccessary support is already in
tree. Only piece missing is "save whole image", and Rafael actually
has patch for that -- but that patch was deemed too dangerous.

Now, I'm sorry you wasted lots of work splitting patches
function-by-function, but watching lkml for a while would probably
tell you how mergeable patches look, and I believe I was pretty clear
that splitting suspend2 is not the _only_ requirement to get it
merged.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
