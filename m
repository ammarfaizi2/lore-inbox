Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUJRVL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUJRVL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267417AbUJRVKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:10:45 -0400
Received: from ms-1.rz.RWTH-Aachen.DE ([134.130.3.130]:21226 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S267361AbUJRVC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:02:58 -0400
Date: Mon, 18 Oct 2004 23:02:49 +0200
From: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Oops when inserting usb stick
To: linux-kernel@vger.kernel.org
Message-id: <200410182302.50056@zodiac.zodiac.dnsalias.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-MIMETrack: Itemize by SMTP Server on ipt-lotus1/Fraunhofer IPT(Release 5.0.12
  |February 13, 2003) at 18.10.2004 23:02:48,
	Serialize by Router on ipt-lotus1/Fraunhofer IPT(Release 5.0.12  |February 13,
 2003) at 18.10.2004 23:02:49,	Serialize complete at 18.10.2004 23:02:49
User-Agent: KMail/1.7
X-Need-Girlfriend: always
X-Ignorant-User: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when I insert a usb stick into my thinkpad, 2.6.9-rc4-mm1( without the buggy 
optimise profile path patch) oopses:
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
  Vendor:           Model: USB DRIVE         Rev: 2.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
sda: Unit Not Ready, sense:
Current : sense = 70  6
ASC=28 ASCQ= 0
Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 
0x28
0x00 0x00 0x00 0x00 0x00
sda : READ CAPACITY failed.
sda : status=1, message=00, host=0, driver=08
Current sd: sense = 70  6
ASC=28 ASCQ= 0
Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 
0x28
0x00 0x00 0x00 0x00 0x00
sda: assuming Write Enabled
sda: assuming drive cache: write through
sda: Unit Not Ready, sense:
Current : sense = 70  6
ASC=28 ASCQ= 0
Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 
0x28
0x00 0x00 0x00 0x00 0x00
sda : READ CAPACITY failed.
sda : status=1, message=00, host=0, driver=08
Current sd: sense = 70  6
ASC=28 ASCQ= 0
Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 
0x28
0x00 0x00 0x00 0x00 0x00
sda: assuming Write Enabled
sda: assuming drive cache: write through
sda: Unit Not Ready, sense:
Current : sense = 70  6
ASC=28 ASCQ= 0
Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 
0x28
0x00 0x00 0x00 0x00 0x00
SCSI device sda: 512000 512-byte hdwr sectors (262 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 sda: sda1
 sda: sda1
kobject_register failed for sda1 (-17)
 [<c01f381a>] kobject_register+0x51/0x53
 [<c017eafa>] add_partition+0xaf/0xd4
 [<c017ec82>] register_disk+0x10e/0x11a
 [<c0281658>] add_disk+0x39/0x47
 [<c0281605>] exact_match+0x0/0x7
 [<c028160c>] exact_lock+0x0/0x13
 [<c02acda0>] sd_probe+0x219/0x318
 [<c01800b2>] sysfs_make_dirent+0x1c/0x88
 [<c0279748>] bus_match+0x32/0x5b
 [<c02797ab>] device_attach+0x3a/0x87
 [<c016436c>] dput+0x1b/0x283
 [<c0279a1c>] bus_add_device+0x54/0x95
 [<c0278b27>] device_add+0x9c/0x117
 [<c02aa192>] scsi_sysfs_add_sdev+0x9f/0x2e8
 [<c02a8dec>] scsi_add_lun+0x285/0x2f0
 [<c02a8f08>] scsi_probe_and_add_lun+0xb1/0x177
 [<c02a962a>] scsi_scan_target+0x9a/0x107
 [<c02a96f5>] scsi_scan_channel+0x5e/0x71
 [<c02a97b9>] scsi_scan_host_selected+0xb1/0xb8
 [<c02a97e1>] scsi_scan_host+0x21/0x25
 [<e196a72d>] usb_stor_scan_thread+0x6f/0x12b [usb_storage]
 [<c012b70a>] autoremove_wake_function+0x0/0x43
 [<c0105de6>] ret_from_fork+0x6/0x14
 [<c012b70a>] autoremove_wake_function+0x0/0x43
 [<e196a6be>] usb_stor_scan_thread+0x0/0x12b [usb_storage]
 [<c0104265>] kernel_thread_helper+0x5/0xb
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete

The stick works afterwards, though.
System is IBM T40p, lsusb -v and lspci -v follows:

regards
Alex

alex@t40:~$ lsusb -v

Bus 004 Device 002: ID 04e8:0111 Samsung Electronics Co., Ltd
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x04e8 Samsung Electronics Co., Ltd
  idProduct          0x0111
  bcdDevice            2.00
  iManufacturer           1
  iProduct                2
  iSerial                 3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              200mA
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
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval               1

Bus 004 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3
  iProduct                2
  iSerial                 1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval              12
can't get hub descriptor: Operation not permitted

Bus 003 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3
  iProduct                2
  iSerial                 1
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
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
can't get hub descriptor: Operation not permitted

Bus 002 Device 002: ID 046d:c024 Logitech, Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x046d Logitech, Inc.
  idProduct          0xc024
  bcdDevice           98.02
  iManufacturer           1
  iProduct                2
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower               98mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      64
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0005  1x 5 bytes
        bInterval              10

Bus 002 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3
  iProduct                2
  iSerial                 1
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
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
can't get hub descriptor: Operation not permitted

Bus 001 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3
  iProduct                2
  iSerial                 1
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
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
can't get hub descriptor: Operation not permitted
alex@t40:~$ su -
Password:
lsuroot@t40:~# lsusb
Bus 004 Device 002: ID 04e8:0111 Samsung Electronics Co., Ltd
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 002: ID 046d:c024 Logitech, Inc.
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000
root@t40:~# lsusb -v

Bus 004 Device 002: ID 04e8:0111 Samsung Electronics Co., Ltd
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x04e8 Samsung Electronics Co., Ltd
  idProduct          0x0111
  bcdDevice            2.00
  iManufacturer           1 0
  iProduct                2 USB DRIVE
  iSerial                 3 0000000000004334
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              200mA
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
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval               1
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  bNumConfigurations      1

Bus 004 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.9-rc4-mm1orig ehci_hcd
  iProduct                2 Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI 
Controller
  iSerial                 1 0000:00:1d.7
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             6
  wHubCharacteristic 0x0008
    Ganged power switching
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x01

Bus 003 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.9-rc4-mm1orig uhci_hcd
  iProduct                2
  iSerial                 1 0000:00:1d.2
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
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x01

Bus 002 Device 002: ID 046d:c024 Logitech, Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x046d Logitech, Inc.
  idProduct          0xc024
  bcdDevice           98.02
  iManufacturer           1 B16_b_02
  iProduct                2 USB-PS/2 Optical Mouse
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower               98mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      64
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0005  1x 5 bytes
        bInterval              10

Bus 002 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.9-rc4-mm1orig uhci_hcd
  iProduct                2
  iSerial                 1 0000:00:1d.1
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
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x01

Bus 001 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.9-rc4-mm1orig uhci_hcd
  iProduct                2
  iSerial                 1 0000:00:1d.0
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
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x01

root@t40:~# lspci -v
0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 
03)
        Subsystem: IBM: Unknown device 0529
        Flags: bus master, fast devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [e4] #09 [f104]
        Capabilities: [a0] AGP version 2.0

0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 
03) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 96
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: c0100000-c01fffff
        Prefetchable memory behind bridge: e0000000-e7ffffff

0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1800 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1820 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1840 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 
EHCI Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: IBM: Unknown device 052e
        Flags: bus master, medium devsel, latency 0, IRQ 11
        Memory at c0000000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81) (prog-if 00 
[Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=08, sec-latency=168
        I/O behind bridge: 00004000-00008fff
        Memory behind bridge: c0200000-cfffffff
        Prefetchable memory behind bridge: e8000000-efffffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 
01)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage 
Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: IBM: Unknown device 052d
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 1860 [size=16]
        Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus 
Controller (rev 01)
        Subsystem: IBM: Unknown device 052d
        Flags: medium devsel, IRQ 5
        I/O ports at 1880 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
        Subsystem: IBM: Unknown device 0537
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at 1c00 [size=256]
        I/O ports at 18c0 [size=64]
        Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
        Memory at c0000800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 
Modem Controller (rev 01) (prog-if 00 [Generic])
        Subsystem: IBM: Unknown device 0525
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at 2400 [size=256]
        I/O ports at 2000 [size=128]
        Capabilities: [50] Power Management version 2

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf 
[Radeon Mobility 9000 M9] (rev 02) (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 054d
        Flags: bus master, stepping, fast Back2Back, 66MHz, medium devsel, 
latency 66, IRQ 11
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        I/O ports at 3000 [size=256]
        Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

0000:02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus 
Controller (rev 01)
        Subsystem: IBM ThinkPad T30/T40
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at b0000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

0000:02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus 
Controller (rev 01)
        Subsystem: IBM ThinkPad T30/T40
        Flags: bus master, medium devsel, latency 168, IRQ 5
        Memory at b1000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 20c00000-20fff000 (prefetchable)
        Memory window 1: 21000000-213ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        16-bit legacy interface ports at 0001

0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet 
Controller (Mobile) (rev 03)
        Subsystem: IBM PRO/1000 MT Mobile Connection
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        Memory at c0220000 (32-bit, non-prefetchable) [size=128K]
        Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
        I/O ports at 8000 [size=64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-

0000:02:02.0 Ethernet controller: Atheros Communications, Inc. AR5211 802.11ab 
NIC (rev 01)
        Subsystem: Unknown device 17ab:8310
        Flags: bus master, medium devsel, latency 80, IRQ 11
        Memory at c0210000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [44] Power Management version 2



-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

