Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263476AbRFYKpd>; Mon, 25 Jun 2001 06:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263480AbRFYKpX>; Mon, 25 Jun 2001 06:45:23 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:47831 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S263476AbRFYKpM>; Mon, 25 Jun 2001 06:45:12 -0400
Date: Mon, 25 Jun 2001 13:44:59 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Access beyond end of dev with FAT on 2.4.4ac17
Message-ID: <20010625134459.P1503@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that all updatedb processes hang when accessing my 2GB fat partition.
The kernel spits these:

Jun 24 04:02:29 terminator kernel: Filesystem panic (dev 08:01).
Jun 24 04:02:29 terminator kernel:   FAT error
Jun 24 04:02:29 terminator kernel: Directory 889834: bad FAT
Jun 24 04:02:32 terminator kernel: Filesystem panic (dev 08:01).
Jun 24 04:02:32 terminator kernel:   FAT error
Jun 24 04:02:32 terminator kernel: Directory 889836: bad FAT
Jun 24 04:03:08 terminator kernel: Filesystem panic (dev 08:01).
Jun 24 04:03:08 terminator kernel:   FAT error
Jun 24 04:03:08 terminator kernel: Directory 889864: bad FAT
Jun 24 04:03:26 terminator kernel: Filesystem panic (dev 08:01).
Jun 24 04:03:26 terminator kernel:   FAT error
Jun 24 04:03:26 terminator kernel: Directory 889884: bad FAT
Jun 24 04:03:28 terminator kernel: attempt to access beyond end of device
Jun 24 04:03:28 terminator kernel: 08:01: rw=0, want=2095531, limit=2048256
Jun 24 04:03:28 terminator kernel: attempt to access beyond end of device
Jun 24 04:03:28 terminator kernel: 08:01: rw=0, want=2095531, limit=2048256
Jun 24 04:03:28 terminator kernel: attempt to access beyond end of device
Jun 24 04:03:28 terminator kernel: 08:01: rw=0, want=2095532, limit=2048256
Jun 24 04:03:28 terminator kernel: attempt to access beyond end of device
Jun 24 04:03:28 terminator kernel: 08:01: rw=0, want=2095532, limit=2048256
Jun 24 04:03:28 terminator kernel: attempt to access beyond end of device
Jun 24 04:03:28 terminator kernel: 08:01: rw=0, want=2095533, limit=2048256
Jun 24 04:03:28 terminator kernel: attempt to access beyond end of device

This happened once or twice with an NT fat partition. Then I thought
something (possibly hosed scsi termination) had screwed the partition for
good, and wiped the fs. I remade it with mkfs.msdos (fat16, check for bad
blocks), copied 1.5GB stuff over - and the next night I got the same errors
from updatedb. I didn't boot the machine in the middle, nevermind running NT.

The ext2 fs on the same disk is (fortunately) 100% ok although it's used a
lot more.

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1   *         1       255   2048256    6  FAT16
/dev/sda2           256      2100  14819962+  83  Linux
/dev/sda3          2101      2213    907672+  82  Linux swap

This is 18GB Seagate, Adaptec 2940 UW Pro scsi, 400PII.

Is the fs now hosed? (Updatedb should only read the disk, but it is
possible that copying the data screwed the fs). What can I do to help
debugging the problem?

 
-- v --

v@iki.fi
