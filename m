Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbSJMPWh>; Sun, 13 Oct 2002 11:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261536AbSJMPWh>; Sun, 13 Oct 2002 11:22:37 -0400
Received: from gemini.nr.no ([156.116.2.76]:13209 "EHLO gemini.nr.no")
	by vger.kernel.org with ESMTP id <S261535AbSJMPWg>;
	Sun, 13 Oct 2002 11:22:36 -0400
To: linux-kernel@vger.kernel.org
Subject: Bug/panic: ATAPI fails with 2.4.20-pre10-ac2
From: Thor Kristoffersen <Thor.Kristoffersen@nr.no>
Date: 13 Oct 2002 17:28:23 +0200
Message-ID: <yznit06jr3c.fsf@triumph.nr.no>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *180kfI-0001ia-00*5eomIdWfgbY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System:
  MSI KT3 Ultra2 (KT333/VT8235 bridges)
  XP1700+
  1G DDR RAM
  Seagate ST380021A
  Plexwriter PX-W2410A
  Radeon 32M SDR
  Ensoniq 5880 AudioPCI
  SMC EtherPower II
  RedHat 8.0
  GCC 3.2


Linux 2.4.20-pre10:

Setup A: IDE0 = HD, IDE1 = HD
and
Setup B: IDE0 = HD, IDE1 = ATAPI CD-Writer w/ide-scsi driver

  Everything works, but only in PIO mode.


Linux 2.4.20-pre10-ac2:

Setup A: IDE0 = HD, IDE1 = HD

  Everything works in UDMA mode 5.


Setup B: IDE0 = HD, IDE1 = ATAPI CD-Writer w/ide-scsi driver

  The HD works in UDMA mode 5, but the ATAPI CD-Writer is unusable.
  When I try to mount a CD-ROM, the kernel spews lots of messages like these:
    hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
    hdc: drive not ready for command
    hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
    hdc: drive not ready for command
    hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
    hdc: drive not ready for command
    hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
    hdc: drive not ready for command
    hdc: status error: status=0x49 { DriveReady DataRequest Error }
    hdc: status error: error=0x04
    hdc: drive not ready for command
    hdc: ATAPI reset complete
  Usually the CD-ROM can be mounted and read, although it is extremely
  slow.  Once, however, the kernel paniced before it got as far as mounting
  it.  Unfortunately the oops was not captured in the logs, but I think its
  last words were something like "AIEEE, killed interrupt handler".


If anyone is willing to look into this problem I'd be happy to send you
whatever logs, config, and /proc information you need.  I can also try out
new patches.


Thor
