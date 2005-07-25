Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVGYWHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVGYWHO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 18:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVGYWHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 18:07:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22944 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261192AbVGYWHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 18:07:11 -0400
Date: Tue, 26 Jul 2005 00:06:59 +0200
From: Pavel Machek <pavel@suse.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/2] Touchscreen support for sharp sl-5500
Message-ID: <20050725220659.GF8684@elf.ucw.cz>
References: <20050722180109.GA1879@elf.ucw.cz> <20050724174756.A20019@flint.arm.linux.org.uk> <20050725045607.GA1851@elf.ucw.cz> <20050725170419.C7629@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050725170419.C7629@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > This adds support for reading ADCs (etc), neccessary to operate touch
> > > > screen on Sharp Zaurus sl-5500.
> > > 
> > > I would like to know what the diffs are between my version (attached)
> > > and this version before they get applied.
> > 
> > Hmm, diff looks quite big (attached), and I got it from lenz for 99%
> > part.
> 
> It looks like John's version is actually based on a previous revision
> of this driver. 8/

Oops.

> > I have made quite a lot of cleanups to touchscreen part, and it seems
> > to be acceptable by input people. I think it should go into
> > drivers/input/touchscreen/collie_ts.c...
> 
> Err, why should my assabet touchscreen be called "collie_ts" ?
> collie is just a platform which happens to use it - it's got
> no relevance to the driver naming at all.

Okay, I did not quite realized it was shared.

> > Also it looks to me like mcp.h should go into asm/arch-sa1100, so
> > that other drivers can use it...
> 
> That doesn't make sense when you have other non-SA1100 devices using
> mcp-core.c.  Whether that happens or not I've no idea - I can't see
> what everyone's using out there (just like I've absolutely zero
> idea what collie folk are doing or not doing.)

set_telecom_divisor relies on CONFIG_SA1100 being set (otherwise it
breaks compilation, because struct members will not be available; at
least in this version), so I doubt it has many non-SA1100 users...

> > > The only reason my version has not been submitted is because it lives
> > > in the drivers/misc directory, and mainline kernel folk don't like
> > > drivers which clutter up that directory.  In fact, I had been told
> > > that drivers/misc should remain completely empty - which makes this
> > > set of miscellaneous drivers homeless.
> > 
> > Could they simply live in arch/arm/mach-sa1100? Or is arch/arm/soc
> > better place?
> 
> arch/arm/soc?  That means that (a) we end up with another directory to
> accumulate crap, (b) it's not a SoC so doesn't belong in a directory
> named as such, (c) it means that the MCP and UCB drivers get their
> individual files scattered throughout the kernel tree, one in this
> directory, one in that directory, one in another random directory.
> That's far from ideal.

Well, I believe that UCB layer is quite well define and it looks quite
okay for touchscreen driver to be near other touchscreens... ucb-core
still needs to go somewhere, if drivers/misc was vetoed, perhaps
arch/arm/misc would be okay?

> Anyway, summarising this, the results are that what we have here is
> a complete and utter mess. ;(

Yep :-(.

> So, if the collie folk would like to clean their changes up and send
> them to me as the driver author, I'll see about integrating them into
> my version and we'll take it from there.

Okay, will do. [Is there chance to pull your tree using git? It would
help a bit...]
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
