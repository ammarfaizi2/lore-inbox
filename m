Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTLIJNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266177AbTLIJNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:13:24 -0500
Received: from [24.78.220.246] ([24.78.220.246]:62922 "EHLO mail.thock.com")
	by vger.kernel.org with ESMTP id S263679AbTLIJLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:11:39 -0500
Message-ID: <3FD59231.70907@thock.com>
Date: Tue, 09 Dec 2003 03:13:21 -0600
From: Dylan Griffiths <dylang@thock.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: At what point should 2.6.0t11 stop mounting a CDROM?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I recently upgraded to 2.6.0test11, and have been enjoying great 
performance and reliability.  Until I tried to mount a VCD, that is.  I 
have a DVD-ROM/CDRW drive that's detected fine:
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 6L060J3, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST RW/DVD GCC-4120B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117266688 sectors (60040 MB) w/1819KiB Cache, CHS=65535/16/63, 
UDMA(100)
  hda: hda1 hda2 < hda5 hda6 >
hdc: ATAPI 32X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.12

This is what happens when I try to mount a CDROM (fs type auto in 
/etc/fstab):

hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d
hdc: ATAPI reset complete
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d
hdc: ATAPI reset complete
hdc: status timeout: status=0x80 { Busy }
hdc: status timeout: error=0x80LastFailedSense 0x08
hdc: status timeout: status=0x80 { Busy }
hdc: status timeout: error=0x80LastFailedSense 0x08
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: status timeout: status=0x80 { Busy }
hdc: status timeout: error=0x80LastFailedSense 0x08
hdc: ATAPI reset complete
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d
hdc: status timeout: status=0xd0 { Busy }
hdc: status timeout: error=0xd0LastFailedSense 0x0d
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d
hdc: ATAPI reset complete
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d
hdc: ATAPI reset complete
end_request: I/O error, dev hdc, sector 0
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d
hdc: ATAPI reset complete
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 0
Buffer I/O error on device hdc, logical block 0
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 4
Buffer I/O error on device hdc, logical block 1
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 8
Buffer I/O error on device hdc, logical block 2
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 12
Buffer I/O error on device hdc, logical block 3
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 16
Buffer I/O error on device hdc, logical block 4
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 20
Buffer I/O error on device hdc, logical block 5
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 24
Buffer I/O error on device hdc, logical block 6
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 28
Buffer I/O error on device hdc, logical block 7
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 32
Buffer I/O error on device hdc, logical block 8
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 36
Buffer I/O error on device hdc, logical block 9
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 40
Buffer I/O error on device hdc, logical block 10
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 44
Buffer I/O error on device hdc, logical block 11
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 48
Buffer I/O error on device hdc, logical block 12
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 52
Buffer I/O error on device hdc, logical block 13
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 56
Buffer I/O error on device hdc, logical block 14
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 60
Buffer I/O error on device hdc, logical block 15
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 64
Buffer I/O error on device hdc, logical block 16
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 68
Buffer I/O error on device hdc, logical block 17
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 72
Buffer I/O error on device hdc, logical block 18
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 76
Buffer I/O error on device hdc, logical block 19
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 80
Buffer I/O error on device hdc, logical block 20
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 84
Buffer I/O error on device hdc, logical block 21
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 88
Buffer I/O error on device hdc, logical block 22
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 92
Buffer I/O error on device hdc, logical block 23
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d
hdc: ATAPI reset complete
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d
hdc: ATAPI reset complete
end_request: I/O error, dev hdc, sector 96
Buffer I/O error on device hdc, logical block 24
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 100
Buffer I/O error on device hdc, logical block 25
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 104
Buffer I/O error on device hdc, logical block 26
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 108
Buffer I/O error on device hdc, logical block 27
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 112
Buffer I/O error on device hdc, logical block 28
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 116
Buffer I/O error on device hdc, logical block 29
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 120
Buffer I/O error on device hdc, logical block 30
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 124
Buffer I/O error on device hdc, logical block 31
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 0
Buffer I/O error on device hdc, logical block 0


Shouldn't the kernel GIVE UP at some point, rather than hang the mount 
process while it seeks through the entire block device, spewing errors 
all the way, and forcing me to either way a few days or reboot to fix 
the problem?

