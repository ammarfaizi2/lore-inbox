Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWGASSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWGASSz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 14:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWGASSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 14:18:55 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:23179 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750996AbWGASSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 14:18:54 -0400
Date: Sat, 1 Jul 2006 20:14:55 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm5 dislikes raid-1, just like mm4
Message-ID: <20060701181455.GA16412@aitel.hist.no>
References: <20060701033524.3c478698.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060701033524.3c478698.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I  just got mm5 up, and it has the same problem as mm4.
Raid-1 does not work. I used 2.6.16 to resync my raids,
and booted into 2.6.17-mm5.

[...]
md:  adding sda2 ...
md: created md0
md: bind<sda2>
md: bind<sdb1>
md: running: <sdb1><sda2>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
  Vendor: USB2.0    Model:       HS-CF       Rev: 1.64
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 3:0:0:0: Attached scsi removable disk sdf
sd 3:0:0:0: Attached scsi generic sg5 type 0
  Vendor: USB2.0    Model:       HS-MS       Rev: 1.64
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 3:0:0:1: Attached scsi removable disk sdg
sd 3:0:0:1: Attached scsi generic sg6 type 0
  Vendor: USB2.0    Model:       HS-SM       Rev: 1.64
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 3:0:0:2: Attached scsi removable disk sdh
sd 3:0:0:2: Attached scsi generic sg7 type 0
  Vendor: USB2.0    Model:       HS-SD/MMC   Rev: 1.64
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 3:0:0:3: Attached scsi removable disk sdi
sd 3:0:0:3: Attached scsi generic sg8 type 0
usb-storage: device scan complete
loadkeys[2214]: segfault at 00000000000005a0 rip 00002b22e169feea rsp 00007fffc973c478 error 4
Adding 1000424k swap on /dev/sda6.  Priority:1 extents:1 across:1000424k
EXT3 FS on sdd1, internal journal
raid1: Disk failure on sda2, disabling device. 
        Operation continuing on 1 devices
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:1, o:0, dev:sda2
 disk 1, wo:0, o:1, dev:sdb1
RAID1 conf printout:
 --- wd:1 rd:2
 disk 1, wo:0, o:1, dev:sdb1
raid1: Disk failure on sda5, disabling device. 
        Operation continuing on 1 devices
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:1, o:0, dev:sda5
 disk 1, wo:0, o:1, dev:sdb5
RAID1 conf printout:
 --- wd:1 rd:2
 disk 1, wo:0, o:1, dev:sdb5
raid1: Disk failure on sde2, disabling device. 
        Operation continuing on 1 devices
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:1, o:0, dev:sde2
 disk 1, wo:0, o:1, dev:sdd2
RAID1 conf printout:
 --- wd:1 rd:2
 disk 1, wo:0, o:1, dev:sdd2
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with journal data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
PM: Writing back config space on device 0000:00:0b.0 at offset b (was 165314e4, writing 13001462)
PM: Writing back config space on device 0000:00:0b.0 at offset 3 (was 0, writing 2008)
PM: Writing back config space on device 0000:00:0b.0 at offset 2 (was 2000000, writing 2000003)
PM: Writing back config space on device 0000:00:0b.0 at offset 1 (was 2b00000, writing 2b00006)
ADDRCONF(NETDEV_UP): eth0: link is not ready
[...]

As we see, the md devices are assembled, then the filesystems are
mounted and swap turned on.  Then all three md devices fail a 
partition at the same time.  Somehow, I don't believe that
is correct. ;-)

Nothing else was logged.

Helge Hafting
