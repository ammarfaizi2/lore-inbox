Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbUBXXvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbUBXXvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:51:21 -0500
Received: from gprs144-166.eurotel.cz ([160.218.144.166]:52865 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262530AbUBXXt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:49:58 -0500
Date: Wed, 25 Feb 2004 00:49:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Split kgdb into "lite" and "normal" parts
Message-ID: <20040224234940.GD9209@elf.ucw.cz>
References: <20040218225010.GH321@elf.ucw.cz> <200402191322.52499.amitkale@emsyssoft.com> <20040224213908.GD1052@smtp.west.cox.net> <20040224221541.GA9145@elf.ucw.cz> <20040224232137.GJ1052@smtp.west.cox.net> <20040224232703.GC9209@elf.ucw.cz> <20040224233809.GK1052@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224233809.GK1052@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > > Tested (core-lite.patch + i386-lite.patch + 8250.patch) combination.
> > > > > > Looks good.
> > > > > > 
> > > > > > Let's first check this in and then do more cleanups.
> > > > > > Tom, does it sound ok?
> > > > > 
> > > > > This sounds fine to me.  Pavel, I'm guessing you did this with quilt,
> > > > > could you provide some pointers on how to replicate this in the future?
> > > > 
> > > > Unfortunately, I done it by hand :-(. But if -lite parts are not
> > > > merged, soon, I'll be forced to start using quilt. Doing stuff by hand
> > > > is quite painfull...
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
> - Wierdities with kgdb_killed_or_detached / kgdb_might_be_resumed
>   (both can die).
> - Issues w/ handling 'D' and 'k' packets cleaner (and I think there was
>   a correctness fix in there, too, but it was a while ago).
> - Don't ACK packets sitting on the line

Okay, these look important but probably only touch core-lite, right?
So it should be easy to merge. Can you generate diff?

I'll try to import kgdb into quilt to make working with it
easier. [But don't expect miracles.]

> - All of the function pointer games (of which the weak symbols, but not
>   all of them) are a part of.
> - kgdb_schedule/process_breakpoint, required for kgdboe, harmless to use
>   on serial.


> There's still a lot of stuff I checked into linux-2.6-kgdb that's
> non-trivially important
> (http://ppc.bkbits.net:8080/linux-2.6-kgdb/ChangeSet@-4w?nav=index.html)

Hmm, I'm not allowed to use bt :-(.

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
