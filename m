Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283244AbSALCzY>; Fri, 11 Jan 2002 21:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283286AbSALCzP>; Fri, 11 Jan 2002 21:55:15 -0500
Received: from mx.fluke.com ([129.196.128.53]:15367 "EHLO
	evtvir03.tc.fluke.com") by vger.kernel.org with ESMTP
	id <S283268AbSALCy6>; Fri, 11 Jan 2002 21:54:58 -0500
Date: Fri, 11 Jan 2002 18:55:07 -0800 (PST)
From: David Dyck <dcd@tc.fluke.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: <linux-kernel@vger.kernel.org>
Subject: IDE cdrom  cdrom_read_intr: data underrun / end_request: I/O error
 --- was Re: Patch: linux-2.5.2-pre7/drivers/cdrom additional kdev_t fixes
In-Reply-To: <200201120124.RAA10614@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.33.0201111841320.193-100000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002 at 17:24 -0800, Adam J. Richter <adam@yggdrasil.com> wrote:

> >I had been testing 2.5.2-pre11 and earlier, but hadn't looked at
> >reading from my cdrom for a while.  Yesterday I created examined several
> >large cdrom sets that had been readable earlier and they read partially
> >but get read errors.  These same cdroms can be read reliable on
> >2.4.18-pre3 using the same hardware, and are readable on other
> >PC's runing older kernels.
>
> >Has anyone else seen cdrom read errors with 2.5.2-pre* kernels?

Thanks for your response Adam,

> 	Please indicate what kind of interface your CDROM drive
> has (and preferably make and model of the drive) and what
> errors you saw.
>
> 	If you are using an IDE or SCSI CDROM drive, then the problems
> you are experiencing have nothing to do with my patch.  My patch was
> only for the very old "proprietary interface" CDROM drives, which are
> almost all "1X" or "2X" speed drives.

Using 2.5.2-pre11

# mount /cdrom && md5sum /cdrom/*
md5sum: /cdrom/dcd-c.tar.gz: I/O error
md5sum: /cdrom/dcd-d.tar.gz: I/O error


An example of some of the messages were

    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hdc: NEC CD-ROM DRIVE:28B, ATAPI CD/DVD-ROM drive
hdc: ATAPI 32X CD-ROM drive, 256kB Cache


VFS: Disk change detected on device ide1(22,0)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
hdc: cdrom_read_intr: data underrun (4294967256 blocks)
end_request: I/O error, dev 16:00, sector 299300
hdc: cdrom_read_intr: data underrun (4294967260 blocks)
end_request: I/O error, dev 16:00, sector 299304

  errors repeated with sector and blocks increasing by 4
  repeating 118 times


but using 2.4.18-pre3 I get no errors

