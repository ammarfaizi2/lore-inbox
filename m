Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135990AbRDTTKF>; Fri, 20 Apr 2001 15:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135993AbRDTTJ6>; Fri, 20 Apr 2001 15:09:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10511 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S135990AbRDTTJi>;
	Fri, 20 Apr 2001 15:09:38 -0400
Date: Fri, 20 Apr 2001 20:08:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Eric S. Raymond" <esr@thyrsus.com>, Nicolas Pitre <nico@cam.org>,
        Tom Rini <trini@kernel.crashing.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>,
        lkml <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Message-ID: <20010420200859.B5510@flint.arm.linux.org.uk>
In-Reply-To: <20010420085148.V13403@opus.bloom.county> <Pine.LNX.4.33.0104201206250.12186-100000@xanadu.home> <20010420125005.B8086@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010420125005.B8086@thyrsus.com>; from esr@thyrsus.com on Fri, Apr 20, 2001 at 12:50:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 12:50:05PM -0400, Eric S. Raymond wrote:
> Nicolas Pitre <nico@cam.org>:
> > Why not having everybody's tree consistent with themselves and have whatever
> > CONFIGURE_* symbols and help text be merged along with the very code it
> > refers to?  It's worthless to have config symbols be merged into Linus' or
> > Alan's tree if the code isn't there (yet).  It simply makes no sense.

Really, the above issue is down to the sub-architecture maintainers splitting
up their patches into the "one feature, one bug" thing, rather than "one
set of files" (which, incidentally I'm guilty of as well).  That way, when
stuff gets added, you get:

1. The C source changes for that item
2. The configure script stuff for that one item
3. The help text for that one item.

Currently, stuff that comes to me appears mostly as "here's a configure
update", "here's a PCMCIA update", etc.  I'll pull out an instance from
my patch tracking system (sorry, Philip, yours is the first one I found):

Patch 413/1 (see http://www.arm.linux.org.uk/developer/patches/?id=413/1&mode=patch)
This patch adds the defconfig file for the CLPS7500 architecture, and it
contains symbols such as:

	CONFIG_BLK_DEV_FLD7500
	CONFIG_CLPS7500_FLASH

Neither of these two drivers are currently in Linus' tree, or in fact my
tree.  Should I reject the patch?  Should I accept it and edit these out,
or what?

> And now it has a cost, too.  It makes finding real bugs more difficult.

Well, if they get removed in Linus tree, then when I next sync, they'll get
re-added, or maybe they won't.  Then someone else will remove them, then
they'll get re-added ad infinitum.

This also touches on another issue - patch.  I've had several times where
I've sent Alan stuff, its gone up to Linus, I receive it back, and during
the merge, patch does its stuff without complaining (because there is not
enough context in the diff).  Typically, this happens in the Configure.help
file.

Generally it seems like diff needs to produce one more line of context, and
most of these problems will go away.  Yes, there will still be the odd
problem, so then it becomes the "how much do you crank the setting" problem.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
