Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbTJYDsf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 23:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTJYDse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 23:48:34 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:253 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262240AbTJYDs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 23:48:29 -0400
Message-ID: <3F99F234.706@jtholmes.com>
Date: Fri, 24 Oct 2003 23:47:00 -0400
From: devel <devel@jtholmes.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8 mkfs forces kernel into hard loop; then unusable
Content-Type: multipart/mixed;
 boundary="------------080900000105070406020206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080900000105070406020206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I dont take the lkml feed, just answer here and I will see the
answer or email me at
devel@jtholmes.com

The problem:

using mkfs on an external Usb 2.0 Drive enclosure via a
Pcmcia  NEC 2.0 Usb Card causes kernel into hard
loop and I have to power down to regain access.

Details

Nec  Pcmcia card w/two USB hubs
Generic Usb 2.0 drive enclosure
Toshiba 20G  hard drive in the enclosure

lsmod  attached
lsscsi  attached
lspci  attached

What I execute

mkfs -t ext3  /dev/sdb2

  it completes the following
Writing of Inode table
Creating Journal
gets to Writing super blocks  takes 3-5 min
and then fails with the following similar msgs
similar because I cannot capture them as they fly
by too fast

Msg1
Buffer I/O write error on  sbd2
Msg2
..... due to I/O error  (mostly unreadable)

However,

turn on scsi logging with sysctl and run

mkfs -t ext3  /dev/sdb2

and it eventually completes with lots
of errors in  dmesg and   /var/log/messages
and after the  mkfs w/scsi logging the device
appears to be useable but I dont trust integrity.

There are tons of data on this one so if J. Bottomley or
who ever would contact me I will supply and that way
they can be selective and we can keep from clogging up
the lkml.

I have included a file named snipit with a few of the
error msgs that are occuring

thanks in advance
jt



--------------080900000105070406020206
Content-Type: text/plain;
 name="lsmod"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsmod"

Module                  Size  Used by
ide_cd                 34528  1 
cdrom                  30144  1 ide_cd
nfs                    59944  0 
nfsd                   61312  0 
exportfs                4768  1 nfsd
lockd                  47520  2 nfs,nfsd
sunrpc                109792  3 nfs,nfsd,lockd
3c59x                  34184  0 
vfat                   10912  0 
msdos                   7616  0 
fat                    38112  2 vfat,msdos
scsi_debug             32256  0 
sd_mod                 12992  0 
usb_storage            36608  0 
scsi_mod               68772  3 scsi_debug,sd_mod,usb_storage
ehci_hcd               29248  0 
usbmouse                4128  0 
uhci_hcd               26664  0 
pci_hotplug             8740  0 
binfmt_misc             7976  1 
ds                     10400  8 
yenta_socket           13152  2 
pcmcia_core            55072  2 ds,yenta_socket
parport_pc             22568  0 
parport                35232  1 parport_pc
usbcore                97076  6 usb_storage,ehci_hcd,usbmouse,uhci_hcd

--------------080900000105070406020206
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:05.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:05.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:05.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:05.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:07.0 Communication controller: Lucent Microelectronics 56k WinModem (rev 01)
00:09.0 IRDA controller: Toshiba America Info Systems FIR Port Type-DO
00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 20)
00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 20)
00:0c.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio Controller] (rev 02)
01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/MX-MV (rev 11)
02:00.0 Ethernet controller: 3Com Corporation 3CCFE575CT Cyclone CardBus (rev 10)
06:00.0 USB Controller: NEC Corporation USB (rev 41)
06:00.1 USB Controller: NEC Corporation USB (rev 41)
06:00.2 USB Controller: NEC Corporation USB 2.0 (rev 02)

--------------080900000105070406020206
Content-Type: text/plain;
 name="lsscsi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsscsi"

[0:0:0:0]    disk    Linux    scsi_debug       0004  /dev/sda
[1:0:0:0]    disk    USB 2.0  Storage Device   0100  /dev/sdb

--------------080900000105070406020206
Content-Type: text/plain;
 name="snipit"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snipit"

usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x158 R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x80000158 L 18 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code -32; transferred 0/18
usb-storage: clearing endpoint halt for pipe 0xc0008280
usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=81 len=0
usb-storage: usb_stor_clear_halt: result = 0
usb-storage: Bulk data transfer result 0x2
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x80000158 R 0 Stat 0x2
usb-storage: -- auto-sense failure
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 512000 bytes, 125 entries
usb-storage: Status code 0; transferred 512000/512000
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: command_abort called
usb-storage: usb_stor_stop_transport called
usb-storage: -- cancelling URB
usb-storage: Status code -104; transferred 0/13
usb-storage: -- transfer cancelled
usb-storage: Bulk status result = 4
usb-storage: -- command was aborted
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0

--------------080900000105070406020206--

