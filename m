Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbUCRNi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 08:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUCRNi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 08:38:56 -0500
Received: from main.gmane.org ([80.91.224.249]:34707 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262642AbUCRNiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 08:38:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens@spamfreemail.de>
Subject: 2.6.5rc1bk2, 2.6.3, 2.6.0: USB HDD (sd_mod) spams my syslog + crashes
Date: Thu, 18 Mar 2004 14:27:02 +0100
Organization: University of the Armed Forces, Hamburg, Germany
Message-ID: <c3c836$8ts$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: get1431p4.unibw-hamburg.de
User-Agent: KNode/0.7.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an external HDD (200G) in a case that has both FW and USB2 outputs.
FW work great since 2.6.2, connecting the USB to a machine running 2.4.23
instantly rebooted the machine, and in 2.6 (currently 2.6.5rc1bk2) it
doesn't work either:  

I tried on a 3 year old P3-700 laptop with an Intel 8327something chipset,
and on a new P4 with a 
        00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
        00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
        00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
        00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 02)
chipset. Both don't work and both show the same behaviour.

Is this a problem in the USB controller, or the hardware, or Linux? The HDD
works with Windows XP on the Laptop.

This is detected during boot on the P4:

 drivers/usb/core/usb.c: registered new driver usbfs
 drivers/usb/core/usb.c: registered new driver hub
 ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
 PCI: Enabling device 0000:00:1d.7 (0004 -> 0006)
 ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB USB2
 ehci_hcd 0000:00:1d.7: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2
ordered !ppc ports=6
 ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit
addr
 ehci_hcd 0000:00:1d.7: capability 0001 at 68
 PCI: Setting latency timer of device 0000:00:1d.7 to 64
 ehci_hcd 0000:00:1d.7: irq 23, pci mem e19da000
 ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
 ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024
Reset HALT
 PCI: cache line size of 128 is not supported by device 0000:00:1d.7
 ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024
RUN
 ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
 ehci_hcd 0000:00:1d.7: root hub device address 1
 usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
 drivers/usb/core/message.c: USB device number 1 default language ID 0x409
 usb usb1: Product: Intel Corp. 82801DB USB2
 usb usb1: Manufacturer: Linux 2.6.5-rc1-bk2-p3 ehci_hcd
 usb usb1: SerialNumber: 0000:00:1d.7
 drivers/usb/core/usb.c: usb_hotplug
 usb usb1: registering 1-0:1.0 (config #1, interface 0)
 drivers/usb/core/usb.c: usb_hotplug
 hub 1-0:1.0: usb_probe_interface
 hub 1-0:1.0: usb_probe_interface - got id
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 6 ports detected
 hub 1-0:1.0: standalone hub
 hub 1-0:1.0: ganged power switching
 hub 1-0:1.0: individual port over-current protection
 hub 1-0:1.0: Single TT
 hub 1-0:1.0: TT requires at most 8 FS bit times
 hub 1-0:1.0: Port indicators are not supported
 hub 1-0:1.0: power on to power good time: 20ms
 hub 1-0:1.0: hub controller current requirement: 0mA
 hub 1-0:1.0: local power source is good
 hub 1-0:1.0: no over-current condition exists
 hub 1-0:1.0: enabling power on all ports
 ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
 ohci_hcd: block sizes: ed 64 td 64
 USB Universal Host Controller Interface driver v2.2
 uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB USB (Hub #1)
 PCI: Setting latency timer of device 0000:00:1d.0 to 64
 uhci_hcd 0000:00:1d.0: irq 16, io base 0000b800
 uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
 uhci_hcd 0000:00:1d.0: detected 2 ports
 uhci_hcd 0000:00:1d.0: root hub device address 1
 usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
 drivers/usb/core/message.c: USB device number 1 default language ID 0x409
 usb usb2: Product: Intel Corp. 82801DB USB (Hub #1)
 usb usb2: Manufacturer: Linux 2.6.5-rc1-bk2-p3 uhci_hcd
 usb usb2: SerialNumber: 0000:00:1d.0
 drivers/usb/core/usb.c: usb_hotplug
 usb usb2: registering 2-0:1.0 (config #1, interface 0)
 drivers/usb/core/usb.c: usb_hotplug
 hub 2-0:1.0: usb_probe_interface
 hub 2-0:1.0: usb_probe_interface - got id
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
 hub 2-0:1.0: standalone hub
 hub 2-0:1.0: unknown reserved power switching mode
 hub 2-0:1.0: individual port over-current protection
 hub 2-0:1.0: Port indicators are not supported
 hub 2-0:1.0: power on to power good time: 2ms
 hub 2-0:1.0: hub controller current requirement: 0mA
 hub 2-0:1.0: local power source is good
 hub 2-0:1.0: no over-current condition exists
 hub 2-0:1.0: enabling power on all ports
 uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB USB (Hub #2)
 PCI: Setting latency timer of device 0000:00:1d.1 to 64
 uhci_hcd 0000:00:1d.1: irq 19, io base 0000b400
 uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
 uhci_hcd 0000:00:1d.1: detected 2 ports
 uhci_hcd 0000:00:1d.1: root hub device address 1
 usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
 drivers/usb/core/message.c: USB device number 1 default language ID 0x409
 usb usb3: Product: Intel Corp. 82801DB USB (Hub #2)
 usb usb3: Manufacturer: Linux 2.6.5-rc1-bk2-p3 uhci_hcd
 usb usb3: SerialNumber: 0000:00:1d.1
 drivers/usb/core/usb.c: usb_hotplug
 usb usb3: registering 3-0:1.0 (config #1, interface 0)
 drivers/usb/core/usb.c: usb_hotplug
 hub 3-0:1.0: usb_probe_interface
 hub 3-0:1.0: usb_probe_interface - got id
 hub 3-0:1.0: USB hub found
 hub 3-0:1.0: 2 ports detected
 hub 3-0:1.0: standalone hub
 hub 3-0:1.0: unknown reserved power switching mode
 hub 3-0:1.0: individual port over-current protection
 hub 3-0:1.0: Port indicators are not supported
 hub 3-0:1.0: power on to power good time: 2ms
 hub 3-0:1.0: hub controller current requirement: 0mA
 hub 3-0:1.0: local power source is good
 hub 3-0:1.0: no over-current condition exists
 hub 3-0:1.0: enabling power on all ports
 uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB USB (Hub #3)
 PCI: Setting latency timer of device 0000:00:1d.2 to 64
 uhci_hcd 0000:00:1d.2: irq 18, io base 0000b000
 uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
 uhci_hcd 0000:00:1d.2: detected 2 ports
 uhci_hcd 0000:00:1d.2: root hub device address 1
 usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
 drivers/usb/core/message.c: USB device number 1 default language ID 0x409
 usb usb4: Product: Intel Corp. 82801DB USB (Hub #3)
 usb usb4: Manufacturer: Linux 2.6.5-rc1-bk2-p3 uhci_hcd
 usb usb4: SerialNumber: 0000:00:1d.2
 drivers/usb/core/usb.c: usb_hotplug
 usb usb4: registering 4-0:1.0 (config #1, interface 0)
 drivers/usb/core/usb.c: usb_hotplug
 hub 4-0:1.0: usb_probe_interface
 hub 4-0:1.0: usb_probe_interface - got id
 hub 4-0:1.0: USB hub found
 hub 4-0:1.0: 2 ports detected
 hub 4-0:1.0: standalone hub
 hub 4-0:1.0: unknown reserved power switching mode
 hub 4-0:1.0: individual port over-current protection
 hub 4-0:1.0: Port indicators are not supported
 hub 4-0:1.0: power on to power good time: 2ms
 hub 4-0:1.0: hub controller current requirement: 0mA
 hub 4-0:1.0: local power source is good
 hub 4-0:1.0: no over-current condition exists
 hub 4-0:1.0: enabling power on all ports
 ip_tables: (C) 2000-2002 Netfilter core team
 ip_conntrack version 2.1 (4095 buckets, 32760 max) - 304 bytes per
conntrack
 uhci_hcd 0000:00:1d.0: suspend_hc
 uhci_hcd 0000:00:1d.1: suspend_hc
 uhci_hcd 0000:00:1d.2: suspend_hc



Both are Debian unstable systems, fairly up to date, with
Linux get1431p4 2.6.5-rc1-bk2-p3 #1 SMP Wed Mar 17 18:01:26 CET 2004 i686
GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      permitted
e2fsprogs              1.35-WIP
quota-tools            3.11.
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91



This is what I get in the syslog of the P4, as soon as I load
"sd_mod" (usb-storage and scsi_mod are loaded by hotplug automatically and
they work):

 ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001803 POWER sig=j  CSC
CONNECT
 hub 1-0:1.0: port 3, status 501, change 1, 480 Mb/s
 hub 1-0:1.0: debounce: port 3: delay 100ms stable 4 status 0x501
 ehci_hcd 0000:00:1d.7: port 3 high speed
 ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001005 POWER sig=se0  PE
CONNECT
 usb 1-3: new high speed USB device using address 2
 usb 1-3: new device strings: Mfr=1, Product=2, SerialNumber=0
 drivers/usb/core/message.c: USB device number 2 default language ID 0x409
 usb 1-3: Product: Mass Storage Device
 usb 1-3: Manufacturer: Prolific Technology Inc.
 drivers/usb/core/usb.c: usb_hotplug
 usb 1-3: registering 1-3:1.0 (config #1, interface 0)
 drivers/usb/core/usb.c: usb_hotplug
 Initializing USB Mass Storage driver...
 usb-storage 1-3:1.0: usb_probe_interface
 usb-storage 1-3:1.0: usb_probe_interface - got id
 usb-storage: USB Mass Storage device detected
 usb-storage: altsetting is 0, id_index is 118
 usb-storage: -- associate_dev
 usb-storage: Transport: Bulk
 usb-storage: Protocol: Transparent SCSI
 usb-storage: Endpoints: In: 0xd6924f58 Out: 0xd6924f44 Int: 0x00000000
(Period 0)
 usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00
len=1
 usb-storage: GetMaxLUN command result is 1, data is 0
 usb-storage: *** thread sleeping.
 scsi0 : SCSI emulation for USB Mass Storage devices
 usb-storage: queuecommand called
 usb-storage: *** thread awakened.
 usb-storage: Command INQUIRY (6 bytes)
 usb-storage:  12 00 00 00 24 00
 usb-storage: Bulk Command S 0x43425355 T 0x1 L 36 F 128 Trg 0 LUN 0 CL 6
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
 usb-storage: Status code 0; transferred 36/36
 usb-storage: -- transfer complete
 usb-storage: Bulk data transfer result 0x0
 usb-storage: Attempting to get CSW...
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
 usb-storage: Status code 0; transferred 13/13
 usb-storage: -- transfer complete
 usb-storage: Bulk status result = 0
 usb-storage: Bulk Status S 0x53425355 T 0x1 R 0 Stat 0x0
 usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
 usb-storage: scsi cmd done, result=0x0
 usb-storage: *** thread sleeping.
   Vendor: Maxtor 6  Model: Y200P0            Rev: YAR4
   Type:   Direct-Access                      ANSI SCSI revision: 02
 usb-storage: queuecommand called
 usb-storage: *** thread awakened.
 usb-storage: Command TEST_UNIT_READY (6 bytes)
 usb-storage:  00 00 00 00 00 00
 usb-storage: Bulk Command S 0x43425355 T 0x2 L 0 F 0 Trg 0 LUN 0 CL 6
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: Attempting to get CSW...
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
 usb-storage: Status code 0; transferred 13/13
 usb-storage: -- transfer complete
 usb-storage: Bulk status result = 0
 usb-storage: Bulk Status S 0x53425355 T 0x2 R 0 Stat 0x0
 usb-storage: scsi cmd done, result=0x0
 usb-storage: queuecommand called
 usb-storage: *** thread sleeping.
 usb-storage: *** thread awakened.
 usb-storage: Command READ_CAPACITY (10 bytes)
 usb-storage:  25 00 00 00 00 00 00 00 00 00
 usb-storage: Bulk Command S 0x43425355 T 0x3 L 8 F 128 Trg 0 LUN 0 CL 10
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
 usb-storage: Status code 0; transferred 8/8
 usb-storage: -- transfer complete
 usb-storage: Bulk data transfer result 0x0
 usb-storage: Attempting to get CSW...
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
 usb-storage: Status code 0; transferred 13/13
 usb-storage: -- transfer complete
 usb-storage: Bulk status result = 0
 usb-storage: Bulk Status S 0x53425355 T 0x3 R 0 Stat 0x0
 usb-storage: scsi cmd done, result=0x0
 SCSI device sda: 398297089 512-byte hdwr sectors (203928 MB)
 sda: assuming drive cache: write through
  /dev/scsi/host0/bus0/target0/lun0:<7>usb-storage: queuecommand called
 usb-storage: *** thread sleeping.
 usb-storage: *** thread awakened.
 usb-storage: Command READ_10 (10 bytes)
 usb-storage:  28 00 00 00 00 00 00 00 08 00
 usb-storage: Bulk Command S 0x43425355 T 0x4 L 4096 F 128 Trg 0 LUN 0 CL 10
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
 usb-storage: Status code 0; transferred 4096/4096
 usb-storage: -- transfer complete
 usb-storage: Bulk data transfer result 0x0
 usb-storage: Attempting to get CSW...
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
 usb-storage: Status code 0; transferred 13/13
 usb-storage: -- transfer complete
 usb-storage: Bulk status result = 0
 usb-storage: Bulk Status S 0x53425355 T 0x4 R 0 Stat 0x0
 usb-storage: scsi cmd done, result=0x0
 usb-storage: *** thread sleeping.
 usb-storage: queuecommand called
 usb-storage: *** thread awakened.
 usb-storage: Command READ_10 (10 bytes)
 usb-storage:  28 00 17 bd 88 00 00 00 01 00
 usb-storage: Bulk Command S 0x43425355 T 0x5 L 512 F 128 Trg 0 LUN 0 CL 10
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1 entries
 usb-storage: Status code -32; transferred 0/512
 usb-storage: clearing endpoint halt for pipe 0xc0010280
 usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=82
len=0
 usb-storage: usb_stor_clear_halt: result = 0
 usb-storage: Bulk data transfer result 0x2
 usb-storage: Attempting to get CSW...
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
 usb-storage: Status code 0; transferred 13/13
 usb-storage: -- transfer complete
 usb-storage: Bulk status result = 0
 usb-storage: Bulk Status S 0x53425355 T 0x5 R 512 Stat 0x1
 usb-storage: -- transport indicates command failure
 usb-storage: -- unexpectedly short transfer
 usb-storage: Issuing auto-REQUEST_SENSE
 usb-storage: Bulk Command S 0x43425355 T 0x80000005 L 18 F 128 Trg 0 LUN 0
CL 6
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
 usb-storage: Status code 0; transferred 18/18
 usb-storage: -- transfer complete
 usb-storage: Bulk data transfer result 0x0
 usb-storage: Attempting to get CSW...
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
 usb-storage: Status code 0; transferred 13/13
 usb-storage: -- transfer complete
 usb-storage: Bulk status result = 0
 usb-storage: Bulk Status S 0x53425355 T 0x80000005 R 0 Stat 0x0
 usb-storage: -- Result from auto-sense is 0
 usb-storage: -- code: 0x70, key: 0x6, ASC: 0x29, ASCQ: 0x0
 usb-storage: Unit Attention: Power on, reset, or bus device reset occurred
 usb-storage: scsi cmd done, result=0x2
 usb-storage: *** thread sleeping.
 usb-storage: queuecommand called
 usb-storage: *** thread awakened.
 usb-storage: Command READ_10 (10 bytes)
 usb-storage:  28 00 17 bd 88 00 00 00 01 00
 usb-storage: Bulk Command S 0x43425355 T 0x6 L 512 F 128 Trg 0 LUN 0 CL 10
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1 entries
 usb-storage: Status code -32; transferred 0/512
 usb-storage: clearing endpoint halt for pipe 0xc0010280
 usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=82
len=0
 usb-storage: usb_stor_clear_halt: result = 0
 usb-storage: Bulk data transfer result 0x2
 usb-storage: Attempting to get CSW...
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
 usb-storage: Status code 0; transferred 13/13
 usb-storage: -- transfer complete
 usb-storage: Bulk status result = 0
 usb-storage: Bulk Status S 0x53425355 T 0x6 R 512 Stat 0x1
 usb-storage: -- transport indicates command failure
 usb-storage: -- unexpectedly short transfer
 usb-storage: Issuing auto-REQUEST_SENSE
 usb-storage: Bulk Command S 0x43425355 T 0x80000006 L 18 F 128 Trg 0 LUN 0
CL 6
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
 usb-storage: Status code 0; transferred 18/18
 usb-storage: -- transfer complete
 usb-storage: Bulk data transfer result 0x0
 usb-storage: Attempting to get CSW...
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
 usb-storage: Status code 0; transferred 13/13
 usb-storage: -- transfer complete
 usb-storage: Bulk status result = 0
 usb-storage: Bulk Status S 0x53425355 T 0x80000006 R 0 Stat 0x0
 usb-storage: -- Result from auto-sense is 0
 usb-storage: -- code: 0x70, key: 0x6, ASC: 0x29, ASCQ: 0x0
 usb-storage: Unit Attention: Power on, reset, or bus device reset occurred
 usb-storage: scsi cmd done, result=0x2
 usb-storage: *** thread sleeping.
 usb-storage: queuecommand called
 usb-storage: *** thread awakened.
 usb-storage: Command READ_10 (10 bytes)
 usb-storage:  28 00 17 bd 88 00 00 00 01 00
 usb-storage: Bulk Command S 0x43425355 T 0x7 L 512 F 128 Trg 0 LUN 0 CL 10
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1 entries
 usb-storage: Status code -32; transferred 0/512
 usb-storage: clearing endpoint halt for pipe 0xc0010280
 usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=82
len=0
 usb-storage: usb_stor_clear_halt: result = 0
 usb-storage: Bulk data transfer result 0x2
 usb-storage: Attempting to get CSW...
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
 usb-storage: Status code 0; transferred 13/13
 usb-storage: -- transfer complete
 usb-storage: Bulk status result = 0
 usb-storage: Bulk Status S 0x53425355 T 0x7 R 512 Stat 0x1
 usb-storage: -- transport indicates command failure
 usb-storage: -- unexpectedly short transfer
 usb-storage: Issuing auto-REQUEST_SENSE
 usb-storage: Bulk Command S 0x43425355 T 0x80000007 L 18 F 128 Trg 0 LUN 0
CL 6
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
 usb-storage: Status code 0; transferred 18/18
 usb-storage: -- transfer complete
 usb-storage: Bulk data transfer result 0x0
 usb-storage: Attempting to get CSW...
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
 usb-storage: Status code 0; transferred 13/13
 usb-storage: -- transfer complete
 usb-storage: Bulk status result = 0
 usb-storage: Bulk Status S 0x53425355 T 0x80000007 R 0 Stat 0x0
 usb-storage: -- Result from auto-sense is 0
 usb-storage: -- code: 0x70, key: 0x6, ASC: 0x29, ASCQ: 0x0
 usb-storage: Unit Attention: Power on, reset, or bus device reset occurred
 usb-storage: scsi cmd done, result=0x2
 usb-storage: *** thread sleeping.
 usb-storage: queuecommand called
 usb-storage: *** thread awakened.
 usb-storage: Command READ_10 (10 bytes)
 usb-storage:  28 00 17 bd 88 00 00 00 01 00
 usb-storage: Bulk Command S 0x43425355 T 0x8 L 512 F 128 Trg 0 LUN 0 CL 10
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1 entries
 usb-storage: Status code -32; transferred 0/512
 usb-storage: clearing endpoint halt for pipe 0xc0010280
 usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=82
len=0
 usb-storage: usb_stor_clear_halt: result = 0
 usb-storage: Bulk data transfer result 0x2
 usb-storage: Attempting to get CSW...
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
 usb-storage: Status code 0; transferred 13/13
 usb-storage: -- transfer complete
 usb-storage: Bulk status result = 0
 usb-storage: Bulk Status S 0x53425355 T 0x8 R 512 Stat 0x1
 usb-storage: -- transport indicates command failure
 usb-storage: -- unexpectedly short transfer
 usb-storage: Issuing auto-REQUEST_SENSE
 usb-storage: Bulk Command S 0x43425355 T 0x80000008 L 18 F 128 Trg 0 LUN 0
CL 6
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
 usb-storage: Status code 0; transferred 18/18
 usb-storage: -- transfer complete
 usb-storage: Bulk data transfer result 0x0
 usb-storage: Attempting to get CSW...
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
 usb-storage: Status code 0; transferred 13/13
 usb-storage: -- transfer complete
 usb-storage: Bulk status result = 0
 usb-storage: Bulk Status S 0x53425355 T 0x80000008 R 0 Stat 0x0
 usb-storage: -- Result from auto-sense is 0
 usb-storage: -- code: 0x70, key: 0x6, ASC: 0x29, ASCQ: 0x0
 usb-storage: Unit Attention: Power on, reset, or bus device reset occurred
 usb-storage: scsi cmd done, result=0x2
 usb-storage: *** thread sleeping.
 usb-storage: queuecommand called
 usb-storage: *** thread awakened.
 usb-storage: Command READ_10 (10 bytes)
 usb-storage:  28 00 17 bd 88 00 00 00 01 00
 usb-storage: Bulk Command S 0x43425355 T 0x9 L 512 F 128 Trg 0 LUN 0 CL 10
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1 entries
 usb-storage: Status code -32; transferred 0/512
 usb-storage: clearing endpoint halt for pipe 0xc0010280
 usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=82
len=0
 usb-storage: usb_stor_clear_halt: result = 0
 usb-storage: Bulk data transfer result 0x2
 usb-storage: Attempting to get CSW...
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
 usb-storage: Status code 0; transferred 13/13
 usb-storage: -- transfer complete
 usb-storage: Bulk status result = 0
 usb-storage: Bulk Status S 0x53425355 T 0x9 R 512 Stat 0x1
 usb-storage: -- transport indicates command failure
 usb-storage: -- unexpectedly short transfer
 usb-storage: Issuing auto-REQUEST_SENSE
 usb-storage: Bulk Command S 0x43425355 T 0x80000009 L 18 F 128 Trg 0 LUN 0
CL 6
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
 usb-storage: Status code 0; transferred 18/18
 usb-storage: -- transfer complete
 usb-storage: Bulk data transfer result 0x0
 usb-storage: Attempting to get CSW...
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
 usb-storage: Status code 0; transferred 13/13
 usb-storage: -- transfer complete
 usb-storage: Bulk status result = 0
 usb-storage: Bulk Status S 0x53425355 T 0x80000009 R 0 Stat 0x0
 usb-storage: -- Result from auto-sense is 0
 usb-storage: -- code: 0x70, key: 0x6, ASC: 0x29, ASCQ: 0x0
 usb-storage: Unit Attention: Power on, reset, or bus device reset occurred
 usb-storage: scsi cmd done, result=0x2
 usb-storage: *** thread sleeping.
 usb-storage: queuecommand called
 usb-storage: *** thread awakened.
 usb-storage: Command READ_10 (10 bytes)
 usb-storage:  28 00 17 bd 88 00 00 00 01 00
 usb-storage: Bulk Command S 0x43425355 T 0xa L 512 F 128 Trg 0 LUN 0 CL 10
 usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
 usb-storage: Status code 0; transferred 31/31
 usb-storage: -- transfer complete
 usb-storage: Bulk command transfer result=0
 usb-storage: usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1 entries
 usb-storage: Status code -32; transferred 0/512
 usb-storage: clearing endpoint halt for pipe 0xc0010280
 usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=82
len=0
 usb-storage: usb_stor_clear_halt: result = 0

etc etc etc etc ............... as long as the harddisk is on, or connected.

Thank you!


-- 
Jens Benecke (jens at spamfreemail.de)
http://www.hitchhikers.de - Europaweite kostenlose Mitfahrzentrale
http://www.spamfreemail.de - 100% saubere Postfächer - garantiert!
http://www.rb-hosting.de - PHP ab 9? - SSH ab 19? - günstiger Traffic
.
Please DO NOT CC: me, I read the lists and newsgroups I post in!

