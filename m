Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbWECJRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWECJRX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 05:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbWECJRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 05:17:23 -0400
Received: from 213-140-2-75.ip.fastwebnet.it ([213.140.2.75]:6116 "EHLO
	aa008msg.fastweb.it") by vger.kernel.org with ESMTP id S965131AbWECJRW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 05:17:22 -0400
Date: Wed, 3 May 2006 11:16:53 +0200
From: Andrea Gelmini <andrea.gelmini@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16/MD/DM-crypt/fs corruption
Message-ID: <20060503091653.GA5940@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	to make short a long story:
	a) five pata disks Maxtor 500GB each one;
	b) one big software raid 5 (/dev/md1);[1]
	c) dmcrypt-ing /dev/md1;[2]
	d) after 500GB copied I've got fs corruption;[3]

	vanilla kernel, well tested hardware,[4] debian testing (to have
	dm-crypt).
	I'm using same configuration (md+dm-crypt+ext2/3) on other server,
	without problem, from years.
	It's first time I use it on big partitions (1.9TB), sure there are 
	situations with much bigger storage, and it's first time I've got
	problems. So:
	a) is anybody outthere using this kind of configuration with
	success?
	b) what can I do to debug the problem? I've spent last weeks
	working on hardware (dell servers mostly), to be sure to avoid
	hardware problems;
	c) has someone (OSDL?) regression tests on md+dm-crypt?

Thanks a lot for your time,
gelma


----
[1] /root/mdadm -Cv /dev/md1 --bitmap-chunk=1024 --chunk=256 \
    --assume-clean --bitmap=internal -l5 -n5 /dev/hd[aefgh]
[2] mkfs.ext3 -L 'tritone' -m0 -N 5000000 /dev/mapper/raidone
[3] usually metadata, files checksum is good, but I have a lot of files in
    /lost+found, after fsck, and sometimes I have to use debugfs to
    unlink some of them (chatt/lsatt doesn't work on them). I can see the
    problem with ext2/ext3/reiserfs. 
[4] memtest and so on. I also tried the same box of disks on totally
    different hardware, with same results. changed from ATA cable to RAM.
    I tried also different IDE controller (the one on motherbords, old HPT
    370/372, new HPT 302).
