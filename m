Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265119AbSJaCzT>; Wed, 30 Oct 2002 21:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265122AbSJaCzT>; Wed, 30 Oct 2002 21:55:19 -0500
Received: from dp.samba.org ([66.70.73.150]:35259 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265119AbSJaCzR>;
	Wed, 30 Oct 2002 21:55:17 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Russell King <rmk@arm.linux.org.uk>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, tridge@samba.org
Cc: tytso@mit.edu
Subject: Re: What's left over. 
In-reply-to: Your message of "Wed, 30 Oct 2002 18:31:36 -0800."
             <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> 
Date: Thu, 31 Oct 2002 14:00:31 +1100
Message-Id: <20021031030143.401DA2C150@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> you wri
te:
> 
> On Thu, 31 Oct 2002, Rusty Russell wrote:
> > 
> > 	Here is the list of features which have are being actively
> > pushed, not NAK'ed, and are not in 2.5.45.  There are 13 of them, as
> > appropriate for Halloween.
> 
> I'm unlikely to be able to merge everything by tomorrow, so I will 
> consider tomorrow a submission deadline to me, rather than a merge 
> deadline. That said, I merged everything I'm sure I want to merge today, 
> and the rest I simply haven't had time to look at very much.
> 
> > In-kernel Module Loader and Unified parameter support
> 
> This apparently breaks things like DRI, which I'm fairly unhappy about,
> since I think 3D is important.

Yes, the patch stubs out inter_module_*, in favor of get_symbol() &
put_symbol().

This breaks the three users: one in drivers/mtd/ and two in
drivers/char/drm/.  I have a patch which fixes them (untested), or I
can simply put the inter_module_* code back in.

> > Fbdev Rewrite
> 
> This one is just huge, and I have little personal judgement on it.

It's been around for a while.  Geert, Russell?

> > Linux Trace Toolkit (LTT)
> 
> I don't know what this buys us.

Haven't looked at it.

> > statfs64
> 
> I haven't even seen it.

It's fairly old, but Peter Chubb said there was some vendor interest
for v. large devices.  Peter?

> > ext2/ext3 ACLs and Extended Attributes
> 
> I don't know why people still want ACL's. There were noises about them for 
> samba, but I'v enot heard anything since. Are vendors using this?

SAMBA needs them, which is why serious Samba boxes use XFS.  Tridge,
Ted?

> > Hotplug CPU Removal Support
> 
> No objections, but very little visibility into it either.

The controls are in driverfs etc, and that's always been in flux. 8(

The rest is v. small, basically extending ksoftirqd, workqueues and
migration threads to disable them.  Then it's all arch-specific.

> > Hires Timers
> 
> This one is likely another "vendor push" thing.
> 
> > EVMS
> 
> Not for the feature freeze, there are some noises that imply that SuSE may 
> push it in their kernels. 

They have, IIRC.  Interestingly, it was less invasive (existing source
touched) than the LVM2/DM patch you merged.

> > initramfs
> 
> I want this.

Good.  The big payoff is moving stuff out of the kernel, which can't
really be done in a stable series.

> > Kernel Probes
> 
> Probably.

Sent.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
