Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271640AbRHULI7>; Tue, 21 Aug 2001 07:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271642AbRHULIt>; Tue, 21 Aug 2001 07:08:49 -0400
Received: from tree.custom-access.net ([217.24.128.14]:12563 "EHLO
	tree.custom-access.net") by vger.kernel.org with ESMTP
	id <S271640AbRHULIe>; Tue, 21 Aug 2001 07:08:34 -0400
Date: Tue, 21 Aug 2001 11:08:47 +0000 (UCT)
From: Ben Clifford <benc@hawaga.org.uk>
To: linux-kernel@vger.kernel.org
Subject: SCSI "Data overrun" under 2.4.3 and 2.4.2 which didn't occur under
 2.2.17
Message-ID: <Pine.LNX.4.10.10108211056180.27776-100000@tree.custom-access.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

I have an HP DAT drive using the aic7xxx driver.

I recently upgraded my RedHat distribution to RedHat 7.1 with kernel
2.4.2, and started getting the below problems. I have also tried RedHat's
2.4.3 and still get the same problem.  When I downgrade just the kernel
back to 2.2.17, it works again.

When I try to backup, either using my below attached backup script or just
by using "dd if=/dev/zero of=/dev/nst0", I get the following error:

(scsi0:0:3:0) Data overrun detected in Data-Out phase, tag 0;
Have seen Data Phase, length=30720, NumSGs=1
Raw SCSI command: 0x0a 01 00 00 3c 00
st0: error 27070000 (sugg. bt 0x20, driver bt 0x7, host bt 0x7)

At this point, tar dumps out, and the next tar starts up.

Using the above dd command line, sometimes I get 10 megs out, sometimes
just a few k before it fails.

I can use mt to move around the tape with no problem.

I also can't read in much from the tape drive before it fails (tar tzvf
will display about 10 filenames before giving up).

Here is my backup script:

====
>From root@edge.custom-access.net Tue Aug 21 11:07:44 2001
Date: Tue, 21 Aug 2001 11:07:13 GMT
From: root <root@edge.custom-access.net>
To: benc@tree.custom-access.net


logger -s -t backup Starting
logger -s -t backup Loading modules...

/sbin/modprobe aic7xxx
/sbin/modprobe st

logger -s -t backup Rewinding tape...

mt -f /dev/nst0 rewind

logger -s -t backup Backing up tree
ssh -1 -l root tree tar --create --gzip / --exclude=/proc --label=tree-full --numeric-owner > /dev/nst0

logger -s -t backup Backing up limb
ssh -1 -l root limb tar --create --gzip / --exclude=/proc --label=limb-full --numeric-owner > /dev/nst0

logger -s -t backup Backing up focal
ssh -1 -l root focal tar --create --gzip / --exclude=/proc --label=focal-full --numeric-owner > /dev/nst0

logger -s -t backup Backing up tally
ssh -1 -l root tally tar --create --gzip / --exclude=/proc --label=tally-full --numeric-owner > /dev/nst0

logger -s -t backup Backing up edge
ssh -1 -l root edge tar --create --gzip / --exclude=/proc --label=edge-full --numeric-owner > /dev/nst0

logger -s -t backup Backing up squeeze
ssh -1 -l root stock tar --create --gzip / --exclude=/proc --label=squeeze-full --numeric-owner > /dev/nst0

logger -s -t backup Finished backing up
logger -s -t backup Finished backing up
logger -s -t backup Ejecting...

eject /dev/st0

logger -s -t backup All done

====

If anyone wants any more info, please ask.

Thanks
Ben
--
Ben Clifford
http://www.hawaga.org.uk/ben/


