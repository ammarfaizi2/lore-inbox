Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTJaDTg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 22:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTJaDTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 22:19:35 -0500
Received: from ns.xdr.com ([209.48.37.1]:45776 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S262834AbTJaDTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 22:19:30 -0500
From: Dave Ashley <dash@xdr.com>
Date: Thu, 30 Oct 2003 19:19:45 -0800
To: linux-kernel@vger.kernel.org
Subject: CDROM read error "recovery"
Message-ID: <3FA1D4D1.mailAV11K891@dave.home>
User-Agent: nail 10.4 1/19/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux version 2.6.0-test8 (root@dave) (gcc version 3.2.2) #5 Sat Oct 25 20:41:41 PDT 2003

IDE dvd drive (hdd) accessed using scsi emulation as /dev/sc0

I've put in a cdrw copy of slackware 9.1 disk 1 in the drive (dvd drive).
I did
dd if=/dev/sr0 of=slackware91a.iso bs=65536
Got as far as
-rw-r--r--    1 root     root     213319680 Oct 30 18:53 slackware91a.iso

Then I get these kernel messages:
hdd: DMA timeout error
hdd: dma timeout error: status=0xd0 { Busy }
hdd: DMA disabled
ide-scsi: abort called for 3653
bad: scheduling while atomic!
Call Trace:
 [<c0117652>] schedule+0x572/0x580
 [<c0117721>] __wake_up_common+0x31/0x50
 [<c01227dd>] __mod_timer+0xfd/0x170
 [<c012333e>] schedule_timeout+0x5e/0xb0
 [<c01232d0>] process_timeout+0x0/0x10
 [<c029665b>] idescsi_abort+0x9b/0x100
 [<c028f502>] scsi_try_to_abort_cmd+0x62/0x80
 [<c028f630>] scsi_eh_abort_cmds+0x40/0x80
 [<c0290023>] scsi_unjam_host+0xa3/0xd0
 [<c029012a>] scsi_error_handler+0xda/0x120
 [<c0290050>] scsi_error_handler+0x0/0x120
 [<c0107349>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c0117652>] schedule+0x572/0x580
 [<c012333e>] schedule_timeout+0x5e/0xb0
 [<c01232d0>] process_timeout+0x0/0x10
 [<c029665b>] idescsi_abort+0x9b/0x100
 [<c028f502>] scsi_try_to_abort_cmd+0x62/0x80
 [<c028f630>] scsi_eh_abort_cmds+0x40/0x80
 [<c0290023>] scsi_unjam_host+0xa3/0xd0
 [<c029012a>] scsi_error_handler+0xda/0x120
 [<c0290050>] scsi_error_handler+0x0/0x120
 [<c0107349>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c0117652>] schedule+0x572/0x580
 [<c012333e>] schedule_timeout+0x5e/0xb0
 [<c01232d0>] process_timeout+0x0/0x10
 [<c029665b>] idescsi_abort+0x9b/0x100
 [<c028f502>] scsi_try_to_abort_cmd+0x62/0x80
 [<c028f630>] scsi_eh_abort_cmds+0x40/0x80
 [<c0290023>] scsi_unjam_host+0xa3/0xd0
 [<c029012a>] scsi_error_handler+0xda/0x120
 [<c0290050>] scsi_error_handler+0x0/0x120
 [<c0107349>] kernel_thread_helper+0x5/0xc

...

hdd: ATAPI reset complete
hdd: irq timeout: status=0x80 { Busy }
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: drive not ready for command
ide-scsi: reset called for 3653
------------[ cut here ]------------
kernel BUG at drivers/scsi/ide-scsi.c:493!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c029587a>]    Not tainted
EFLAGS: 00010282
EIP is at idescsi_transfer_pc+0x9a/0x120
eax: c027de80   ebx: c04af5ac   ecx: 7aee12a0   edx: 00000172
esi: cd77c580   edi: cfd01fc0   ebp: cfd07e00   esp: cfd07ddc
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_0 (pid: 13, threadinfo=cfd06000 task=cfd440c0)
Stack: 00000172 c04af5ac 00000008 00000080 0000001e cfd01fc0 c04af5ac cfc6d680 
       00000000 cfd07e2c c027a327 c04af5ac cd77c580 00000000 00000000 0000001e 
       0000000f cfc6d680 c04af5ac c04af350 cfd07e58 c027a681 c04af5ac cfc6d680 
Call Trace:
 [<c027a327>] start_request+0x177/0x280
 [<c027a681>] ide_do_request+0x221/0x3f0
 [<c025dec7>] __elv_add_request+0x27/0x40
 [<c027aebe>] ide_do_drive_cmd+0xce/0x150
 [<c029614c>] idescsi_queue+0x1ec/0x660
 [<c01227dd>] __mod_timer+0xfd/0x170
 [<c028f196>] scsi_send_eh_cmnd+0xa6/0x190
 [<c028f0a0>] scsi_eh_done+0x0/0x50
 [<c028f070>] scsi_eh_times_out+0x0/0x30
 [<c028f5b4>] scsi_eh_tur+0x94/0xd0
 [<c028f7e9>] scsi_eh_bus_device_reset+0xe9/0x120
 [<c028fec8>] scsi_eh_ready_devs+0x28/0x70
 [<c0290040>] scsi_unjam_host+0xc0/0xd0
 [<c029012a>] scsi_error_handler+0xda/0x120
 [<c0290050>] scsi_error_handler+0x0/0x120
 [<c0107349>] kernel_thread_helper+0x5/0xc

Code: 0f 0b ed 01 f6 a6 3b c0 8b 56 38 a1 40 31 3f c0 89 d1 29 c1 
 hdd: ATAPI reset complete
hdd: status error: status=0x08 { DataRequest }
hdd: drive not ready for command
hdd: lost interrupt
hdd: lost interrupt
hdd: lost interrupt



I can't killall -9 the process, it seems to have frozen. This is all sickly
reminescent of 2.4's IDE system, which I thought (preyed) had been redone.
Why not use interruptible sleep instead?

Here's what's still in dmesg:
>[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Using anticipatory io scheduler
floppy0: no floppy controllers found
loop: loaded (max 8 devices)
via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xe400, 00:50:8d:50:0b:7a, IRQ 11.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y160P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD1600BB-00DAA0, ATA DISK drive
hdd: ATAPI DVD-ROM, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
 hda: hda1 hda2
hdc: max request size: 1024KiB
hdc: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, UDMA(100)
 hdc: hdc1 hdc2
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: ATAPI     Model: DVD-ROM STAR2000  Rev: 2,12
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 44x/44x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: irq 5, pci mem d085c000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: irq 11, io base 0000d400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: irq 12, io base 0000d800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: irq 10, io base 0000dc00
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003
 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  #0: C-Media PCI CMI8738 (model 37) at 0xd000, irq 12
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not su
pported: rc=-22
UDF-fs DEBUG fs/udf/super.c:1544:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:532:udf_vrs: Starting at sector 16 (2048 byte sector
s)
UDF-fs: No VRS found
VFS: Mounted root (jfs filesystem) readonly.
Freeing unused kernel memory: 136k freed
hub 2-0:1.0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.0
-1
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.


Hope this is of some use.

-Dave
