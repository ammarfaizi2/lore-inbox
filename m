Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSFKMmv>; Tue, 11 Jun 2002 08:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317021AbSFKMmu>; Tue, 11 Jun 2002 08:42:50 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:16906 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S317018AbSFKMmt>;
	Tue, 11 Jun 2002 08:42:49 -0400
Message-ID: <3D05EFC7.10C17B08@torque.net>
Date: Tue, 11 Jun 2002 08:40:39 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: fdisk on scsi disks in 2.5.21
In-Reply-To: <3D054432.88C5BE59@torque.net> <3D059893.60206@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> Douglas Gilbert wrote:
> > $ fdisk -l /dev/sda
> >
> > Disk /dev/sda: 1 heads, 35843670 sectors, 1 cylinders
> > Units = cylinders of 35843670 * 512 bytes
> >
> >    Device Boot    Start       End    Blocks   Id  System
> > /dev/sda1   *         1         1     32098+  83  Linux
> > Partition 1 has different physical/logical beginnings (non-Linux?):
> >      phys=(0, 1, 1) logical=(0, 0, 64)
> > Partition 1 has different physical/logical endings:
> >      phys=(3, 254, 63) logical=(0, 0, 64260)
> > Partition 1 does not end on cylinder boundary:
> >      phys=(3, 254, 63) should be (3, 0, 35843670)
> > /dev/sda2             1         1    168682+  83  Linux
> > Partition 2 has different physical/logical beginnings (non-Linux?):
> >      phys=(4, 0, 1) logical=(0, 0, 64261)
> > Partition 2 has different physical/logical endings:
> >      phys=(24, 254, 63) logical=(0, 0, 401625)
> > Partition 2 does not end on cylinder boundary:
> >      phys=(24, 254, 63) should be (24, 0, 35843670)
> > ....
> >
> > One head, one cylinder and lots of sectors??
> > I put some debug in drivers/scsi/scsicam.c and it doesn't
> > seem like it was called.
> >
> > Is my fdisk (from RH 7.2) too old?
> 
> No please: Just please don't look at ide-scsi in 2.5.21
> without applying IDE  patch number 86.

$ cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST318451LW       Rev: 0003
  Type:   Direct-Access                    ANSI SCSI revision: 03

This disk i(/dev/sda) is an Ultra 160 (SPI) connected to 
a Tekram DC-309U3W controller.

The reported problem occurs with all disks seen by the scsi
subsystem in lk 2.5.21 that I have tested including usb mass
storage and ieee1394 sbp2. I am not aware of any ATA disks
that support ATAPI and hence could be used with ide-scsi
driver (if it didn't crash in 2.5.21).

My guess is that there is a problem in the block (or genhd)
subsystem.

Doug Gilbert
