Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbSKFDM6>; Tue, 5 Nov 2002 22:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264858AbSKFDM6>; Tue, 5 Nov 2002 22:12:58 -0500
Received: from sdsl-64-7-1-79.dsl.lax.megapath.net ([64.7.1.79]:9665 "EHLO
	sdsl-64-7-1-79.dsl.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S264779AbSKFDMz>; Tue, 5 Nov 2002 22:12:55 -0500
Date: Tue, 5 Nov 2002 19:19:30 -0800 (PST)
From: <lk@trolloc.com>
X-X-Sender: <bpape@sdsl-64-7-1-79.dsl.lax.megapath.net>
To: <linux-kernel@vger.kernel.org>
Subject: ide, ide_scsi problems in 2.4.20-pre11
Message-ID: <Pine.LNX.4.33.0211051911310.19716-100000@sdsl-64-7-1-79.dsl.lax.megapath.net>
X-keyboard: Happy Hacking Keyboard Lite
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been having problems with a Plextor CD-R connected to a PDC20268
(Promise Ultra-100TX) using the ide_scsi driver since the driver first
appeared.  It's been improving, but as of 2.4.20-pre7-ac3, I'm still
having problems.  The card is in a 33Mhz slot on a Micronics W6LI board.

When I write to the drive (hdg, seen as scsi ID 0) with cdrecord, it will
write successfully for some time (usually 30 MB or more, sometimes even
completing a write), whereas in older kernels it would fail between 1-4
MB.

In earlier 2.4.20-pre kernels, the PDC20268 drivers would report timeouts
resetting the card upon rebooting, and the only way to regain control of
the CD-R was to power the machine down.  This seems to have been fixed
along the way.

Below is pertinant information.  The system completely hangs, but there is 
no kernel oops.

/proc/ide/hdg/media
cdrom

/proc/ide/hdg/model
PLEXTOR CD-R PX-W2410A

/proc/ide/hdg/settings
name			value		min		max		
mode
----			-----		---		---		
----
bios_cyl                0               0               1023            rw
bios_head               0               0               255             rw
bios_sect               0               0               63              rw
current_speed           0               0               69              rw
ide_scsi                0               0               1               rw
init_speed              0               0               69              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
log                     0               0               1               rw
nice1                   1               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
transform               1               0               3               rw
unmaskirq               0               0               1               rw
using_dma               0               0               1               rw


Controller / IDE info:
-------------------------
Oct 28 22:53:04 sdsl-64-7-1-79 kernel: ide_setup: hdg=ide-scsi
Oct 28 22:53:04 sdsl-64-7-1-79 kernel: PDC20268: IDE controller on PCI bus 
00 dev 88
Oct 28 22:53:04 sdsl-64-7-1-79 kernel: PDC20268: chipset revision 1
Oct 28 22:53:04 sdsl-64-7-1-79 kernel: PDC20268: not 100%% native mode: 
will probe irqs later
Oct 28 22:53:04 sdsl-64-7-1-79 kernel: PDC20268: (U)DMA Burst Bit ENABLED 
Primary MASTER Mode Secondary MASTER Mode.
Oct 28 22:53:04 sdsl-64-7-1-79 kernel:     ide2: BM-DMA at 0xece0-0xece7, 
BIOS settings: hde:DMA, hdf:pio
Oct 28 22:53:04 sdsl-64-7-1-79 kernel:     ide3: BM-DMA at 0xece8-0xecef, 
BIOS settings: hdg:pio, hdh:pio
Oct 28 22:53:04 sdsl-64-7-1-79 kernel: hda: IBM-DTTA-371010, ATA DISK 
drive
Oct 28 22:53:04 sdsl-64-7-1-79 kernel: hde: IBM-DTLA-307045, ATA DISK 
drive
Oct 28 22:53:04 sdsl-64-7-1-79 kernel: hdg: PLEXTOR CD-R PX-W2410A, ATAPI 
CD/DVD-ROM drive
Oct 28 22:53:04 sdsl-64-7-1-79 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct 28 22:53:04 sdsl-64-7-1-79 kernel: ide2 at 0xecc8-0xeccf,0xecda on irq 
17
Oct 28 22:53:04 sdsl-64-7-1-79 kernel: ide3 at 0xecd0-0xecd7,0xecde on irq 
17



Syslog before system hangs completely (no oops!)
----------------------------
Oct 28 22:53:54 linux kernel: Uniform CD-ROM driver Revision: 3.12
Oct 28 22:57:47 linux kernel: cdrom: This disc doesn't have any tracks I recognize!
Oct 28 22:59:00 linux kernel: cdrom: This disc doesn't have any tracks I recognize!
Oct 28 22:59:32 linux last message repeated 16 times
Oct 28 23:01:21 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:31 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:31 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:31 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:31 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:31 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:31 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:32 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:32 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:32 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:32 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:32 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:32 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:33 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:33 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:33 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:33 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:33 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:33 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:34 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:34 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:34 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:34 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:34 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:34 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:35 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:35 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:35 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:35 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:35 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:35 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:36 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:36 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:36 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:36 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:36 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:36 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:37 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:37 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:37 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:37 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:37 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:37 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:38 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:38 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:38 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:38 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:38 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:38 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:39 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:39 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:39 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:39 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:39 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:39 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:40 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:40 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:40 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:40 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:40 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:40 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:41 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:41 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:41 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:41 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:41 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:41 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:42 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:42 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:42 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:42 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:42 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:42 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:43 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:43 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:43 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:43 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:43 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:43 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:44 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:44 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:44 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:44 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:44 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:44 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:45 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:45 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:45 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:45 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:45 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:45 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:46 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:46 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:46 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:46 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:46 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:46 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:47 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:47 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:47 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:47 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:47 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:47 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:48 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:48 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:48 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:48 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:48 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:48 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:49 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:49 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:49 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:49 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:49 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:49 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:50 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:50 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:50 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:50 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:50 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:50 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:50 linux kernel: scsi : aborting command due to timeout : pid 3529, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 00 08 3c 00 00 1f 00 
Oct 28 23:01:50 linux kernel: hdg: lost interrupt
Oct 28 23:01:51 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:51 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:51 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:51 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:51 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:51 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:52 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:52 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:52 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:52 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:52 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:52 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:53 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:53 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:53 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:53 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:53 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:53 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:54 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:54 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:54 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:54 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:54 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:54 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:55 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:55 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:55 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:55 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:55 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:55 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:56 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:56 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:56 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:56 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:56 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:56 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:57 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:57 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:57 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:57 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:57 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:57 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:58 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:58 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:58 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:58 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:58 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:58 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:59 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:59 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:59 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:01:59 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:01:59 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:01:59 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:02:00 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:02:00 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:02:00 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:02:00 linux kernel: scsi : aborting command due to timeout : pid 3530, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Oct 28 23:02:00 linux kernel: SCSI host 0 abort (pid 3530) timed out - resetting
Oct 28 23:02:00 linux kernel: SCSI bus is being reset for host 0 channel 0.
Oct 28 23:02:00 linux kernel: hdg: lost interrupt
Oct 28 23:02:00 linux kernel: hdg: lost interrupt
Oct 28 23:02:00 linux kernel: ide-scsi: scatter gather table too small, padding with zeros
Oct 28 23:02:00 linux kernel: hdg: lost interrupt
Oct 28 23:02:00 linux kernel: ide-scsi: scatter gather table too small, padding with zeros
Oct 28 23:02:00 linux kernel: hdg: lost interrupt
Oct 28 23:02:00 linux kernel: ide-scsi: scatter gather table too small, padding with zeros
Oct 28 23:02:00 linux kernel: hdg: lost interrupt
Oct 28 23:02:00 linux kernel: ide-scsi: scatter gather table too small, padding with zeros
Oct 28 23:02:00 linux kernel: hdg: lost interrupt
Oct 28 23:02:00 linux kernel: ide-scsi: scatter gather table too small, padding with zeros
Oct 28 23:02:00 linux kernel: hdg: lost interrupt
Oct 28 23:02:00 linux kernel: ide-scsi: scatter gather table too small, padding with zeros
Oct 28 23:02:00 linux kernel: hdg: lost interrupt
Oct 28 23:02:00 linux kernel: ide-scsi: scatter gather table too small, padding with zeros
Oct 28 23:02:00 linux kernel: hdg: lost interrupt
Oct 28 23:02:00 linux kernel: ide-scsi: scatter gather table too small, padding with zeros
Oct 28 23:02:00 linux kernel: hdg: lost interrupt
Oct 28 23:02:00 linux kernel: ide-scsi: scatter gather table too small, padding with zeros
Oct 28 23:02:00 linux kernel: hdg: lost interrupt
Oct 28 23:02:00 linux kernel: ide-scsi: scatter gather table too small, padding with zeros
Oct 28 23:02:00 linux kernel: hdg: lost interrupt
Oct 28 23:02:01 linux kernel: ide-scsi: scatter gather table too small, padding with zeros
Oct 28 23:02:01 linux kernel: hdg: lost interrupt
Oct 28 23:02:01 linux kernel: ide-scsi: scatter gather table too small, padding with zeros
Oct 28 23:02:01 linux kernel: hdg: lost interrupt
Oct 28 23:07:26 linux syslogd 1.4.1: restart.


