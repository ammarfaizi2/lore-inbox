Return-Path: <linux-kernel-owner+w=401wt.eu-S932521AbWLZM5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWLZM5T (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 07:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWLZM5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 07:57:19 -0500
Received: from s233-64-196-242.try.wideopenwest.com ([64.233.242.196]:49787
	"EHLO echohome.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932521AbWLZM5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 07:57:17 -0500
Reply-To: <erik@echohome.org>
From: "Erik Ohrnberger" <erik@echohome.org>
To: <linux-kernel@vger.kernel.org>
Subject: System / libata IDE controller woes (long)
Date: Tue, 26 Dec 2006 07:57:23 -0500
Organization: echohome.org
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAJ1ef91k2DRKvSshkps/AYkBAAAAAA==@echohome.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: AccW73CBQqkKX0SqQ2+VKiQ/r2X6fQPBuaEg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, Merry Christmas, Seasons Greetings and Happy Holidays!

Hang on, this is a bit of a long story, but I think that you'll need the
information and background.

I want what amounts to a NAS, that I'd like to build on gentoo Linux.  I'm
familiar with gentoo and the use of EVMS, so I think I'm pretty well
prepared from this perspective.

Earlier this year, when I started putting it together, I gathered my
hardware.  A decent 2 GHz Athlon system with 512 MB RAM, DVD drive, a 40 GB
system drive, and a 500 Watt power supply.  Then I started adding hard
disks.  To date, I've got 5 80 GB PATA, 2 200 GB PATA, and 1 60 GB PATA.

I mounted the drives on a set of aluminum rails that I had a friend make for
me.  They run vertically, and have slots through which screws are tightened
into the normal hard drive's mounting holes.  All the communication cables
are 80 pin cables, and run pretty much straight to the controller cards,
while the power pigtails fan out on the side of the 'tower'.

With all these hard drives, I also got 3 Promise 20269 IDE controllers.
After I put it all together, and creating 2 logical volumes, one linked EVMS
LV, and one RAID5 across 5 80 GB drives.  To support this configuration, I
connected the drives in the follow manner (using /dev/hdX notation):

ide0:	/dev/hdc = System boot disk	(Motherboard)
	/dev/hdb = DVD ROM
ide1:	/dev/hdc = nothing
	/dev/hdd = nothing
ide2:	/dev/hde = raid disk		(First Promise card)
	/dev/hdf = lvm disk
ide3:	/dev/hdg = raid disk
	/dev/hdh = lvm disk
ide4:	/dev/hdi = raid disk		(Second Promise card)
	/dev/hdj = lvm disk
ide5:	/dev/hdk = raid disk
	/dev/hdl = nothing
ide6:	/dev/hdm = raid disk		(Thrid Promise card)
	/dev/hdn = nothing
ide7:	/dev/hdo = nothing
	/dev/hdp = nothing

>From what I understood, this is how you want to connect a set of raid drives
so that no one controller is over loaded with IO.  But I had to use the
other ports to connect the LVM.

I started to get 'dma_expiry' errors (see message file extract below):

Dec 22 21:29:33 livecd hdg: dma_timer_expiry: dma status == 0x21
Dec 22 21:29:43 livecd hdg: DMA timeout error
Dec 22 21:29:43 livecd hdg: dma timeout error: status=0x50 { DriveReady
SeekComplete }
Dec 22 21:29:43 livecd ide: failed opcode was: unknown
Dec 22 21:29:43 livecd hdg: task_in_intr: status=0x51 { DriveReady
SeekComplete Error }
Dec 22 21:29:43 livecd hdg: task_in_intr: error=0x04 { DriveStatusError }
Dec 22 21:29:43 livecd ide: failed opcode was: unknown
Dec 22 21:29:43 livecd hdg: task_in_intr: status=0x51 { DriveReady
SeekComplete Error }
Dec 22 21:29:43 livecd hdg: task_in_intr: error=0x04 { DriveStatusError }
Dec 22 21:29:43 livecd ide: failed opcode was: unknown
Dec 22 21:29:43 livecd hdg: task_in_intr: status=0x51 { DriveReady
SeekComplete Error }
Dec 22 21:29:43 livecd hdg: task_in_intr: error=0x04 { DriveStatusError }
Dec 22 21:29:43 livecd ide: failed opcode was: unknown
Dec 22 21:29:43 livecd hdg: task_in_intr: status=0x51 { DriveReady
SeekComplete Error }
Dec 22 21:29:43 livecd hdg: task_in_intr: error=0x04 { DriveStatusError }
Dec 22 21:29:43 livecd ide: failed opcode was: unknown
Dec 22 21:29:43 livecd PDC202XX: Secondary channel reset.
Dec 22 21:29:43 livecd ide3: reset: success
Dec 22 21:30:03 livecd hdg: dma_timer_expiry: dma status == 0x21
Dec 22 21:30:15 livecd hdg: DMA timeout error
Dec 22 21:30:15 livecd hdg: dma timeout error: status=0x80 { Busy }
Dec 22 21:30:15 livecd ide: failed opcode was: unknown
Dec 22 21:30:15 livecd hdg: DMA disabled
Dec 22 21:30:15 livecd PDC202XX: Secondary channel reset.
Dec 22 21:30:20 livecd ide3: reset: success
Dec 22 21:36:58 livecd hdg: irq timeout: status=0x80 { Busy }
Dec 22 21:36:58 livecd ide: failed opcode was: unknown
Dec 22 21:36:58 livecd PDC202XX: Secondary channel reset.
Dec 22 21:37:33 livecd ide3: reset timed-out, status=0x80
Dec 22 21:37:33 livecd hdg: status timeout: status=0x80 { Busy }
Dec 22 21:37:33 livecd ide: failed opcode was: unknown
Dec 22 21:37:33 livecd PDC202XX: Secondary channel reset.
Dec 22 21:37:33 livecd hdg: drive not ready for command
Dec 22 21:37:48 livecd ide3: reset: success
Dec 22 21:37:58 livecd hdg: lost interrupt

These errors caused the raid array to crash repeatedly, so I gave up on that
and changed the raid to an EVMS drive linked logical volume, and changed
their connections to as follows:

ide0:	/dev/hdc = System boot disk	(motherboard)
	/dev/hdb = DVD ROM
ide1:	/dev/hdc = nothing
	/dev/hdd = nothing
ide2:	/dev/hde = lvm1			(first promise card)
	/dev/hdf = lvm1
ide3:	/dev/hdg = lvm1
	/dev/hdh = lvm1
ide4:	/dev/hdi = lvm1			(second promise card)
	/dev/hdj = nothing
ide5:	/dev/hdk = lvm2
	/dev/hdl = lvm2
ide6:	/dev/hdm = lvm2			(third promise card)
	/dev/hdn = nothing
ide7:	/dev/hdo = nothing
	/dev/hdp = nothing

Still got the same dma_timer_expiry errors. I consulted this list as to how
to resolve them.  The wisdom of the list recommended that I try libata
rather than the old ide controller code.  So I patched the kernel, and all
was well, for quite some time.

But then I started to get random lockups.  I upgraded the kernel to 2.6.19,
which has all the libata code in it, and ran it.  This didn't help.  I
enabled nmi_watchdog in order to track down which drive was causing the
problems.  It helped, and pointed to a drive (see message log file extract
below):

Dec 25 03:13:23 storage ATA: abnormal status 0x80 on port 0xE0A817DF
Dec 25 03:13:23 storage ATA: abnormal status 0x80 on port 0xE0A817DF
Dec 25 03:13:23 storage ATA: abnormal status 0x80 on port 0xE0A817DF
Dec 25 03:13:53 storage ata5.01: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Dec 25 03:13:53 storage ata5.01: (BMDMA stat 0x1)
Dec 25 03:13:53 storage ata5.01: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0
(timeout)
Dec 25 03:14:00 storage ata5: port is slow to respond, please be patient
(Status 0x80)
Dec 25 03:14:23 storage ata5: port failed to respond (30 secs, Status 0x80)
Dec 25 03:14:23 storage ata5: soft resetting port
Dec 25 03:14:30 storage ata5: port is slow to respond, please be patient
(Status 0xd0)
Dec 25 03:14:53 storage ata5: port failed to respond (30 secs, Status 0xd0)
Dec 25 03:14:53 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:14:53 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:14:53 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:14:53 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:14:53 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:14:53 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:15:23 storage ata5.00: qc timeout (cmd 0xec)
Dec 25 03:15:23 storage ata5.00: failed to IDENTIFY (I/O error,
err_mask=0x4)
Dec 25 03:15:23 storage ata5.00: revalidation failed (errno=-5)
Dec 25 03:15:23 storage ata5: failed to recover some devices, retrying in 5
secs
Dec 25 03:15:28 storage ata5: soft resetting port
Dec 25 03:15:35 storage ata5: port is slow to respond, please be patient
(Status 0xd0)
Dec 25 03:15:58 storage ata5: port failed to respond (30 secs, Status 0xd0)
Dec 25 03:15:58 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:15:58 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:15:58 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:15:58 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:15:58 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:15:58 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:16:28 storage ata5.00: qc timeout (cmd 0xec)
Dec 25 03:16:28 storage ata5.00: failed to IDENTIFY (I/O error,
err_mask=0x4)
Dec 25 03:16:28 storage ata5.00: revalidation failed (errno=-5)
Dec 25 03:16:28 storage ata5: failed to recover some devices, retrying in 5
secs
Dec 25 03:16:33 storage ata5: soft resetting port
Dec 25 03:16:41 storage ata5: port is slow to respond, please be patient
(Status 0xd0)
Dec 25 03:17:04 storage ata5: port failed to respond (30 secs, Status 0xd0)
Dec 25 03:17:04 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:17:04 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:17:04 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:17:04 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:17:04 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:17:04 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:17:34 storage ata5.00: qc timeout (cmd 0xec)
Dec 25 03:17:34 storage ata5.00: failed to IDENTIFY (I/O error,
err_mask=0x4)
Dec 25 03:17:34 storage ata5.00: revalidation failed (errno=-5)
Dec 25 03:17:34 storage ata5.00: disabled
Dec 25 03:17:34 storage ata5: failed to recover some devices, retrying in 5
secs
Dec 25 03:17:39 storage ATA: abnormal status 0x80 on port 0xE0A817DF
Dec 25 03:17:39 storage ata5.01: failed to IDENTIFY (I/O error,
err_mask=0x40)
Dec 25 03:17:39 storage ata5.01: revalidation failed (errno=-5)
Dec 25 03:17:39 storage ata5: failed to recover some devices, retrying in 5
secs
Dec 25 03:17:51 storage ata5: port is slow to respond, please be patient
(Status 0x80)
Dec 25 03:18:14 storage ata5: port failed to respond (30 secs, Status 0x80)
Dec 25 03:18:14 storage ata5: soft resetting port
Dec 25 03:18:21 storage ata5: port is slow to respond, please be patient
(Status 0xd0)
Dec 25 03:18:44 storage ata5: port failed to respond (30 secs, Status 0xd0)
Dec 25 03:18:44 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:18:44 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:18:44 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:18:44 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:18:44 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:18:44 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:19:14 storage ata5.01: qc timeout (cmd 0xec)
Dec 25 03:19:14 storage ata5.01: failed to IDENTIFY (I/O error,
err_mask=0x4)
Dec 25 03:19:14 storage ata5.01: revalidation failed (errno=-5)
Dec 25 03:19:14 storage ata5: failed to recover some devices, retrying in 5
secs
Dec 25 03:19:19 storage ata5: soft resetting port
Dec 25 03:19:26 storage ata5: port is slow to respond, please be patient
(Status 0xd0)
Dec 25 03:19:49 storage ata5: port failed to respond (30 secs, Status 0xd0)
Dec 25 03:19:49 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:19:49 storage ATA: abnormal status 0xD2 on port 0xE0A817DF
Dec 25 03:19:49 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:19:49 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:19:49 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:19:49 storage ATA: abnormal status 0xD0 on port 0xE0A817DF
Dec 25 03:20:19 storage ata5.01: qc timeout (cmd 0xec)
Dec 25 03:20:19 storage ata5.01: failed to IDENTIFY (I/O error,
err_mask=0x4)
Dec 25 03:20:19 storage ata5.01: revalidation failed (errno=-5)
Dec 25 03:20:19 storage ata5.01: disabled
Dec 25 03:20:20 storage ata5: EH complete
Dec 25 03:20:20 storage sd 4:0:1:0: SCSI error: return code = 0x00040000
Dec 25 03:20:20 storage end_request: I/O error, dev sdg, sector 271144

However, when I take the drives off that system put them another on
another's motherboard IDE connection, and run badblocks in read only mode on
all the drives, I get no errors, not a single one on any of the drives.  So
if it's not the physical IO that causing problems, it must be the interface?

Something is clearly wrong here, and I'm at a loss as to what it may be or
how to resolve it.

1). Could it be that this is just too many PCI IDE drive controllers in one
system?  That they are fighting each other for resources when they are all
being read from and written to?

2). If it is in fact that there are too many IDE controllers, is there any
advantage in a single board with many drive connections over many boards?

3). Are there any BIOS or kernel settings that I could make that would
resolve what may be this resource contention?  A slower CPU? (I have a
similar 900 MHz Athlon system and file serving is hardly CPU intensive).

4). Is it that the Promise 20269 are bad choice of controllers and I should
change to a different ones?  If so, what is a good choice?

5). Should I consider migrating everything to SATA with SIL 3114
controllers?

6). Should I consider reducing the number of smaller disks in favor or fewer
larger ones?

7). What if I add a SIL 3114 SATA controller and SATA disks to migrate off,
will I cause the same issue by adding yet another PCI hard disk controller?

Lspci output for further reference:
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?)
(rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 0 (rev c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:06.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02)
01:07.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02)
01:08.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02)
01:0a.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev
10)
02:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QM
[Radeon 9100]

