Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264351AbUAEMc2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 07:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbUAEMc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 07:32:28 -0500
Received: from host112-103.pool80181.interbusiness.it ([80.181.103.112]:37126
	"EHLO kratorius.ath.cx") by vger.kernel.org with ESMTP
	id S264351AbUAEMcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 07:32:25 -0500
Date: Mon, 5 Jan 2004 13:31:44 +0100
From: Giuliani Ivan <kratorius@lugbari.org>
To: linux-kernel@vger.kernel.org
Subject: cdrom drive doens't answering
Message-Id: <20040105133144.5276a4be@malattia.net>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
today I was installing mutt from my own slack 9.1 cdrom. As soon as I wrote
installpkg mutt... the console seemed to be freezed. I killed then the
process from another console but the cdrom continued reading from the cd.
Trying to umount the device told me that the device was busy but I wasn't using
no more the device.
I tried to eject the cdrom manually and the cdrom went out also if it result
mounted. Looking at dmesg, I saw this:

hdc: timeout waiting for DMA
hdc: timeout waiting for DMA
hdc: (__ide_dma_test_irq) called while not waiting
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev 16:00 (hdc), sector 644968
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev 16:00 (hdc), sector 644972
hdc: timeout waiting for DMA
hdc: timeout waiting for DMA
hdc: (__ide_dma_test_irq) called while not waiting
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev 16:00 (hdc), sector 644976
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev 16:00 (hdc), sector 644980
[repeated 4-5 times]
hdc: timeout waiting for DMA
hdc: timeout waiting for DMA
hdc: (__ide_dma_test_irq) called while not waiting
[again the previous errors]
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0x00
hdc: ATAPI reset complete
[again the previous errors]
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0x00
hdc: ATAPI reset complete
hdc: tray open

I suppose the at this point is when I ejected the cdrom manually. The log
continues:

end_request: I/O error, dev 16:00 (hdc), sector 645108
hdc: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdc: request sense failure: error=0x20LastFailedSense 0x02 
hdc: tray open
[repeated 5-6 times]
hdc: tray open
end_request: I/O error, dev 16:00 (hdc), sector 671480
hdc: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdc: request sense failure: error=0x20LastFailedSense 0x02 

And nothing more.
Umounting the device from the console now didn't give me any error.
Trying to mount some cd again give this:

root@malattia:~# mount /mnt/cdrom/
mount: No medium found


What's happened?
I have the kernel 2.4.22 with slackware 9.1 (default slackware kernel).

hdparm says this:
root@malattia:~# hdparm -i /dev/hdc

/dev/hdc:

 Model=36X CD-ROM, FwRev=VER 2.F0, SerialNo=MT1102 Firmware
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:150}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no

I never got problems with the cd drive, and rebooting the system everything
began to run again.
Is this a kernel problem or a my own fault?

Bye

-- 
Ivan "kratorius" Giuliani  ::  PGP Public Key ID:
http://kratorius.cjb.net   ::  0x840F429D @ keyserver.linux.it
LUGBari Member             ::
