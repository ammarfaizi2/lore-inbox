Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264532AbTDYAgy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTDYAgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 20:36:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14986 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264532AbTDYAgv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 20:36:51 -0400
Date: Thu, 24 Apr 2003 20:52:59 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stewart Smith <stewartsmith@mac.com>
cc: John Bradford <john@grabjohn.com>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
In-Reply-To: <E41731BA-76B1-11D7-BE62-00039346F142@mac.com>
Message-ID: <Pine.LNX.4.53.0304242027350.3180@chaos>
References: <E41731BA-76B1-11D7-BE62-00039346F142@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Apr 2003, Stewart Smith wrote:

> On Sunday, April 20, 2003, at 02:22  AM, John Bradford wrote:
>
> >> I wonder whether it would be a good idea to give the linux-fs
> >> (namely my preferred reiser and ext2 :-) some fault-tolerance.
> >
> > Fault tollerance should be done at a lower level than the filesystem.
>
> I would (partly) disagree. On the FS level, you would still have to
> deal with the data having gone away (or become corrupted). Simply
> passing a (known) corrupted block to a FS isn't going to do anything
> useful. Having the FS know that "this data is known crap" could tell it
> to
> a) go look at a backup structure (e.g. one of the many superblock
> copies)
> b) guess (e.g. in disk allocation bitmap, just think of them all as
> used)
> c) fail with error (e.g. "cannot read directory due to a physical
> problem with the disk"
> d) try to reconstruct the data (e.g. search around the disk for magic
> numbers)
>
> <snip>
> > The filesystem doesn't know or care what device it is stored on, and
> > therefore shouldn't try to predict likely failiures.
>
> but it should be tolerant of them and able to recover to some extent.
> Generally, the first sign that a disk is dying (to an end user) is when
> really-weird-stuff(tm) starts happening. A nice error message from the
> file system when they try to go into the directory (or whatever) would
> be a lot nicer.
>
> You could generalize the failure down to an extents type record (i.e.
> offset and length) which would suit 99.9% of cases (i think :). In the
> case of post-detection of error, the extra effort is probably worth it.
>
> these kinda issues are coming up in my honors thesis too, so there
> might even be the (dreaded) code and discussion sometime near the end
> of the year :)
> ------------------------------
> Stewart Smith
> stewartsmith@mac.com
> Ph: +61 4 3884 4332
> ICQ: 6734154

With most devices used for file-systems most all writes succeed.
So the file-system doesn't even know that there was some error
until it tries to read the data, probably next week. Through the
ages, attempts to fix this have destroyed any real I/O capability.
You need to re-read the data after you've written it. You can't
read it back right away because it will still be in the device's
sector buffer and will not be read from the physical media. That
means you need to keep copies of data buffers in memory and re-read
and compare a long time after other data was written. The makes
things VAXen-like, with I/O measured in bytes/fortnight. Once you
find a bad "block", you can make these owned by a file...

	DUA0:[000000]BADBLOCK.SYS

... hehehe  so they never get used again. Periodically, you can
look at the size of the file and, if it's getting large, you know
that you are going to have to low-level format the drive and start
all over gain ;^)

On Unix/Linux machines, perhaps 90 percent of the file data never
gets written to the physical media. It stays in RAM until it's
deleted. Even if you made new kinds of disk-drives that, internally
read-after-write, writing all that data to a drive, on the off-chance
of some error in the 10 percent that stays, is going to take your
I/O bandwidth to a snails pace.

These Unix file-systems are really RAM disks that overflow to
disk drives. You can run for many days with a disk-drive off-line
and not even know it. Been there, done that.

If you have disk-drive problems, leave your machine on continuously
with the monitor off when you are not using it. The disk drives will
then fail only after a power-failure (really). Keep some new ones
handy and keep backups. The drives get beat-up when they start-up and
run-down. If you can get them started, they will run for several
continuous years. At the company I work for, we have about 1,000
employees that use PCs. At one time we had a repair department with
10 or so employees doing noting but repairing PCs. Once I convinced
everybody to keep their machines on <forever>. The repair department
had so little work, it closed. But... if we ever have a power-failure,
it takes several weeks to get all those PCs repaired.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

