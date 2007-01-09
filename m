Return-Path: <linux-kernel-owner+w=401wt.eu-S1751386AbXAINRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbXAINRR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 08:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbXAINRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 08:17:17 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:4566 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751386AbXAINRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 08:17:17 -0500
Date: Tue, 9 Jan 2007 14:17:21 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Adrian Bunk <bunk@stusta.de>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/pci/quirks.c: cleanup
Message-Id: <20070109141721.b823187c.khali@linux-fr.org>
In-Reply-To: <20070109030226.GA2408@jupiter.solarsys.private>
References: <20061219041315.GE6993@stusta.de>
	<20070105095233.4ce72e7e.khali@linux-fr.org>
	<20070107154441.GB22558@jupiter.solarsys.private>
	<20070108121055.d25c8ffa.khali@linux-fr.org>
	<20070109030226.GA2408@jupiter.solarsys.private>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, 8 Jan 2007 22:02:26 -0500, Mark M. Hoffman wrote:
> Jean:
> 
> * Jean Delvare <khali@linux-fr.org> [2007-01-08 12:10:55 +0100]:
> > Hi Mark,
> > 
> > On Sun, 7 Jan 2007 10:44:41 -0500, Mark M. Hoffman wrote:
> > > It is fragile for this code to depend on link order; Adrian's obvious and
> > > trivial cleanups broke it.  Not only that, but some FC kernels had/have the
> > > link order reversed such that this quirk is broken anyway.
> > 
> > The former problem would be addressed just fine by a proper ordering
> > (as Adrian's patch was attempting to bring) and a comment explaining
> > the dependency.
> 
> That's still fragile.  Someone is bound to reorder the stupid things by
> mistake (again).  I'm tired of screwing around with this quirk already.
> The patch that I sent last May would have fixed it permanently.  And the
> funny part is that *you* suggested the fix. ;)

I seem to remember I suggested an improvement to make your fix better,
but the fix was originally yours. Not that it really matters, anyway.

> > > I sent a patch for this back in May:
> > > http://lists.lm-sensors.org/pipermail/lm-sensors/2006-May/016113.html
> > > 
> > > There was some discussion on the linux-pci mailing list as well; can't seem to
> > > find an archive of that though.  Basically, it was not understood how the FC
> > > kernels could have a reversed link order.  I never followed up on it, my bad.
> > 
> > As long as it isn't explained, I call it a compiler bug in FC.
> 
> 1) What standard specifies the link order of objects in a module?  I have seen
> other compilers reorder objects this way.

I can't say, sorry, I'm no compilation expert. It just sounded logical
to me that the compiler should keep the code in the same order it found
it in the sources, but it looks like this quirks code is very special.

> 2) So what if it was a compiler bug?  I guess we don't allow patches to work
> around compiler bugs.

Depends, as far as I remember, workarounds for mainline gcc are OK, but
workarounds for distro-specific gcc are not. But one may argue that
your patch isn't adding a workaround but cleaning up the code, then it
no longer matters.

> 3) I've just confirmed that this quirk is still broken on recent FC6 kernels.
> Perhaps they should have picked my patch out of their bugzilla, but they didn't.

I am worried about the Intel/Asus SMBus quirk then, which affects many
more users than the SiS SMBus one, and would suffer from a reordering as
well.

-- 
Jean Delvare
