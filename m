Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHCat>; Wed, 7 Feb 2001 21:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbRBHCaj>; Wed, 7 Feb 2001 21:30:39 -0500
Received: from [216.29.39.226] ([216.29.39.226]:41477 "HELO
	mail.acetechnologies.net") by vger.kernel.org with SMTP
	id <S129032AbRBHCaf>; Wed, 7 Feb 2001 21:30:35 -0500
To: Chris Mason <mason@suse.com>
Subject: Re: reiserfs - problems mounting after power outage
Message-ID: <981599556.3a8205443bbe9@ns1.acetechnologies.net>
Date: Wed, 07 Feb 2001 21:32:36 -0500 (EST)
From: Jeff McWilliams <Jeff.McWilliams@acetechnologies.net>
Cc: Jeff.McWilliams@acetechnologies.net, linux-kernel@vger.kernel.org
In-Reply-To: <816580000.981590200@tiny>
In-Reply-To: <816580000.981590200@tiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 24.22.75.92
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,

Thanks for the reply.

> Which reiserfs version is this?  Upgrading to the reiserfs included in
> 2.4.1 would be a good plan, there have been a few bug fixes since test9
> times (none specfically related to this).
>

/var/log/messages shows ReiserFS reporting version 3.6.18.

> If this raid controller has writeback cache, make sure you either have a
> battery backup for the cache, or have writeback turned off.
>

It has no battery backup for the cache.  Writeback cacheing is disabled.

> How hung is it?  Does the whole system stop, or does this mount just
> block forever?
>

When the mount hangs the rest of the system is responsive.  I can to go other
virtual consoles and do other things and it works fine. If I attempt to shut
down the system (shutdown -h now) the kernel blocks trying to unmount local
filesystems just before powering down.


The reiserfs tools I used are from Debian's reiserfsprogs_3.0.20001019-3.deb

> These programs also hang?  Does reiserfsck (which version BTW) give any
> output at all?
>
>

If I do a reiserfsck /dev/sda7 I get the following:

ns2:/usr/share/doc/reiserfsprogs# reiserfsck --rebuild-tree /dev/sda7

<-------------reiserfsck, 2000------------->
reiserfsprogs 3.x

This is an experimental version of reiserfsck, MAKE A BACKUP FIRST!
Don't run this program unless something is broken.  You may want
to backup first.  Some types of random FS damage can be recovered
from by this program, which basically throws away the internal nodes
of the tree and then reconstructs them.  This program is for use only
by the desperate, and is of only beta quality.  Email
reiserfs@devlinux.com with bug reports.
Will replay just like mounting would
Do you want to run this program?[N/Yes] (note need to type Yes):Yes
Replaying log..
Looking for the oldest transaction to start with  ok
1 valid trans found. Will replay from 50 to 50
Replaying transaction..   0 left..


How long should I wait for this to run?  It's an 8 gig partition with perhaps
a few megs of data on it.  I've let this run for 20 minutes or so (the system is
a Pentium 200MMX with 64M of RAM, console mode only, no XFree86 stuff), and
it just runs, consuming 97% CPU according to top. /proc/loadavg reports
1.00 0.97 0.71 2/29 378

I'm interested in building 2.4.1 but I haven't seen a released one yet and
haven't done an Alan Cox patch series kernel build before.  Maybe it's time to
try.  :-)

That might have to wait until this weekend though.  I'm a developer by day,
and a sys admin by night or on the weekends.  I can also grab and build the
latest toolset instead of using the Debian pre-packaged ones if you think that
this will help.

Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
