Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284020AbRLMOrn>; Thu, 13 Dec 2001 09:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284068AbRLMOrd>; Thu, 13 Dec 2001 09:47:33 -0500
Received: from mustard.heime.net ([194.234.65.222]:53982 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284020AbRLMOrY>; Thu, 13 Dec 2001 09:47:24 -0500
Date: Thu, 13 Dec 2001 15:47:07 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>, Tux mailing list <tux-list@redhat.com>
Subject: [BUG?] RAID sub system / tux
Message-ID: <Pine.LNX.4.30.0112131530310.25884-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

After testing this for a while, I'm quite sure there's some kind of bug
that locks up I/O under heavy traffic.

Hardware configuration:

1xAthlon 1133
1GB RAM
1 20G boot disk
2 120G ide drives on a promise ata133 (20269) controller

Kernel: Vanilla 2.4.16 + tux-D0

/etc/raidtab:

raiddev /dev/md0
	raid-level              0
	nr-raid-disks           2
	persistent-superblock   0
	chunk-size              4096

	device                  /dev/hde
	raid-disk               0
	device                  /dev/hdg
	raid-disk               1

IDE readahead setting:

echo file_readahead:1024 > /proc/ide/hd[eg]/settings
(I've tried down to 256 with no change.)

file system: independant. I've tried with xfs and ext2 and get the same
result.

Testing:
I make some 100 files, each ~1GB, and start ~100 wget processes to
retrieve data from http://localhost/file-nnnn. Each process is retrieving
a separate file, as to simulate the app. Usually, this works fine in the
beginning, but after a while it all locks up, and the [TUX worker]
(mother) process stops giving me any data, and starts using 100% system
time. If I restart tux, I can do some data retrieval for some time, but
then it locks up again. It's easily reproducable to just start, say, 50
wget processes, killall wget, and then restart the 50 wget processes.

Thanks for all help

regards

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


