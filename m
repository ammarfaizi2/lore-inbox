Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbVKVRnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbVKVRnX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVKVRnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:43:22 -0500
Received: from compunauta.com ([69.36.170.169]:58299 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S965022AbVKVRnW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:43:22 -0500
From: Gustavo Guillermo =?iso-8859-1?q?P=E9rez?= 
	<gustavo@compunauta.com>
Organization: www.compunauta.com
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: /dev/sr0 not ready, but working
Date: Tue, 22 Nov 2005 11:43:00 -0600
User-Agent: KMail/1.8.2
Cc: Alan Stern <stern@rowland.harvard.edu>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0511221034110.4786-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0511221034110.4786-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511221143.00970.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Martes, 22 de Noviembre de 2005 09:36, Alan Stern escribió:
> On Mon, 21 Nov 2005, Jeff Garzik wrote:
> > On Mon, Nov 21, 2005 at 04:00:51PM -0600, Gustavo Guillermo Pérez wrote:
> > > When I use my external case as Firewire or USB 2.0 I got the error on
> > > the kernel syslog:
> > > sr 0:0:0:0: Device not ready.
> > > last message repeated 187 times
> > >
> > > Same using amdtp FireWire Driver and usb-storage driver.
> > >
> > > but the drive keeps writing and the media finish and close as espected
> > > on the 95% of times, the other 5% :(.
> >
> > This happens on my S/ATAPI box too...
>
> What is an S/ATAPI box?
I guess is a Serial ATA or ATAPI converter to USB, but is Jeff who said that
> Would either of you like to tell us when these messages come up?  What are
> you doing with the drive?  Does it happen only when the drive is writing?
> What about when the drive is reading?  Does anything else of interest
> appear in the system log?
Yes, I do the same operations as iee1394 and USB, and here we go:
1) ieee1394 Dirty DVD+RW ad UdfFileSystem without pktcdvd cause +rw
No Real problems, the errors on logical sectors was and old bad mount, but the 
second one writing 5 o 6 MB of a lot of small files does not produce the 
error.
2) ieee1394 Normal growisofs -Z /dev/sr0 -J -r /folder
No errors on the media, writing as iso not packet.
The error appears while writing the DVD+RW 96 times, not the same udf disk.
3) Reading from The writed disc
No error, normal operation.
4)Changing to USB Interface and ShutDown the iee1394, and do the udf Stuff.
Normal operation no errors on the DVD-RW media.
5) USB Writing Normal growisofs -Z /dev/sr0 -J -r /folder
No errors on the media, writing as iso not packet.
The error appears while writing the DVD-RW 57 times, not the same udf disk, 
less data less errors.
6) Reading data from USB Interface.
No errors normal operation.
7) lspci, lsusb
The mouse is not relevant, I was plugged today.

Working with +RW -RW -R and +R, allways writing not udf packets the error 
appears. As IDE interface the drive does not produce any device not ready 
error.

(1)-------------------------------------------------
ieee1394: Initialized config rom entry `ip1394'
ieee1394: Loaded CMP driver
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:00:14.0[A] -> GSI 16 (level, low) -> IRQ 21
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[21]  MMIO=[e3006000-e30067ff]  
Max
 Packet=[2048]
ieee1394: Loaded AMDTP driver
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0050c50250004101]
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[00000d610056da51]
eth1394: $Rev: 1312 $ Ben Collins <bcollins@debian.org>
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: PIONEER   Model: DVD-RW  DVR-110D  Rev: 1.22
  Type:   CD-ROM                             ANSI SCSI revision: 00
sr0: scsi3-mmc drive: 1x/351x xa/form2 tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 
2005/
11/20 19:41 (1e98)
sr 0:0:0:0: Device not ready.
end_request: I/O error, dev sr0, sector 5380
Buffer I/O error on device sr0, logical block 1345
lost page write due to I/O error on sr0
Buffer I/O error on device sr0, logical block 1346
lost page write due to I/O error on sr0
Buffer I/O error on device sr0, logical block 1347
lost page write due to I/O error on sr0
Buffer I/O error on device sr0, logical block 1348
lost page write due to I/O error on sr0
Buffer I/O error on device sr0, logical block 1349
lost page write due to I/O error on sr0
Buffer I/O error on device sr0, logical block 1350
lost page write due to I/O error on sr0
Buffer I/O error on device sr0, logical block 1351
lost page write due to I/O error on sr0
Buffer I/O error on device sr0, logical block 1352
lost page write due to I/O error on sr0
Buffer I/O error on device sr0, logical block 1353
lost page write due to I/O error on sr0
Buffer I/O error on device sr0, logical block 1354
lost page write due to I/O error on sr0
sr 0:0:0:0: Device not ready.
end_request: I/O error, dev sr0, sector 8656
sr 0:0:0:0: Device not ready.
end_request: I/O error, dev sr0, sector 11932
sr 0:0:0:0: Device not ready.
end_request: I/O error, dev sr0, sector 15208
sr 0:0:0:0: Device not ready.
end_request: I/O error, dev sr0, sector 18484
cdrom: sr0: dirty DVD+RW media, "finalizing"
UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 
2005/
11/20 19:41 (1e98)
cdrom: sr0: dirty DVD+RW media, "finalizing"
(1)----------------------------------------------
(2)----------------------------------------------
XFS mounting filesystem hda6
Ending clean XFS mount for filesystem: hda6
XFS mounting filesystem hda7
Ending clean XFS mount for filesystem: hda7
sr 0:0:0:0: Device not ready.
Las message repeated 96 times
(3)----------------------------------------------
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
(3)----------------------------------------------
(4)----------------------------------------------
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0050c50250004101]
usb 6-1: new high speed USB device using ehci_hcd and address 3
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver ub
  Vendor: PIONEER   Model: DVD-RW  DVR-110D  Rev: 1.22
  Type:   CD-ROM                             ANSI SCSI revision: 00
sr0: scsi3-mmc drive: 62x/62x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
usb-storage: device scan complete
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
pktcdvd: writer pktcdvd0 mapped to sr0
UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 
2005/11/21 13:49 (1e98)
cdrom: sr0: dirty DVD-RW media, "finalizing"
(4)----------------------------------------------
(5)----------------------------------------------
sr 1:0:0:0: Device not ready.
last message repeated 57 times
(5)----------------------------------------------
(6)----------------------------------------------
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
(6)----------------------------------------------
(7)----------------------------------------------
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host 
Bridge (rev 80)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
0000:00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
0000:00:0c.0 USB Controller: OPTi Inc. 82C861 (rev 10)
0000:00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID 
Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge 
[KT600/K8T800/K8T890 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
0000:00:14.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 46)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 
4000 AGP 8x] (rev c1)
Bus 006 Device 003: ID 06e1:d186 ADS Technologies, Inc. 
Bus 006 Device 001: ID 0000:0000  
Bus 005 Device 002: ID 047d:1035 Kensington 
Bus 005 Device 001: ID 0000:0000  
Bus 004 Device 001: ID 0000:0000  
Bus 003 Device 001: ID 0000:0000  
Bus 002 Device 001: ID 0000:0000  
Bus 001 Device 001: ID 0000:0000
(7)----------------------------------------------


-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
