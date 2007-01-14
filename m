Return-Path: <linux-kernel-owner+w=401wt.eu-S1750967AbXANEMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbXANEMS (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 23:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbXANEMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 23:12:18 -0500
Received: from front1.netvisao.pt ([213.228.128.56]:50481 "HELO
	front1.netvisao.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750967AbXANEMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 23:12:17 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Jan 2007 23:12:16 EST
From: Ricardo Correia <rcorreia@wizy.org>
To: linux-kernel@vger.kernel.org
Subject: How to flush the disk write cache from userspace
Date: Sun, 14 Jan 2007 04:05:33 +0000
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701140405.33748.rcorreia@wizy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, (please CC: to my email address, I'm not subscribed)

Quick question: how can I flush the disk write cache from userspace?

Long question:

I'm porting the Solaris ZFS filesystem to the FUSE/Linux filesystem framework.
This is a copy-on-write, transactional filesystem and so it needs to ensure 
correct ordering of writes when transactions are written to disk.

At the moment, when transactions end, I'm using a fsync() on the block device 
followed by a ioctl(BLKFLSBUF).

This is because, according to the fsync manpage, even after fsync() returns, 
data might still be in the disk write cache, so fsync by itself doesn't 
guarantee data safety on power failure.

I was looking for something like the Solaris ioctl(DKIOCFLUSHWRITECACHE), 
which does exactly what I need.

The most similar thing I could find was ioctl(BLKFLSBUF), however a search for 
BLKFLSBUF on the Linux 2.6.15 source doesn't seem to return anything related 
to IDE or SCSI disks.

Can I trust ioctl(BLKFLSBUF) to flush disks' write caches (for disks that 
follow the specs)?

What about block devices of disk partitions, LVM logical volumes and the EMVS 
volumes, do they propagate flush commands to the respective disks?

What about loop devices?

Thanks in advance.
