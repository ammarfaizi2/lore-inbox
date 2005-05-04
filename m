Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVEDMlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVEDMlM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 08:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVEDMlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 08:41:12 -0400
Received: from 80-202-4-58.dd.nextgentel.com ([80.202.4.58]:15861 "EHLO
	osl1smout1.broadpark.no") by vger.kernel.org with ESMTP
	id S261707AbVEDMj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 08:39:57 -0400
Date: Wed, 04 May 2005 14:40:43 +0000
From: Frank Aune <faune@stud.ntnu.no>
Subject: USB Card reader fails to initialize sometimes
To: linux-kernel@vger.kernel.org
Cc: faune@stud.ntnu.no
Message-id: <200505041440.43741.faune@stud.ntnu.no>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ive got a weird problem haunting me from time to time, and its been awhile 
since I had this problem now but a couple of days ago it resurfaced again. It 
went away sometimes with the 2.6.7 - 2.6.8 kernels and surfaced now again 
with 2.6.11. 

Its a USB Card reader connected to an onboard USB connector, which sometimes 
fails to initialize properly. If it for some reason fails to initialize, it 
will continue to fail on consecutive reboots / cold starts.

And once its failed to initialize, the only solution I have found is to unplug 
the onboard connector and reconnect it while the computer is running. This 
will make it initialize correctly, and it will also continue to initialize 
correctly after reboot / cold starts. 

I know this probably sounds like a HW-problem with the card reader, but I 
thought Id post the dmesg logs showing the messages when I unplug the 
cardreader and replug it while the computer is running. It might possibly 
give some clues if this is a flaw in the kernel or HW. (There are actually 
two onboard USB connectors, so that is the reason why in the logs below its 
sometimes shown as usb2 and sometimes usb3 depending on what port I plugged 
it into - I tried both).

Also, one practical question. If the cardread fails to initialize, is there 
any way I can try to reinitialize it without physically unplugging/replugging 
the onboard connector? Its not very practical opening the case each time this 
happens...

Thanks for any feedback!

-Frank Aune

PS: Please CC me as Im not on the LKML.

------

>From dmesg after boot:
usb 2-1: new full speed USB device using ohci_hcd and address 2
usb 2-1: khubd timed out on ep0in
usb 2-1: device descriptor read/64, error -110
usb 2-1: khubd timed out on ep0in
usb 2-1: device descriptor read/64, error -110
usb 2-1: new full speed USB device using ohci_hcd and address 3
usb 2-1: khubd timed out on ep0in
usb 2-1: device descriptor read/64, error -110
usb 2-1: khubd timed out on ep0in
usb 2-1: device descriptor read/64, error -110


This is where I start unplugging and replugging the cardreader. Ive left some 
white space between each time I unplugged/replugged it:

usb 3-3: new high speed USB device using ehci_hcd and address 5
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
usb 3-3: USB disconnect, address 5
usb 3-3: new high speed USB device using ehci_hcd and address 6
usb 3-3: config index 0 descriptor too short (expected 32, got 9)
usb 3-3: config 1 has 0 interfaces, different from the descriptor's value: 1


usb 3-3: USB disconnect, address 6
usb 3-4: new high speed USB device using ehci_hcd and address 7
usb 3-4: unable to read config index 0 descriptor/start
usb 3-4: can't read configurations, error -75
usb 3-4: new high speed USB device using ehci_hcd and address 8
scsi3 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 8
usb-storage: waiting for device to settle before scanning
  Vendor: USB2.0    Model: CardReader CF RW  Rev: 0.0>
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdb at scsi3, channel 0, id 0, lun 0
  Vendor: USB2.0    Model: CardReader Combo  Rev: 0.0>
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdc at scsi3, channel 0, id 0, lun 1
usb-storage: device scan complete



usb 3-4: USB disconnect, address 8
ohci_hcd 0000:00:02.1: wakeup
usb 3-3: new high speed USB device using ehci_hcd and address 10
scsi4 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 10
usb-storage: waiting for device to settle before scanning
  Vendor: USB2.0    Model: CardReader CF RW  Rev: 0.0>
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdb at scsi4, channel 0, id 0, lun 0
  Vendor: USB2.0    Model: CardReader Combo  Rev: 0.0>
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdc at scsi4, channel 0, id 0, lun 1
usb-storage: device scan complete



usb 3-3: USB disconnect, address 10
usb 3-4: new high speed USB device using ehci_hcd and address 11
scsi5 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 11
usb-storage: waiting for device to settle before scanning
usb 3-4: USB disconnect, address 11
usb 3-4: new high speed USB device using ehci_hcd and address 12
scsi6 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 12
usb-storage: waiting for device to settle before scanning
  Vendor: USB2.0    Model: CardReader CF RW  Rev: 0.0>
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdb at scsi6, channel 0, id 0, lun 0
  Vendor: USB2.0    Model: CardReader Combo  Rev: 0.0>
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdc at scsi6, channel 0, id 0, lun 1
usb-storage: device scan complete


-------
# lsusb -v

Bus 003 Device 003: ID 07cc:0301 Carry Computer Eng., Co., Ltd
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x07cc Carry Computer Eng., Co., Ltd
  idProduct          0x0301
  bcdDevice            0.05
  iManufacturer           1         Ltd
  iProduct                2 Winter Ver1.3
  iSerial                 3 155246506722
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              4 1.06.30.0704
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize        512
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize        512
        bInterval               0
  Language IDs: (length=4)
     0409 English(US)

Bus 003 Device 001: ID 0000:0000
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
  iManufacturer           3 Linux 2.6.11-gentoo-r7-faune ehci_hcd
  iProduct                2 nVidia Corporation nForce3 USB 2.0
  iSerial                 1 0000:00:02.2
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
          Synch Type               none
        wMaxPacketSize          2
        bInterval              12
  Language IDs: (length=4)
     0409 English(US)

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
  iManufacturer           3 Linux 2.6.11-gentoo-r7-faune ohci_hcd
  iProduct                2 nVidia Corporation nForce3 USB 1.1 (#2)
  iSerial                 1 0000:00:02.1
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
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 005: ID 046d:0870 Logitech, Inc. QuickCam Express
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass       255 Vendor Specific Subclass
  bDeviceProtocol       255 Vendor Specific Protocol
  bMaxPacketSize0         8
  idVendor           0x046d Logitech, Inc.
  idProduct          0x0870 QuickCam Express
  bcdDevice            1.00
  iManufacturer           0
  iProduct                1 Camera
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           55
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower               90mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          0
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          1
        bInterval              16
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize       1023
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          1
        bInterval              16
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 004: ID 046d:c505 Logitech, Inc. Cordless Mouse+Keyboard 
Receiver
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x046d Logitech, Inc.
  idProduct          0xc505 Cordless Mouse+Keyboard Receiver
  bcdDevice           17.00
  iManufacturer           1 Logitech
  iProduct                2 USB Receiver
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          2
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
      bInterfaceProtocol      1 Keyboard
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      63
cannot get report descriptor
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval              10
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
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
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     190
cannot get report descriptor
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval              10
  Language IDs: (length=4)
     0409 English(US)

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
  iManufacturer           3 Linux 2.6.11-gentoo-r7-faune ohci_hcd
  iProduct                2 nVidia Corporation nForce3 USB 1.1
  iSerial                 1 0000:00:02.0
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
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)
--------


System:
Kernel 2.6.11 using Gentoo
1GB ram
Athlon64 on nforce3 running 32-bit only


