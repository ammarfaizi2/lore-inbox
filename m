Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264022AbUDTWNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbUDTWNK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbUDTWNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:13:08 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:15037 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S264314AbUDTUAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 16:00:46 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: The missing RAID level
Date: Tue, 20 Apr 2004 19:50:07 GMT
Message-ID: <045P8FJ12@server5.heliogroup.fr>
X-Mailer: Pliant 91
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assuming that I want to do long term archiving (many many gigabytes of datas,
but tiny load) on disks, the cheapest and easiest solution nowdays seems to
connect large 300 GB IDE disks through USB 2 to a comodity PC.

Now the problem is how to best recover from some disks failure ?

For the production storage, I use software RAID 5 on internal disks, but
for huge external ones, it might no more be a good idea, because of two
reasons:
. having several disks failure is more likely
. in case of a catastrophy, I would like to be abble to recover at least some
  of the datas, so no RAID at all is better that RAID 5 since I have DVD
  backups and what I want to optimise is operator time

So, one very interesting possibility would be to have an extra RAID level that
would do the following:
assuming that you connect 5+1 partitions, then you get 5 md partitions, not a
single one, with the following properties:
. any read to mdX goes straight forward to reading the underlying partition.
. any write goes staight forward to writting the underlying partition, but also
  updates the parity on the extra partition.

So, at the expense of slow write capabilities, which is not a problem for long
term archiving, I get a system with very interesting properties not covered by
existing Linux software RAID levels:
. in case of one disk failure, I can plug a new one, then rebuild just as with
  classical RAID
. in case of more disk failures, I only loose part of the archives (so spend
  less operator time for recovery from DVD).
. all partitions can be read just through ignoring the RAID details, so it is
  possible to unplug any of disks and connect it sowehere else with no extra
  constrains
. adding or removing disks from the raidset is trivial: just rebuild the parity
  partition

On the 'use what's available instead of requesting new features' side, I'm also
interested with feedback from users using large (8 to 16 SATA disks) external
cheap (anything that raises the price for 8 disk from 8 x 350 euro to more than
16 x 360 euro is no solution since clustering is then the way to go) towers that
would make RAID 5 a resonable solution, and how they connect to the Linux kernel
(each disk seen individualy, RAID handled by the contoler, need for a driver
outside the stock kernel, etc)

Regards,
Hubert Tonneau

