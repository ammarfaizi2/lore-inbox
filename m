Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265485AbTFWMWJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 08:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265488AbTFWMWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 08:22:09 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:45440 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265485AbTFWMWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 08:22:06 -0400
Date: Mon, 23 Jun 2003 13:44:14 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306231244.h5NCiE1Q000920@81-2-122-30.bradfords.org.uk>
To: felipe_alfaro@linuxmail.org, john@grabjohn.com
Subject: Re: O(1) scheduler & interactivity improvements
Cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Maybe I have different a different idea of what "interactive" should be.
> > 
> > [snip]
> > 
> > > moving windows around the screen do feel jerky and laggy at best
> > > when the machine is loaded. For a normal desktop usage, I prefer all
> > > my intensive tasks to start releasing more CPU cycles so moving a
> > > window around the desktop feels completely smooth
> > 
> > That's fine for a desktop box, but I wouldn't really want a heavily
> > loaded server to have database queries starved just because somebody
> > is scrolling through a log file, or moving windows about doing admin
> > work.
>
> I agree 100%... So this leads us to having two different set of
> scheduler policies: for desktop usage, and for server usage. For desktop
> usage, most of the apps need CPU bursts for a bried period of time. For
> server usage, we want a more steady scheduling plan.

Unfortunately, what is good for a desktop box is often counter
productive for a server :-(

> > If I was simply typing a letter, I wouldn't really care about
> > interactivity.  If I was using a heavily loaded server to do it,
> > (unlikely), I'd rather the wordprocessor was starved, and updated the
> > screen once per second, and gave more time to the server processes,
> > because I don't need the visual feedback to carry on typing.  Screen
> > updates are a waste of CPU in that instance - it might look nice, but
> > all it's doing is starving the CPU even more.
>
> So, opaque window moving is also a waste of time and we'd better stick
> to border-only (transparent) window moving ;-)

Well, no, opaque window moving is fine if the CPU isn't at 100%.  If
it is, I'd rather see choppy window movements than have a server
application starved of CPU.  That's just my preference, though.

> Nah! I also think it'a waste of time, but Joe-end-user won't think the
> same. He'll have a better feeling using more CPU to refresh the screen
> at a faster rate, even when that's a waste of CPU cycles.

I totally agree, but it's really tempting to say that that's the
distribution's responsibility to renice the X server, and let the
kernel default to doing the Right Thing, which is to starve screen
refreshes in favour of 'real' work.

Of course, people who are running X on a server for admin tasks could
always renice their X server to a lower priority to achieve a similar
effect.

> > I propose a radically different approach to scheduling, why not
> > favour processes that cause the fewest cache faults?  I.E. if a
> > process that gets more done in it's timeslice is more deserving of
> > it.  It might look ugly with screen updates being starved, but it
> > would probably get more work done :-).
>
> What would happen with poorly written programs? There are a lot of them
> that don't take advantage of memory locality, are not designed to fully
> utilize the cache, or use arrays in a way that produces too much
> page/cache faults.

Those programs are broken by design :-), (especially on NUMA
hardware).

I was just thinking that with cache-friendly processes being given a
bigger timeslice, we wouldn't be filling the cache with irrelevant
data so often.

John.
