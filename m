Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbVHZIM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbVHZIM5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 04:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbVHZIM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 04:12:57 -0400
Received: from node1.80686-net.de ([194.54.168.119]:2196 "EHLO
	mx1.80686-net.de") by vger.kernel.org with ESMTP id S965056AbVHZIMz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 04:12:55 -0400
From: Manuel Schneider <root@80686-net.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Question about usb-storage: Sometimes partitions are not recognized.
Date: Fri, 26 Aug 2005 10:12:47 +0200
User-Agent: KMail/1.8
References: <mailman.1124977260.20356.linux-kernel2news@redhat.com> <20050825122126.47fe659b.zaitcev@redhat.com>
In-Reply-To: <20050825122126.47fe659b.zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, kristoff.meller@gmx.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508261012.47792.root@80686-net.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> We need more data. First, "Kernel 2.6.x" is not good enough.
In this case it's 2.6.11 (x86_64) and 2.6.12 (x86) but I experience that 
problem since longer time (with several Kernel versions).

> Give us a precise version on which you observe this.
> Second, running with CONFIG_USB_STORAGE_DEBUG may yield a useful trace.
The attached logs are generated on 
Linux mirabilis 2.6.11-gentoo-r7 #1 Fri May 27 19:37:20 CEST 2005 x86_64 AMD 
Athlon(tm) 64 Processor 3200+ AuthenticAMD GNU/Linux

This is the device (from /proc/bus/sub/devices):
T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=16 #Cfgs=  1
P:  Vendor=1019 ProdID=0c55 Rev= 1.00
S:  Manufacturer=Generic
S:  Product=USB Storage Device
S:  SerialNumber=20020509145305401
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms


Here the log when pluging in the cardreader (without memory card):
[...]
Aug 26 09:58:45 mirabilis kernel: usb 2-2: new full speed USB device using 
uhci_hcd and address 2
Aug 26 09:58:46 mirabilis kernel: SCSI subsystem initialized
Aug 26 09:58:46 mirabilis kernel: Initializing USB Mass Storage driver...
Aug 26 09:58:46 mirabilis kernel: usb-storage: USB Mass Storage device 
detected
Aug 26 09:58:46 mirabilis kernel: usb-storage: -- associate_dev
Aug 26 09:58:46 mirabilis kernel: usb-storage: Vendor: 0x1019, Product: 
0x0c55, Revision: 0x0100
Aug 26 09:58:46 mirabilis kernel: usb-storage: Interface Subclass: 0x06, 
Protocol: 0x50
Aug 26 09:58:46 mirabilis kernel: usb-storage: Vendor: Generic ,  Product: USB 
Storage Device
Aug 26 09:58:46 mirabilis kernel: usb-storage: Transport: Bulk
Aug 26 09:58:46 mirabilis kernel: usb-storage: Protocol: Transparent SCSI
Aug 26 09:58:46 mirabilis kernel: usb-storage: usb_stor_control_msg: rq=fe 
rqtype=a1 value=0000 index=00 len=1
Aug 26 09:58:46 mirabilis kernel: usb-storage: GetMaxLUN command result is 1, 
data is 3
Aug 26 09:58:46 mirabilis kernel: usb-storage: Sending UCR-61S2B 
initialization packet...
Aug 26 09:58:46 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 09:58:46 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 09:58:46 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:46 mirabilis kernel: usb-storage: Getting status packet...
Aug 26 09:58:46 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 09:58:46 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 09:58:46 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:46 mirabilis kernel: scsi0 : SCSI emulation for USB Mass Storage 
devices
Aug 26 09:58:46 mirabilis kernel: usbcore: registered new driver usb-storage
Aug 26 09:58:46 mirabilis kernel: USB Mass Storage support registered.
Aug 26 09:58:46 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 09:58:46 mirabilis kernel: usb-storage: device found at 2
Aug 26 09:58:46 mirabilis kernel: usb-storage: waiting for device to settle 
before scanning
Aug 26 09:58:51 mirabilis kernel: usb-storage: queuecommand called
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 09:58:51 mirabilis kernel: usb-storage: Command INQUIRY (6 bytes)
Aug 26 09:58:51 mirabilis kernel: usb-storage:  12 00 00 00 24 00
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 0x1 
L 36 F 128 Trg 0 LUN 0 CL 6
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 36 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
36/36
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 0x1 
R 0 Stat 0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 09:58:51 mirabilis kernel:   Vendor: IC        Model: USB Storage-CFC   
Rev: 301b
Aug 26 09:58:51 mirabilis kernel:   Type:   Direct-Access                      
ANSI SCSI revision: 00
Aug 26 09:58:51 mirabilis kernel: usb-storage: queuecommand called
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bad target number (1:0)
Aug 26 09:58:51 mirabilis kernel: usb-storage: scsi cmd done, result=0x40000
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 09:58:51 mirabilis kernel: usb-storage: queuecommand called
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bad target number (2:0)
Aug 26 09:58:51 mirabilis kernel: usb-storage: scsi cmd done, result=0x40000
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 09:58:51 mirabilis kernel: usb-storage: queuecommand called
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bad target number (3:0)
Aug 26 09:58:51 mirabilis kernel: usb-storage: scsi cmd done, result=0x40000
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 09:58:51 mirabilis kernel: usb-storage: queuecommand called
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bad target number (4:0)
Aug 26 09:58:51 mirabilis kernel: usb-storage: scsi cmd done, result=0x40000
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 09:58:51 mirabilis kernel: usb-storage: queuecommand called
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bad target number (5:0)
Aug 26 09:58:51 mirabilis kernel: usb-storage: scsi cmd done, result=0x40000
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 09:58:51 mirabilis kernel: usb-storage: queuecommand called
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bad target number (6:0)
Aug 26 09:58:51 mirabilis kernel: usb-storage: scsi cmd done, result=0x40000
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 09:58:51 mirabilis kernel: usb-storage: queuecommand called
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bad target number (7:0)
Aug 26 09:58:51 mirabilis kernel: usb-storage: scsi cmd done, result=0x40000
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 09:58:51 mirabilis kernel: usb-storage: device scan complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: queuecommand called
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 09:58:51 mirabilis kernel: usb-storage: Command TEST_UNIT_READY (6 
bytes)
Aug 26 09:58:51 mirabilis kernel: usb-storage:  00 00 00 00 00 00
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 0x9 
L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 0x9 
R 0 Stat 0x1
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transport indicates command 
failure
Aug 26 09:58:51 mirabilis kernel: usb-storage: Issuing auto-REQUEST_SENSE
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x80000009 L 18 F 128 Trg 0 LUN 0 CL 6
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 18 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
18/18
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x80000009 R 0 Stat 0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- Result from auto-sense is 0
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 
0x3a, ASCQ: 0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: (Unknown Key): (unknown 
ASC/ASCQ)
Aug 26 09:58:51 mirabilis kernel: usb-storage: scsi cmd done, result=0x2
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 09:58:51 mirabilis kernel: usb-storage: queuecommand called
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 09:58:51 mirabilis kernel: usb-storage: Command TEST_UNIT_READY (6 
bytes)
Aug 26 09:58:51 mirabilis kernel: usb-storage:  00 00 00 00 00 00
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 0xa 
L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 0xa 
R 0 Stat 0x1
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transport indicates command 
failure
Aug 26 09:58:51 mirabilis kernel: usb-storage: Issuing auto-REQUEST_SENSE
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x8000000a L 18 F 128 Trg 0 LUN 0 CL 6
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 18 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
18/18
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x8000000a R 0 Stat 0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- Result from auto-sense is 0
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 
0x3a, ASCQ: 0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: (Unknown Key): (unknown 
ASC/ASCQ)
Aug 26 09:58:51 mirabilis kernel: usb-storage: scsi cmd done, result=0x2
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 09:58:51 mirabilis kernel: usb-storage: queuecommand called
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 09:58:51 mirabilis kernel: usb-storage: Command TEST_UNIT_READY (6 
bytes)
Aug 26 09:58:51 mirabilis kernel: usb-storage:  00 00 00 00 00 00
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 0xb 
L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 0xb 
R 0 Stat 0x1
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transport indicates command 
failure
Aug 26 09:58:51 mirabilis kernel: usb-storage: Issuing auto-REQUEST_SENSE
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x8000000b L 18 F 128 Trg 0 LUN 0 CL 6
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 18 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
18/18
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x8000000b R 0 Stat 0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- Result from auto-sense is 0
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 
0x3a, ASCQ: 0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: (Unknown Key): (unknown 
ASC/ASCQ)
Aug 26 09:58:51 mirabilis kernel: usb-storage: scsi cmd done, result=0x2
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 09:58:51 mirabilis kernel: Attached scsi removable disk sda at scsi0, 
channel 0, id 0, lun 0
Aug 26 09:58:51 mirabilis kernel: usb-storage: queuecommand called
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 09:58:51 mirabilis kernel: usb-storage: Command TEST_UNIT_READY (6 
bytes)
Aug 26 09:58:51 mirabilis kernel: usb-storage:  00 00 00 00 00 00
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 0xc 
L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 0xc 
R 0 Stat 0x1
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transport indicates command 
failure
Aug 26 09:58:51 mirabilis kernel: usb-storage: Issuing auto-REQUEST_SENSE
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x8000000c L 18 F 128 Trg 0 LUN 0 CL 6
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 18 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
18/18
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 09:58:51 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 09:58:51 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 09:58:51 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x8000000c R 0 Stat 0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- Result from auto-sense is 0
Aug 26 09:58:51 mirabilis kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 
0x3a, ASCQ: 0x0
Aug 26 09:58:51 mirabilis kernel: usb-storage: (Unknown Key): (unknown 
ASC/ASCQ)
Aug 26 09:58:51 mirabilis kernel: usb-storage: scsi cmd done, result=0x2
Aug 26 09:58:51 mirabilis kernel: usb-storage: *** thread sleeping.

[...]

When pluging in a memory card (compact flash, in this case):
Aug 26 10:07:37 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:37 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:37 mirabilis kernel: usb-storage: Command TEST_UNIT_READY (6 
bytes)
Aug 26 10:07:37 mirabilis kernel: usb-storage:  00 00 00 00 00 00
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x434 L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x434 R 0 Stat 0x1
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transport indicates command 
failure
Aug 26 10:07:37 mirabilis kernel: usb-storage: Issuing auto-REQUEST_SENSE
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x80000434 L 18 F 128 Trg 0 LUN 0 CL 6
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 18 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
18/18
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x80000434 R 0 Stat 0x0
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- Result from auto-sense is 0
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 
0x3a, ASCQ: 0x0
Aug 26 10:07:37 mirabilis kernel: usb-storage: (Unknown Key): (unknown 
ASC/ASCQ)
Aug 26 10:07:37 mirabilis kernel: usb-storage: scsi cmd done, result=0x2
Aug 26 10:07:37 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:37 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:37 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:37 mirabilis kernel: usb-storage: Command TEST_UNIT_READY (6 
bytes)
Aug 26 10:07:37 mirabilis kernel: usb-storage:  00 00 00 00 00 00
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x435 L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x435 R 0 Stat 0x1
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transport indicates command 
failure
Aug 26 10:07:37 mirabilis kernel: usb-storage: Issuing auto-REQUEST_SENSE
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x80000435 L 18 F 128 Trg 0 LUN 0 CL 6
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 18 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
18/18
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x80000435 R 0 Stat 0x0
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- Result from auto-sense is 0
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 
0x3a, ASCQ: 0x0
Aug 26 10:07:37 mirabilis kernel: usb-storage: (Unknown Key): (unknown 
ASC/ASCQ)
Aug 26 10:07:37 mirabilis kernel: usb-storage: scsi cmd done, result=0x2
Aug 26 10:07:37 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:37 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:37 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:37 mirabilis kernel: usb-storage: Command TEST_UNIT_READY (6 
bytes)
Aug 26 10:07:37 mirabilis kernel: usb-storage:  00 00 00 00 00 00
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x436 L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x436 R 0 Stat 0x1
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transport indicates command 
failure
Aug 26 10:07:37 mirabilis kernel: usb-storage: Issuing auto-REQUEST_SENSE
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x80000436 L 18 F 128 Trg 0 LUN 0 CL 6
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 18 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
18/18
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x80000436 R 0 Stat 0x0
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- Result from auto-sense is 0
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 
0x3a, ASCQ: 0x0
Aug 26 10:07:37 mirabilis kernel: usb-storage: (Unknown Key): (unknown 
ASC/ASCQ)
Aug 26 10:07:37 mirabilis kernel: usb-storage: scsi cmd done, result=0x2
Aug 26 10:07:37 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:37 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:37 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:37 mirabilis kernel: usb-storage: Command TEST_UNIT_READY (6 
bytes)
Aug 26 10:07:37 mirabilis kernel: usb-storage:  00 00 00 00 00 00
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x437 L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x437 R 0 Stat 0x1
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transport indicates command 
failure
Aug 26 10:07:37 mirabilis kernel: usb-storage: Issuing auto-REQUEST_SENSE
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x80000437 L 18 F 128 Trg 0 LUN 0 CL 6
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 18 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
18/18
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:37 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:37 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:37 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x80000437 R 0 Stat 0x0
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- Result from auto-sense is 0
Aug 26 10:07:37 mirabilis kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 
0x3a, ASCQ: 0x0
Aug 26 10:07:37 mirabilis kernel: usb-storage: (Unknown Key): (unknown 
ASC/ASCQ)
Aug 26 10:07:37 mirabilis kernel: usb-storage: scsi cmd done, result=0x2
Aug 26 10:07:37 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:39 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:39 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:39 mirabilis kernel: usb-storage: Command TEST_UNIT_READY (6 
bytes)
Aug 26 10:07:39 mirabilis kernel: usb-storage:  00 00 00 00 00 00
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x438 L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x438 R 0 Stat 0x1
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transport indicates command 
failure
Aug 26 10:07:39 mirabilis kernel: usb-storage: Issuing auto-REQUEST_SENSE
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x80000438 L 18 F 128 Trg 0 LUN 0 CL 6
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 18 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
18/18
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x80000438 R 0 Stat 0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- Result from auto-sense is 0
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- code: 0x70, key: 0x6, ASC: 
0x28, ASCQ: 0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: (Unknown Key): (unknown 
ASC/ASCQ)
Aug 26 10:07:39 mirabilis kernel: usb-storage: scsi cmd done, result=0x2
Aug 26 10:07:39 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:39 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:39 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:39 mirabilis kernel: usb-storage: Command TEST_UNIT_READY (6 
bytes)
Aug 26 10:07:39 mirabilis kernel: usb-storage:  00 00 00 00 00 00
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x439 L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x439 R 0 Stat 0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:39 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:39 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:39 mirabilis kernel: usb-storage: Command READ_CAPACITY (10 
bytes)
Aug 26 10:07:39 mirabilis kernel: usb-storage:  25 00 00 00 00 00 00 00 00 00
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x43a L 8 F 128 Trg 0 LUN 0 CL 10
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 8 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 8/8
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x43a R 0 Stat 0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:39 mirabilis kernel: SCSI device sda: 126464 512-byte hdwr 
sectors (65 MB)
Aug 26 10:07:39 mirabilis kernel: sda: assuming Write Enabled
Aug 26 10:07:39 mirabilis kernel: sda: assuming drive cache: write through
Aug 26 10:07:39 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:39 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:39 mirabilis kernel: usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 
bytes)
Aug 26 10:07:39 mirabilis kernel: usb-storage:  1e 00 00 00 01 00
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x43b L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x43b R 0 Stat 0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:39 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:39 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:39 mirabilis kernel: usb-storage: Command TEST_UNIT_READY (6 
bytes)
Aug 26 10:07:39 mirabilis kernel: usb-storage:  00 00 00 00 00 00
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x43c L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x43c R 0 Stat 0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:39 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:39 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:39 mirabilis kernel: usb-storage: Command READ_CAPACITY (10 
bytes)
Aug 26 10:07:39 mirabilis kernel: usb-storage:  25 00 00 00 00 00 00 00 00 00
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x43d L 8 F 128 Trg 0 LUN 0 CL 10
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 8 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 8/8
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x43d R 0 Stat 0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:39 mirabilis kernel: SCSI device sda: 126464 512-byte hdwr 
sectors (65 MB)
Aug 26 10:07:39 mirabilis kernel: sda: assuming Write Enabled
Aug 26 10:07:39 mirabilis kernel: sda: assuming drive cache: write through
Aug 26 10:07:39 mirabilis kernel:  sda:<7>usb-storage: queuecommand called
Aug 26 10:07:39 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:39 mirabilis kernel: usb-storage: Command READ_10 (10 bytes)
Aug 26 10:07:39 mirabilis kernel: usb-storage:  28 00 00 00 00 00 00 00 08 00
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x43e L 4096 F 128 Trg 0 LUN 0 CL 10
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_sglist: 
xfer 4096 bytes, 1 entries
Aug 26 10:07:39 mirabilis kernel: usb-storage: Status code 0; transferred 
4096/4096
Aug 26 10:07:39 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:39 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 10:07:39 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:39 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x43e R 0 Stat 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:40 mirabilis kernel:  sda1
Aug 26 10:07:40 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:40 mirabilis kernel: usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 
bytes)
Aug 26 10:07:40 mirabilis kernel: usb-storage:  1e 00 00 00 00 00
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x43f L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x43f R 0 Stat 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:40 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:40 mirabilis kernel: usb-storage: Command TEST_UNIT_READY (6 
bytes)
Aug 26 10:07:40 mirabilis kernel: usb-storage:  00 00 00 00 00 00
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x440 L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x440 R 0 Stat 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:40 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:40 mirabilis kernel: usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 
bytes)
Aug 26 10:07:40 mirabilis kernel: usb-storage:  1e 00 00 00 01 00
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x441 L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x441 R 0 Stat 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:40 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:40 mirabilis kernel: usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 
bytes)
Aug 26 10:07:40 mirabilis kernel: usb-storage:  1e 00 00 00 00 00
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x442 L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x442 R 0 Stat 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:40 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:40 mirabilis kernel: usb-storage: Command TEST_UNIT_READY (6 
bytes)
Aug 26 10:07:40 mirabilis kernel: usb-storage:  00 00 00 00 00 00
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x443 L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x443 R 0 Stat 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:40 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:40 mirabilis kernel: usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 
bytes)
Aug 26 10:07:40 mirabilis kernel: usb-storage:  1e 00 00 00 01 00
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x444 L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x444 R 0 Stat 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:40 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:40 mirabilis kernel: usb-storage: Command READ_10 (10 bytes)
Aug 26 10:07:40 mirabilis kernel: usb-storage:  28 00 00 00 00 00 00 00 40 00
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x445 L 32768 F 128 Trg 0 LUN 0 CL 10
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_sglist: 
xfer 32768 bytes, 8 entries
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
32768/32768
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x445 R 0 Stat 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:40 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:40 mirabilis kernel: usb-storage: Command READ_10 (10 bytes)
Aug 26 10:07:40 mirabilis kernel: usb-storage:  28 00 00 00 00 40 00 00 48 00
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x446 L 36864 F 128 Trg 0 LUN 0 CL 10
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_sglist: 
xfer 36864 bytes, 9 entries
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
36864/36864
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x446 R 0 Stat 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:40 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:40 mirabilis kernel: usb-storage: Command READ_10 (10 bytes)
Aug 26 10:07:40 mirabilis kernel: usb-storage:  28 00 00 00 02 00 00 00 08 00
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x447 L 4096 F 128 Trg 0 LUN 0 CL 10
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_sglist: 
xfer 4096 bytes, 1 entries
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
4096/4096
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk data transfer result 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x447 R 0 Stat 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:40 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:40 mirabilis kernel: usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 
bytes)
Aug 26 10:07:40 mirabilis kernel: usb-storage:  1e 00 00 00 00 00
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x448 L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x448 R 0 Stat 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:40 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:40 mirabilis kernel: usb-storage: Command TEST_UNIT_READY (6 
bytes)
Aug 26 10:07:40 mirabilis kernel: usb-storage:  00 00 00 00 00 00
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x449 L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk command transfer result=0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Attempting to get CSW...
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
13/13
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk status result = 0
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Status S 0x53425355 T 
0x449 R 0 Stat 0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: scsi cmd done, result=0x0
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread sleeping.
Aug 26 10:07:40 mirabilis kernel: usb-storage: queuecommand called
Aug 26 10:07:40 mirabilis kernel: usb-storage: *** thread awakened.
Aug 26 10:07:40 mirabilis kernel: usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 
bytes)
Aug 26 10:07:40 mirabilis kernel: usb-storage:  1e 00 00 00 01 00
Aug 26 10:07:40 mirabilis kernel: usb-storage: Bulk Command S 0x43425355 T 
0x44a L 0 F 0 Trg 0 LUN 0 CL 6
Aug 26 10:07:40 mirabilis kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Aug 26 10:07:40 mirabilis kernel: usb-storage: Status code 0; transferred 
31/31
Aug 26 10:07:40 mirabilis kernel: usb-storage: -- transfer complete    

[...]                                                                                                                            
> I am not quite sure about that though, as this seems to be some
> misunderstanding between the block level and SCSI.
>
> Problems with block device open() not working right fall squarely
> into purview of Al Viro, but he's quite busy right now. Someone
> has to identify the exact scenario. I suppose adding a few printks
> around fs/block_dev.c may be more beneficial than any USB debugging.
If useful I could create the same output on the other machine with Kernel 
2.6.11 another cardreader but the same problem.

Greets,

Manuel

-- 
Manuel Schneider
root@80686-net.de
http://www.80686-net.de/

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GCM d-- s:- a? C++$ UL++++ P+> L+++>$ E- W+++$ N+ o-- K- w--$ O+ M+ V
PS+ PE- Y+ PGP+ t 5 X R UF++++ !tv b+> DI D+ G+ e> h r y++ 
------END GEEK CODE BLOCK------
