Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129280AbRBSXH7>; Mon, 19 Feb 2001 18:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129285AbRBSXHu>; Mon, 19 Feb 2001 18:07:50 -0500
Received: from www.pcxperience.com ([199.217.242.242]:9715 "EHLO
	gannon.zelda.pcxperience.com") by vger.kernel.org with ESMTP
	id <S129280AbRBSXHh>; Mon, 19 Feb 2001 18:07:37 -0500
Message-ID: <3A91A6E7.1CB805C1@pcxperience.com>
Date: Mon, 19 Feb 2001 17:06:15 -0600
From: "James A. Pattie" <james@pcxperience.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Reiserfs, 3 Raid1 arrays, 2.4.1 machine locks up
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not subscribed to the kernel mailing list, so please cc any replies
to me.

I'm building a firewall on a P133 with 48 MB of memory using RH 7.0,
latest updates, etc. and kernel 2.4.1.
I've built a customized install of RH (~200MB)  which I untar onto the
system after building my raid arrays, etc. via a Rescue CD which I
created using Timo's Rescue CD project.  The booting kernel is
2.4.1-ac10, no networking, raid compiled in but raid1 as a module,
reiserfs as a module, ext2 and iso-9660 compiled in, using sg support
for cd-roms.  I had to strip the kernel down so it would fit on a floppy
as the system does not support booting off of CD-ROM.

After booting and getting my initial file system in memory (20+ MB
ramdisk), I created a partition for swap, format and then swapon so I
don't run out of memory.  At this point I usually have 3-5 MB free
memory, 128 MB swap.

I partitioned the 2 drives (on 1st and 2nd controller, both 1.3 GB each)
into 4 total partitions.  1st is swap and then the next 3, 1 primary, 2
extended are for raid 1 arrays.  I've given 20 MB to /boot (md0), 650MB
to / (md1) and the rest (400+MB) to /var (md2).  I format md0 as ext2
and md1 and md2 as reiserfs.  When I go to untar the image on the cd to
/mnt/slash (which has md1 mounted on it), the system extracts about 30MB
of data and then just stops responding.  No kernel output, etc.  I can
change to the other virtual consoles, but no other keyboard input is
accepted.  After resetting the machine, the raid arrays rebuild ok, and
reiserfs gives me no problems other than it usually replays 2 or 3
transactions.  If I tell tar to pickup on the last directory I saw
extracted, it gets about another 30MB of data and stops again.  I've
waited for the raid syncing to be finished or just started after the
arrays are available and it doesn't matter.

I first tried with 2.4.1 stock and then went to 2.4.1-ac10 (the latest
at the time I was playing with this) and it did exactly the same thing.
If I format md1 and md2 with ext2, then everything works fine.  I was
initially compiling 386 only support in and have tried with 586 support
(no difference).  I've tried both r5 and tea hashes with reiserfs.

One thing I did notice was that the syncing of the raid 1 arrays went in
sequence, md0, md1, md2 instead of in parrallel.  I assume it is because
the machine just doesn't have the horsepower, etc. or is it that I have
multiple raid arrays on the same drives?

This isn't a life or death issue at the moment, but I would like to be
able to use reiserfs in this scenario in the future.

I have tested the same rescue CD boot image on a K62, 450Mhz, 128 MB
system.  No raid, just one reiserfs partition and it untarred without
any issues.  I'm thinking this is something specific to older, lower
memory machines?

--
James A. Pattie
james@pcxperience.com

Linux  --  SysAdmin / Programmer
PC & Web Xperience, Inc.
http://www.pcxperience.com/



