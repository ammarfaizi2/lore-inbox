Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317457AbSINS2e>; Sat, 14 Sep 2002 14:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSINS2e>; Sat, 14 Sep 2002 14:28:34 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:46041 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317457AbSINS2c>; Sat, 14 Sep 2002 14:28:32 -0400
Date: Sat, 14 Sep 2002 20:33:07 +0200 (CEST)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.s-tec.de
To: linux-kernel@vger.kernel.org
Subject: Possible Bug with MD multipath and raid1 on top
Message-ID: <Pine.LNX.4.44.0209142014080.21833-100000@omega.s-tec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.1; AVE: 6.15.0.1; VDF: 6.15.0.7
	 at email has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found a very strange effect when using a raid1 on top of multipathing
with Kernel 2.4.18 (Suse-version of it) with a 2-Port qlogic HBA
connecting two arrays.

The raidtab used to set this up is:

raiddev                 /dev/md0
raid-level              multipath
nr-raid-disks           1
nr-spare-disks          1
chunk-size              32

device                  /dev/sda1
raid-disk               0

device                  /dev/sdc1
spare-disk              1

raiddev                 /dev/md1
raid-level              multipath
nr-raid-disks           1
nr-spare-disks          1
chunk-size              32

device                  /dev/sdb1
raid-disk               0

device                  /dev/sdd1
spare-disk              1

raiddev                 /dev/md2
raid-level              1
nr-raid-disks           2
nr-spare-disks          0
chunk-size              32

device                  /dev/md0
raid-disk               0

device                  /dev/md1
raid-disk               1


As you see, one port from the hba "sees" sda and sdb, the second port
sdc and sdd.
When I now pull out one of the cables two disks are missing and the
multipath driver correctly uses the second path to the disks and
continues to work. After plugging out the second cable all drives
are marked as failed (mdstat), but the raid1 (md2) is still reported
as functional with one device (md0) missing.
(Sorry do not have the output at hand but md2 was reported [_U], while
sda-sdd were marked [F]).

All Processes using the raid1-device get stuck and this situation
does not recover. Even some simple process testing the disk-access
got stuck  (I think ps showed state   L<D).

Even if I'm quite sure that this is a bug, how should I test disk access
without ending in "uninterruptible sleep" ?

Thanks

Oktay Akbal

