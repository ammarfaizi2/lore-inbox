Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTKFO61 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 09:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTKFO61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 09:58:27 -0500
Received: from web40907.mail.yahoo.com ([66.218.78.204]:11387 "HELO
	web40907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263526AbTKFO6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 09:58:24 -0500
Message-ID: <20031106145823.89899.qmail@web40907.mail.yahoo.com>
Date: Thu, 6 Nov 2003 06:58:23 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Badness in as_put_request with 2.6.0-test9-mm2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After updating my CD/DVD drive's firmware to a newer version, I rebooted my
system to test the device. I successfully mounted and unmounted a DVD that
was formatted with UDF; yet I got this badness message on 2.6.0-test9-mm2:

cdrom: open failed.
UDF-fs INFO UDF 0.9.7 (2002/11/15) Mounting volume 'ROBIN_WILLIAMS_LIVE_ON_BROADWA',
timestamp 2003/01/06 17:46 (1000)
arq->state 4
Badness in as_put_request at drivers/block/as-iosched.c:1783
Call Trace:
 [<c0290d01>] as_put_request+0x62/0xc0
 [<c02869f4>] elv_put_request+0x1f/0x21
 [<c02899f1>] __blk_put_request+0x6d/0xb5
 [<c0289acf>] blk_put_request+0x96/0x1ab
 [<c028e048>] scsi_cmd_ioctl+0x23a/0x59a
 [<c0157294>] kmem_cache_alloc+0xe2/0x1fd
 [<c02a9b31>] ide_cdrom_check_media_change_real+0x35/0x51
 [<c02afc11>] media_changed+0x60/0x87
 [<c02afc6d>] cdrom_media_changed+0x35/0x37
 [<c02a19fa>] generic_ide_ioctl+0x936/0x9e0
 [<c02aa9cb>] idecd_open+0x69/0x8c
 [<c01851aa>] do_open+0x247/0x70a
 [<c018469c>] bd_acquire+0x1b7/0x3fd
 [<c0178d86>] get_empty_filp+0x4f/0xe8
 [<c01856ed>] blkdev_open+0x0/0x78
 [<c0185721>] blkdev_open+0x34/0x78
 [<c02aaa52>] idecd_ioctl+0x35/0x6c
 [<c028bd6d>] blkdev_ioctl+0xa5/0x449
 [<c0192d72>] sys_ioctl+0x204/0x3ee
 [<c0176eab>] sys_open+0x7e/0x8b
 [<c03b8cd6>] sysenter_past_esp+0x43/0x65

This is what the IDE subsystem has to say:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N030ATCS04-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)

And this is what hdparm says about my CD drive:

/dev/hdc:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  1 (on)
 readahead    = 256 (on)
 HDIO_GETGEO failed: Invalid argument

Should I try fiddling with my hdparm settings, or is it related to the firmware
update?

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
