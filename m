Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270971AbTGVRwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 13:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270973AbTGVRwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 13:52:37 -0400
Received: from ip-64-32-161-115.dsl.atl.megapath.net ([64.32.161.115]:56705
	"EHLO bounce.snarkhunter.com") by vger.kernel.org with ESMTP
	id S270971AbTGVRwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 13:52:32 -0400
Date: Tue, 22 Jul 2003 14:07:32 -0400
To: Edward King <edk@cendatsys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
Message-ID: <20030722180732.GA24179@bounce.snarkhunter.com>
References: <3F1C54A8.5020404@snarkhunter.com> <3F1D4DBA.4010700@cendatsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1D4DBA.4010700@cendatsys.com>
User-Agent: Mutt/1.3.28i
X-Request-PGP: http://www.snarkhunter.com/~jvm/gpgpubkey.asc
From: "John V. Martinez" <jvm@snarkhunter.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ed,


Thanks for the quick reply. Sadly, I think I have a different
(possibly related?) problem, as I am not currently using devfs.

(clarification: my kernel does have devfs support compiled in, but it
is not mounted on my system -- you don't think just having it compiled
in makes any difference, do you? I can't see why it would, but
stranger things have happened -- to me, at least :^) -- I'm currently
running a Debian 3.0 system with their 'Pentium Classic' 2.4.18 kernel
(2.4.18-586tsc) flavor, but the problem was still present when I tried
switching to the 2.4.20 kernel currently in testing. I guess I'll try
building 2.4.21 when I get a chance - trouble is, it's (supposed to
be) a 24x7 server, so I can't afford too much downtime for these
experiments. (Which is why I was searching the web, hoping to find a
definitive checkin comment somewhere that said "John's problem with
two promise controllers locking up his system when he rebuild his RAID
array is fixed now in 2.4.21-cheesewhiz" but no such luck.

:^)

I guess if all else fails, I'll use the setup you have: 4-drive RAID
on one controller. My concern was not so much the performance hit of
using both master&slave, but the possibility of a bad drive hosing the
connection to both drives on that controller, thus taking down 1/2 of my
RAID5 array at once. 

Do you happen to know if anybody makes a (Linux-friendly) IDE
controller card with more than two channels? All the cards I have
found which will connect more than 4 drives are hardware RAID
controllers, (or faux-hardware raid, like Promise.)

Anyway, thanks again for your time,

-(-- John V. Martinez



On Tue, Jul 22, 2003 at 09:44:10AM -0500, Edward King wrote:
> John:
> 
> Quick fix to the problem is remove devfs -- it appears that the devfs 
> code doesn't like to have the raid layered on top of it, and it loses 
> interrupts.
> 
> I've got two systems now running 4 200GB WD's connected to a single 
> promise card (ATA100/TX2)  with the booting drive (a 5th drive) attached 
> to the motherboard.  The raid works flawlessly and is fast -- I imagine 
> there'd be a speedup by keeping all the drives as master (with 2 pdc's) 
> and it would be more robust, but those aren't issues.
> 
> Hope this helps -- I'll post this to the mailing list to help anyone 
> else with this problem.
> 
> - Ed
> 
> John V. Martinez wrote:
> 
> >Hi Ed,
> >
> >I found a linux-kernel post you made back in March about problems 
> >running two Promise IDE controllers in the same system. I have a 
> >similar configuration, (and a similar problem,) and I was wondering if 
> >you ever found a solution, or if one of the more recent 2.4.21-foo 
> >kernels solved it for you.
> >
> >(I have two Promise ATA-100/TX2 (20268 chip) controllers, and I have 
> >one 200GB WD drive as a single master on each channel. The two 
> >controllers are sharing interrupts with othwer cards, but not with 
> >each other. I can access each disk individually, but when I tried to 
> >make them work hard: mkraid a RAID5 array using these four drives, the 
> >system freezes HARD until I hit the big red button. [Then it reboots, 
> >spots the raid superblock, tries to rebuild my RAID5 array, and 
> >freezes again, until I get a clue and unplug the drives in question 
> >while powered down :^))
> >
> >Anyway, if you have any more insight into this problem than you did in 
> >March, and care to share, I'd be much obliged.
> >
> >Cheers,
> >
> >-(-- John
> 
> 
