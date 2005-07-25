Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVGYQEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVGYQEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 12:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVGYQEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 12:04:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1289 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261239AbVGYQEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 12:04:24 -0400
Date: Mon, 25 Jul 2005 17:04:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/2] Touchscreen support for sharp sl-5500
Message-ID: <20050725170419.C7629@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
	vojtech@suse.cz
References: <20050722180109.GA1879@elf.ucw.cz> <20050724174756.A20019@flint.arm.linux.org.uk> <20050725045607.GA1851@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050725045607.GA1851@elf.ucw.cz>; from pavel@suse.cz on Mon, Jul 25, 2005 at 06:56:07AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 06:56:07AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > This adds support for reading ADCs (etc), neccessary to operate touch
> > > screen on Sharp Zaurus sl-5500.
> > 
> > I would like to know what the diffs are between my version (attached)
> > and this version before they get applied.
> 
> Hmm, diff looks quite big (attached), and I got it from lenz for 99%
> part.

It looks like John's version is actually based on a previous revision
of this driver. 8/

> I have made quite a lot of cleanups to touchscreen part, and it seems
> to be acceptable by input people. I think it should go into
> drivers/input/touchscreen/collie_ts.c...

Err, why should my assabet touchscreen be called "collie_ts" ?
collie is just a platform which happens to use it - it's got
no relevance to the driver naming at all.

> Also it looks to me like mcp.h should go into asm/arch-sa1100, so
> that other drivers can use it...

That doesn't make sense when you have other non-SA1100 devices using
mcp-core.c.  Whether that happens or not I've no idea - I can't see
what everyone's using out there (just like I've absolutely zero
idea what collie folk are doing or not doing.)

> > The only reason my version has not been submitted is because it lives
> > in the drivers/misc directory, and mainline kernel folk don't like
> > drivers which clutter up that directory.  In fact, I had been told
> > that drivers/misc should remain completely empty - which makes this
> > set of miscellaneous drivers homeless.
> 
> Could they simply live in arch/arm/mach-sa1100? Or is arch/arm/soc
> better place?

arch/arm/soc?  That means that (a) we end up with another directory to
accumulate crap, (b) it's not a SoC so doesn't belong in a directory
named as such, (c) it means that the MCP and UCB drivers get their
individual files scattered throughout the kernel tree, one in this
directory, one in that directory, one in another random directory.
That's far from ideal.

Anyway, summarising this, the results are that what we have here is
a complete and utter mess. ;(

So, if the collie folk would like to clean their changes up and send
them to me as the driver author, I'll see about integrating them into
my version and we'll take it from there.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
