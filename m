Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbTJCLZA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 07:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbTJCLZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 07:25:00 -0400
Received: from mail.midmaine.com ([66.252.32.202]:56289 "HELO
	mail.midmaine.com") by vger.kernel.org with SMTP id S263709AbTJCLY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 07:24:58 -0400
To: linux-kernel@vger.kernel.org
Subject: CMD680, kernel 2.4.21, and heartache
X-Eric-Conspiracy: There Is No Conspiracy
From: Erik Bourget <erik@midmaine.com>
Date: Fri, 03 Oct 2003 07:23:58 -0400
Message-ID: <87brsybm41.fsf@loki.odinnet>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I've got a Big Problem.

Day 0: 8 new NFS servers go online, they are P4-2.4GHz boxes with two each
120GB Samsung drives attached to CMD680/SiI680 IDE controllers.  They run
Debian stable on a 2.4.21 kernel, with SMP enabled though they are uniproc
boxes, running NFSv3-via-TCP and reiserfs.  CMD680/siimage support compiled
in, obviously.  Software RAID, mirroring drives.

Out of 8 boxes:  

*) One has crashed hard.  I'm about to drive to the datacenter to plug in a
   KVM and take a picture.
*) Three have had DMA turned off and have given extremely spooky errors.
   Read below.

Some factors that are definitely NOT a problem:
- Faulty run of drives.  This has also happened to Hitachi 80GB drives in the
  same configurations.

- Heat.  They're in a chilly room.  The cases haven't overheated.  We've had
  guys checking this every few hours after the first one went bonkers.

Possible problems -
- Simple software problem that somebody can fix and save the day. :)
- All Dell Poweredge 650 servers are broken.  :/

Days 1-6: Faithful service.

Day 7: 
Sep 29 09:06:42 mailstore2-1 -- MARK --
Sep 29 09:12:18 mailstore2-1 kernel: hdc: dma_timer_expiry: dma status == 0x20
Sep 29 09:12:18 mailstore2-1 kernel: hdc: status timeout: status=0xd0 { Busy }
Sep 29 09:12:18 mailstore2-1 kernel: 
Sep 29 09:12:18 mailstore2-1 kernel: ide1: reset: success
Sep 29 09:26:42 mailstore2-1 -- MARK --

Few more days of faithful service.

Little bit ago:
Oct  1 07:28:40 mailstore2-1 -- MARK --
Oct  1 07:47:47 mailstore2-1 kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct  1 07:47:47 mailstore2-1 kernel: hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=37694874, high=2, low=4140442, sector=35220864
Oct  1 07:47:47 mailstore2-1 kernel: end_request: I/O error, dev 03:03 (hda), sector 35220864
Oct  1 07:47:47 mailstore2-1 kernel: ^IOperation continuing on 1 devices
Oct  1 07:47:47 mailstore2-1 kernel: md: updating md0 RAID superblock on device
Oct  1 07:47:47 mailstore2-1 kernel: md: hdc3 [events: 00000004]<6>(write) hdc3's sb offset: 115949056
Oct  1 07:47:47 mailstore2-1 kernel: md: recovery thread got woken up ...
Oct  1 07:47:47 mailstore2-1 kernel: md: recovery thread finished ...
Oct  1 07:47:47 mailstore2-1 kernel: md: (skipping faulty hda3 )
Oct  1 08:08:41 mailstore2-1 -- MARK --

Oct  1 10:48:45 mailstore2-1 -- MARK --
Oct  1 10:50:44 mailstore2-1 kernel: hdc: dma_timer_expiry: dma status == 0x20
Oct  1 10:50:44 mailstore2-1 kernel: hdc: status timeout: status=0xd0 { Busy }
Oct  1 10:50:44 mailstore2-1 kernel: 
Oct  1 10:50:44 mailstore2-1 kernel: ide1: reset: success
Oct  1 11:08:46 mailstore2-1 -- MARK --

I'll post again when I've got the text of the kernel panic.

- Erik

