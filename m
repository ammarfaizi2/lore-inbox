Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUBYHTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 02:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbUBYHTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 02:19:45 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:36315 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262648AbUBYHTm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 02:19:42 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: Split kgdb into "lite" and "normal" parts
Date: Wed, 25 Feb 2004 12:49:28 +0530
User-Agent: KMail/1.5
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <20040218225010.GH321@elf.ucw.cz> <20040224232703.GC9209@elf.ucw.cz> <20040224233809.GK1052@smtp.west.cox.net>
In-Reply-To: <20040224233809.GK1052@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402251249.28519.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 Feb 2004 5:08 am, Tom Rini wrote:
> On Wed, Feb 25, 2004 at 12:27:03AM +0100, Pavel Machek wrote:
> > Hi!
> >
> > > > > > Tested (core-lite.patch + i386-lite.patch + 8250.patch)
> > > > > > combination. Looks good.
> > > > > >
> > > > > > Let's first check this in and then do more cleanups.
> > > > > > Tom, does it sound ok?
> > > > >
> > > > > This sounds fine to me.  Pavel, I'm guessing you did this with
> > > > > quilt, could you provide some pointers on how to replicate this in
> > > > > the future?
> > > >
> > > > Unfortunately, I done it by hand :-(. But if -lite parts are not
> > > > merged, soon, I'll be forced to start using quilt. Doing stuff by
> > > > hand is quite painfull...
> > >
> > > There's still a whole bunch of bogons in the -lite patch still, so I
> > > don't think it should be merged yet.
> >
> > Well, it seems to contains a *lot* less bogons than what currently is
> > in -mm series.
> >
> > What big problems do you see? It does not yet use weak symbols, but I
> > do not think that's a serious problem. What else?
>
> The first two big ones are:
> - Doesn't like gdb 6.0 (You cannot assume the first packet is Hc...)

Can you tell me more about this?

> - Wierdities with kgdb_killed_or_detached / kgdb_might_be_resumed
>   (both can die).

Yes. These have to be thought over again. I don't think a perfect solution 
exists for all problems related to gdb kill/die followed by a reattach. We 
should attempt a proper design describing different scenarios.

> - All of the function pointer games (of which the weak symbols, but not
>   all of them) are a part of.
> - Issues w/ handling 'D' and 'k' packets cleaner (and I think there was
>   a correctness fix in there, too, but it was a while ago).

Is this wrt kgdb_killed.., kgdb_might..., remove breakpoints?

> - Don't ACK packets sitting on the line

More info please.

-Amit

> - kgdb_schedule/process_breakpoint, required for kgdboe, harmless to use
>   on serial.
>
> There's still a lot of stuff I checked into linux-2.6-kgdb that's
> non-trivially important
> (http://ppc.bkbits.net:8080/linux-2.6-kgdb/ChangeSet@-4w?nav=index.html)

