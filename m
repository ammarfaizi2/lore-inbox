Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267360AbUHRGAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUHRGAV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 02:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268648AbUHRGAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 02:00:21 -0400
Received: from web61204.mail.yahoo.com ([216.155.196.128]:45503 "HELO
	web61204.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267360AbUHRF7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 01:59:44 -0400
Message-ID: <20040818055944.56673.qmail@web61204.mail.yahoo.com>
Date: Tue, 17 Aug 2004 22:59:44 -0700 (PDT)
From: Rastislav Stanik <rs_kernel@yahoo.com>
Subject: problem mounting vfat USB flash disk (usb mass storage) under 2.6.8.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since upgrading from (vanilla) 2.6.7 to 2.6.8.1 I have
problem mounting my USB flashdisk:

# mount -t vfat  /dev/sdb1 /mnt/usb
mount: /dev/sdb1: can't read superblock

I wrote a small program that attempts to do the same
via mount(2) system call:

int ok=mount("/dev/sdb1","/mnt/usb","vfat",0,NULL);

which returns -1, errno is set to 5 (Input/output
error).
The same disk can be mounted as loopback filesystem
with:

mount -t vfat -o loop /dev/sdb1 /mnt/usb

or can be also mounted if formated using ext2
filesystem.

Therefore I believe that it is not problem of HW. I've
found some posts indicating that a simillar problem
has been recently reported here:
http://bugzilla.kernel.org/show_bug.cgi?id=2092

I have usb_uhci, usb-storage compiled as modules.
Here is the output of lsusb -v, /proc/bus/usb/devices
and /var/log/debug (dmesg):

# lsusb -v
Bus 002 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.8.1 uhci_hcd
  iProduct                2 VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller (#2)
  iSerial                 1 0000:00:07.3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 003: ID 0ea0:6828 Seitec USB BAR 128MB
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 Interface
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0ea0 Seitec
  idProduct          0x6828 USB BAR 128MB
  bcdDevice            1.10
  iManufacturer           1 USB
  iProduct                2 Flash Disk
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.8.1 uhci_hcd
  iProduct                2 VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller
  iSerial                 1 0000:00:07.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

# cat /proc/bus/usb/devices


T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1
Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8
#Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.8.1 uhci_hcd
S:  Product=VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (#2)
S:  SerialNumber=0000:00:07.3
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00
Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1
Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8
#Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.8.1 uhci_hcd
S:  Product=VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller
S:  SerialNumber=0000:00:07.2
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00
Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3
Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64
#Cfgs=  1
P:  Vendor=0ea0 ProdID=6828 Rev= 1.10
S:  Manufacturer=USB
S:  Product=Flash Disk
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=06 Prot=50
Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

# cat /var/log/debug
Aug 17 21:30:01 ras kernel: usb-storage: queuecommand
called
Aug 17 21:30:01 ras kernel: usb-storage: *** thread
awakened.
Aug 17 21:30:01 ras kernel: usb-storage: Command
TEST_UNIT_READY (6 bytes)
Aug 17 21:30:01 ras kernel: usb-storage:  00 00 00 00
00 00
Aug 17 21:30:01 ras kernel: usb-storage: Bulk Command
S 0x43425355 T 0x2ed L 0 F 0 Trg 0 LUN 0 CL 6
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 31/31
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk command
transfer result=0
Aug 17 21:30:01 ras kernel: usb-storage: Attempting to
get CSW...
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 13/13
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk status
result = 0
Aug 17 21:30:01 ras kernel: usb-storage: Bulk Status S
0x53425355 T 0x2ed R 0 Stat 0x0
Aug 17 21:30:01 ras kernel: usb-storage: scsi cmd
done, result=0x0
Aug 17 21:30:01 ras kernel: usb-storage: *** thread
sleeping.
Aug 17 21:30:01 ras kernel: usb-storage: queuecommand
called
Aug 17 21:30:01 ras kernel: usb-storage: *** thread
awakened.
Aug 17 21:30:01 ras kernel: usb-storage: Command
READ_10 (10 bytes)
Aug 17 21:30:01 ras kernel: usb-storage:  28 00 00 00
00 20 00 00 01 00
Aug 17 21:30:01 ras kernel: usb-storage: Bulk Command
S 0x43425355 T 0x2ee L 512 F 128 Trg 0 LUN 0 CL 10
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 31/31
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk command
transfer result=0
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1
entries
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 512/512
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk data
transfer result 0x0
Aug 17 21:30:01 ras kernel: usb-storage: Attempting to
get CSW...
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 13/13
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk status
result = 0
Aug 17 21:30:01 ras kernel: usb-storage: Bulk Status S
0x53425355 T 0x2ee R 512 Stat 0x0
Aug 17 21:30:01 ras kernel: usb-storage: --
unexpectedly short transfer
Aug 17 21:30:01 ras kernel: usb-storage: scsi cmd
done, result=0x10070000
Aug 17 21:30:01 ras kernel: usb-storage: *** thread
sleeping.
Aug 17 21:30:01 ras kernel: usb-storage: queuecommand
called
Aug 17 21:30:01 ras kernel: usb-storage: *** thread
awakened.
Aug 17 21:30:01 ras kernel: usb-storage: Command
READ_10 (10 bytes)
Aug 17 21:30:01 ras kernel: usb-storage:  28 00 00 00
00 20 00 00 01 00
Aug 17 21:30:01 ras kernel: usb-storage: Bulk Command
S 0x43425355 T 0x2ef L 512 F 128 Trg 0 LUN 0 CL 10
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 31/31
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk command
transfer result=0
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1
entries
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 512/512
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk data
transfer result 0x0
Aug 17 21:30:01 ras kernel: usb-storage: Attempting to
get CSW...
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 13/13
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk status
result = 0
Aug 17 21:30:01 ras kernel: usb-storage: Bulk Status S
0x53425355 T 0x2ef R 512 Stat 0x0
Aug 17 21:30:01 ras kernel: usb-storage: --
unexpectedly short transfer
Aug 17 21:30:01 ras kernel: usb-storage: scsi cmd
done, result=0x10070000
Aug 17 21:30:01 ras kernel: usb-storage: *** thread
sleeping.
Aug 17 21:30:01 ras kernel: usb-storage: queuecommand
called
Aug 17 21:30:01 ras kernel: usb-storage: *** thread
awakened.
Aug 17 21:30:01 ras kernel: usb-storage: Command
READ_10 (10 bytes)
Aug 17 21:30:01 ras kernel: usb-storage:  28 00 00 00
00 20 00 00 01 00
Aug 17 21:30:01 ras kernel: usb-storage: Bulk Command
S 0x43425355 T 0x2f0 L 512 F 128 Trg 0 LUN 0 CL 10
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 31/31
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk command
transfer result=0
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1
entries
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 512/512
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk data
transfer result 0x0
Aug 17 21:30:01 ras kernel: usb-storage: Attempting to
get CSW...
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 13/13
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk status
result = 0
Aug 17 21:30:01 ras kernel: usb-storage: Bulk Status S
0x53425355 T 0x2f0 R 512 Stat 0x0
Aug 17 21:30:01 ras kernel: usb-storage: --
unexpectedly short transfer
Aug 17 21:30:01 ras kernel: usb-storage: scsi cmd
done, result=0x10070000
Aug 17 21:30:01 ras kernel: usb-storage: *** thread
sleeping.
Aug 17 21:30:01 ras kernel: usb-storage: queuecommand
called
Aug 17 21:30:01 ras kernel: usb-storage: *** thread
awakened.
Aug 17 21:30:01 ras kernel: usb-storage: Command
READ_10 (10 bytes)
Aug 17 21:30:01 ras kernel: usb-storage:  28 00 00 00
00 20 00 00 01 00
Aug 17 21:30:01 ras kernel: usb-storage: Bulk Command
S 0x43425355 T 0x2f1 L 512 F 128 Trg 0 LUN 0 CL 10
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 31/31
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk command
transfer result=0
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1
entries
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 512/512
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk data
transfer result 0x0
Aug 17 21:30:01 ras kernel: usb-storage: Attempting to
get CSW...
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 13/13
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk status
result = 0
Aug 17 21:30:01 ras kernel: usb-storage: Bulk Status S
0x53425355 T 0x2f1 R 512 Stat 0x0
Aug 17 21:30:01 ras kernel: usb-storage: --
unexpectedly short transfer
Aug 17 21:30:01 ras kernel: usb-storage: scsi cmd
done, result=0x10070000
Aug 17 21:30:01 ras kernel: usb-storage: *** thread
sleeping.
Aug 17 21:30:01 ras kernel: usb-storage: queuecommand
called
Aug 17 21:30:01 ras kernel: usb-storage: *** thread
awakened.
Aug 17 21:30:01 ras kernel: usb-storage: Command
READ_10 (10 bytes)
Aug 17 21:30:01 ras kernel: usb-storage:  28 00 00 00
00 20 00 00 01 00
Aug 17 21:30:01 ras kernel: usb-storage: Bulk Command
S 0x43425355 T 0x2f2 L 512 F 128 Trg 0 LUN 0 CL 10
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 31/31
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk command
transfer result=0
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1
entries
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 512/512
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk data
transfer result 0x0
Aug 17 21:30:01 ras kernel: usb-storage: Attempting to
get CSW...
Aug 17 21:30:01 ras kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Aug 17 21:30:01 ras kernel: usb-storage: Status code
0; transferred 13/13
Aug 17 21:30:01 ras kernel: usb-storage: -- transfer
complete
Aug 17 21:30:01 ras kernel: usb-storage: Bulk status
result = 0
Aug 17 21:30:01 ras kernel: usb-storage: Bulk Status S
0x53425355 T 0x2f2 R 512 Stat 0x0
Aug 17 21:30:01 ras kernel: usb-storage: --
unexpectedly short transfer
Aug 17 21:30:01 ras kernel: usb-storage: scsi cmd
done, result=0x10070000
Aug 17 21:30:01 ras kernel: usb-storage: *** thread
sleeping.
--
       bye
                rastos


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
