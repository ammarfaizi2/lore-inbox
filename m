Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUBYP6i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 10:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUBYP6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 10:58:37 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:49403 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S261375AbUBYP60
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 10:58:26 -0500
Date: Wed, 25 Feb 2004 08:58:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Split kgdb into "lite" and "normal" parts
Message-ID: <20040225155823.GP1052@smtp.west.cox.net>
References: <20040218225010.GH321@elf.ucw.cz> <20040224232703.GC9209@elf.ucw.cz> <20040224233809.GK1052@smtp.west.cox.net> <200402251249.28519.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402251249.28519.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 12:49:28PM +0530, Amit S. Kale wrote:
> On Wednesday 25 Feb 2004 5:08 am, Tom Rini wrote:
> > On Wed, Feb 25, 2004 at 12:27:03AM +0100, Pavel Machek wrote:
> > > > > > > Tested (core-lite.patch + i386-lite.patch + 8250.patch)
> > > > > > > combination. Looks good.
> > > > > > >
> > > > > > > Let's first check this in and then do more cleanups.
> > > > > > > Tom, does it sound ok?
> > > > > >
> > > > > > This sounds fine to me.  Pavel, I'm guessing you did this with
> > > > > > quilt, could you provide some pointers on how to replicate this in
> > > > > > the future?
> > > > >
> > > > > Unfortunately, I done it by hand :-(. But if -lite parts are not
> > > > > merged, soon, I'll be forced to start using quilt. Doing stuff by
> > > > > hand is quite painfull...
> > > >
> > > > There's still a whole bunch of bogons in the -lite patch still, so I
> > > > don't think it should be merged yet.
> > >
> > > Well, it seems to contains a *lot* less bogons than what currently is
> > > in -mm series.
> > >
> > > What big problems do you see? It does not yet use weak symbols, but I
> > > do not think that's a serious problem. What else?
> >
> > The first two big ones are:
> > - Doesn't like gdb 6.0 (You cannot assume the first packet is Hc...)
> 
> Can you tell me more about this?

You make an assumption that the first packet is $Hc..., which you cannot
do.  gdb 6's first packet is $qOffsets.  I'll post the patch for this
shortly.

> > - Wierdities with kgdb_killed_or_detached / kgdb_might_be_resumed
> >   (both can die).
> 
> Yes. These have to be thought over again. I don't think a perfect solution 
> exists for all problems related to gdb kill/die followed by a reattach. We 
> should attempt a proper design describing different scenarios.

I don't see the problem to be delt with.  GDB reconnecting is not a
special case.

> > - All of the function pointer games (of which the weak symbols, but not
> >   all of them) are a part of.
> > - Issues w/ handling 'D' and 'k' packets cleaner (and I think there was
> >   a correctness fix in there, too, but it was a while ago).
> 
> Is this wrt kgdb_killed.., kgdb_might..., remove breakpoints?

This will be part of the patch I hope to post today:
http://ppc.bkbits.net:8080/linux-2.6-kgdb/patch@1.1500.2.19?nav=index.html|ChangeSet@-4w|cset@1.1500.2.19

> > - Don't ACK packets sitting on the line
> 
> More info please.

I see you've already taken this bit:
http://ppc.bkbits.net:8080/linux-2.6-kgdb/patch@1.1500.2.16?nav=index.html|ChangeSet@-4w|cset@1.1500.2.16

-- 
Tom Rini
http://gate.crashing.org/~trini/
