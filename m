Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbUBXXiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbUBXXiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:38:14 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:50337 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S262534AbUBXXiK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:38:10 -0500
Date: Tue, 24 Feb 2004 16:38:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Split kgdb into "lite" and "normal" parts
Message-ID: <20040224233809.GK1052@smtp.west.cox.net>
References: <20040218225010.GH321@elf.ucw.cz> <200402191322.52499.amitkale@emsyssoft.com> <20040224213908.GD1052@smtp.west.cox.net> <20040224221541.GA9145@elf.ucw.cz> <20040224232137.GJ1052@smtp.west.cox.net> <20040224232703.GC9209@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224232703.GC9209@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 12:27:03AM +0100, Pavel Machek wrote:

> Hi!
> 
> > > > > Tested (core-lite.patch + i386-lite.patch + 8250.patch) combination.
> > > > > Looks good.
> > > > > 
> > > > > Let's first check this in and then do more cleanups.
> > > > > Tom, does it sound ok?
> > > > 
> > > > This sounds fine to me.  Pavel, I'm guessing you did this with quilt,
> > > > could you provide some pointers on how to replicate this in the future?
> > > 
> > > Unfortunately, I done it by hand :-(. But if -lite parts are not
> > > merged, soon, I'll be forced to start using quilt. Doing stuff by hand
> > > is quite painfull...
> > 
> > There's still a whole bunch of bogons in the -lite patch still, so I
> > don't think it should be merged yet.
> 
> Well, it seems to contains a *lot* less bogons than what currently is
> in -mm series.
> 
> What big problems do you see? It does not yet use weak symbols, but I
> do not think that's a serious problem. What else?

The first two big ones are:
- Doesn't like gdb 6.0 (You cannot assume the first packet is Hc...)
- Wierdities with kgdb_killed_or_detached / kgdb_might_be_resumed
  (both can die).
- All of the function pointer games (of which the weak symbols, but not
  all of them) are a part of.
- Issues w/ handling 'D' and 'k' packets cleaner (and I think there was
  a correctness fix in there, too, but it was a while ago).
- Don't ACK packets sitting on the line
- kgdb_schedule/process_breakpoint, required for kgdboe, harmless to use
  on serial.

There's still a lot of stuff I checked into linux-2.6-kgdb that's
non-trivially important
(http://ppc.bkbits.net:8080/linux-2.6-kgdb/ChangeSet@-4w?nav=index.html)

-- 
Tom Rini
http://gate.crashing.org/~trini/
