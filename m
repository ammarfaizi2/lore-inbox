Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135866AbRECRyN>; Thu, 3 May 2001 13:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135868AbRECRxz>; Thu, 3 May 2001 13:53:55 -0400
Received: from belcebu.upc.es ([147.83.2.63]:42238 "EHLO belcebu.upc.es")
	by vger.kernel.org with ESMTP id <S135855AbRECRwQ>;
	Thu, 3 May 2001 13:52:16 -0400
Date: Thu, 3 May 2001 20:57:33 +0200
From: Francesc Oller <francesc@startrek.upc.es>
To: linux-kernel@vger.kernel.org, debian-user@lists.debian.org
Subject: corrupted ext2 filesystem with raidtools 0.42 and nbd 1.4
Message-ID: <20010503205733.A395@startrek.upc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm gathering together 15 sparse 1GB files distributed in 5 PCs with
3 files each to get a 15GB block device. I'm using nbd 1.4 and raidtools
0.42 in linear mode. Kernel is 2.2.15

I intend to use the block device as a debian archive mirror but after
some amount of successful downloading the file system gets badly corrupted
and I've to fse2ck it. I don't know whose fault it is raid?, nbd? Are
they stable enough for this kind of work? Is anybody doing similar things?
Can anybody help?

My setup is the following:

To start:

losetup /dev/loop0 .debian0
losetup /dev/loop1 .debian1
losetup /dev/loop2 .debian2
./nbd-client soft8 60200 /dev/nd0
./nbd-client soft7 60200 /dev/nd1
./nbd-client soft6 60200 /dev/nd2
./nbd-client soft5 60200 /dev/nd3

/sbin/mdadd /dev/md0 /dev/loop0 /dev/loop1 /dev/loop2 /dev/nd0 \
  /dev/nd1 /dev/nd2 /dev/nd3 
/sbin/mdrun -pl /dev/md0

nbd-server is started from inetd with a line:

nbd stream tcp nowait nbd /francesc0/local/bin/nbd-server nbd-server 0\
  /francesc0/local/bin/.debian%%d 3072M -m

To stop:

/sbin/mdstop /dev/md0

# kill nbd-servers in soft5, soft6, soft7, soft8

losetup -d /dev/loop2
losetup -d /dev/loop1
losetup -d /dev/loop0

Cheers

Francesc Oller
