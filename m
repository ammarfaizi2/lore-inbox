Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266984AbSLWVxW>; Mon, 23 Dec 2002 16:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbSLWVxW>; Mon, 23 Dec 2002 16:53:22 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:13529 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S266984AbSLWVxT>;
	Mon, 23 Dec 2002 16:53:19 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh problem?)
References: <002f01c2a868$0ab3b5d0$3b41d03f@joe>
From: Krzysztof Halasa <khc@pm.waw.pl>
In-Reply-To: <002f01c2a868$0ab3b5d0$3b41d03f@joe>
Date: 23 Dec 2002 18:48:50 +0100
Message-ID: <m3lm2giq2l.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like at least partially off-topic, but...

"Joseph D. Wagner" <wagnerjd@prodigy.net> writes:

> Lumping everything into one partition makes it impossible to protect against
> the SUID/GUID security vulnerability (security),

Why not? chmod ug-s /usr/bin/file... works as expected (?)
You worry about users creating suid files in /home? If they can do that,
your system is already broken (into).

> and requires all reads and
> writes to be funneled through one partition (speed).

But that's higher speed, statistically. Especially if it have to run
between your /tmp at the start of disk and /home at the end otherwise.
Not that I recommend putting /home on / fs.

> At an absolute MINIMUM, your partitions should be divided into:
> /boot	032 MB

Only needed if your BIOS has problems booting from /.

> /tmp	512 MB

Some of my machines wouldn't be able to work with that small /tmp.

> swap	1.5 - 3.0 times the amount of RAM,
> 	not to exceed a 2 GB per swap partition limit

Why? I thought you need that much swap as you need - and no more.
One of my machines doesn't even have any swap at all.

> /root	  5 GB

For /root/.ssh etc? You must be using many authorized_keys :-)

> /var	 10 GB

I always preferred to have separate /var/spool/{mqueue,postfix/etc} and
/var/spool/lp (and so on). The size should just be appropriate.

> /usr	20% of what is leftover

Hmm... Why not check how much do that need?

> /home	50% of what is leftover,
> 	or at least 32 MB per user

Why not check how much do users need?

> /	30% of what is leftover

And that's for?

Basically, you need as much space on particular fs as much you need.
No more, no less.

If (in particular case) I have a disk bigger than I need (they no longer
sell <= 20 GB IDE), the unused space might well be just unused space.

> The above numbers are my recommendations for your 1.1 TB Raid Array ONLY.
> Please don't flame me about how those numbers aren't right for everybody's
> systems.

I'm not trying to. However, they might be right for nearly no system
(except yours, possibly).

> > The Board is an MSI 6501 (K7D Master) with 1GB RAM
> > but only one processor.
> 
> Upgrade to 4 GB of RAM (if possible) and add a second processor (if
> possible).

Why do you think adding extra RAM and CPU can increase disk performance?
Cache, yes, but we don't even know if the problem is there.
CPU with RAID5, yes, but not with a RAID controller (with software RAID5
only).

Distributing load over multiple disks/controllers may help better.

Writing 1 GB of data might well take 14 seconds and more, but should
not take 4 minutes in a idle and correctly configured system.

I don't know the controller in question, but chances are it's just
to slow and has no enough bandwidth. Or _it_ might require more RAM.

Switching from RAID5 to RAID1 might help as well, but it's quite expensive.

> Further, SCSI really works better with two or more processors.  SCSI is
> designed to take advantage of multiple processors.  If you're not running
> multiple processors, you might as well be running IDE, IMHO.

Not true. SCSI works best with just a multi-request (i.e. multiprocess)
system. The CPU is way faster than any disk, and it can switch processes
fast while they are waiting for disk I/O.

ps xa|grep D
-- 
Krzysztof Halasa
Network Administrator
