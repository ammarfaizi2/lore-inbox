Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319209AbSH2OBp>; Thu, 29 Aug 2002 10:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319210AbSH2OBp>; Thu, 29 Aug 2002 10:01:45 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:44046 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S319209AbSH2OBo>; Thu, 29 Aug 2002 10:01:44 -0400
Date: Thu, 29 Aug 2002 09:06:07 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.4.20-pre4-ac1 trashed my system
Message-ID: <Pine.LNX.4.44.0208290900130.10104-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've been a Linux user since 1994.  I have always built my own
kernels.  I have never trashed a system, until 2 nights ago, when I
ran 2.4.20-pre4-ac1...

Unfortunately what I have is very short on detail, because most of the
"evidence burned in the fire" when the disk's file systems were
destroyed.  I do have .deb's of the suspect kernel (I'm a Debian user)
and I think I can recover the kernel .config file from that.  Here's
what else I can supply:

  o System: Athlon XP 1700+ CPU, built on an Asus A7V266-E mainboard.

  o Ram: 512MB

  o Disk: 160GB Maxtor IDE (note: >137GB)

  o Controller: Promise 20265 rev 02 (as reported by lspci)

  o Note: The Promise controller is not the primary controller on the
    board.  This is a second controller equipped on the board.  I
    point this out because the 160GB disk was connected to this
    Promise controller, not the motherboard's default controller.

  o I was using ext3 everywhere at the time things exploded.

  o The previous kernel before 2.4.20-pre4-ac1 that I ran was
    2.4.19-ac4, which ran OK on this hardware combination.

The first symptom I observed was a directory that listed incorrectly
as a file.  It wasn't on my root file system so I unmounted it and
attempted an fsck.  At this point I wasn't suspecting the new kernel
(I should have), otherwise I should have backed off to 2.4.19-ac4
first.  But I didn't.  This file system was about 120GB, most of the
disk; I hadn't noticed any trouble with other file systems yet.

The fsck went through about 60% of the file system cleanly and then
just went nuts reporting / fixing errors.  Then fsck gave up,
complaining about something wrong with the journal file.  I
reattempted it (second mistake); this time it died right away with the
same error.  Then I noticed other processes hanging on the system.  I
was unable to shut down so I power-cycled.  The reboot paniced after
failing to find the init executable (though it did manage to mount
root).

Going further down this trail of damage, I then tried to boot a rescue
partition (about 200MB) previously set up on the same disk.  This was
a partition that was _not_ _mounted_ when 2.4.20-pre4-ac1 was running.
This boot attempt got as far as trying to start things in /etc/init.d
before croaking with a pile of SEGVs.  I managed to fsck the rescue
partition but the damage had been done and that partition never worked
right again (i.e. corrupted files).

As far as I can tell now, the entire disk has been scrambled (except
for the partition table, which seems to have survived unscathed).

Also FWIW I did check kernel log message output during this melee and
saw nothing unusual, specifically no errors from the IDE subsystem.

The only things I see about this that might be noteworthy is:

 1. I was using the Promise controller for my system disk, not the
    board's primary controller.

 2. I was using a 160GB drive, which exceeds the 137GB limit of ATA-5
    (?).  Notably, the initial fsck got ugly about 60% the way
    through, which I _think_ would have put that right near the 137GB
    boundary of the disk, given where that particular partition was
    set up.

Is there a possible problem here with huge disk support using the
Promise 20265 controller in 2.4.20-pre4-ac1?

Unfortunately I need that system back so I'm rebuilding it now (and
moving the disk off of the Promise controller out of paranoia).
Sorry...

Is this a known problem with 2.4.20-pre4-ac1?  I did note Alan's
statement about using the -ac series for further IDE development and
wonder if perhaps I got caught in the crosshairs.

  -Mike


                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |

