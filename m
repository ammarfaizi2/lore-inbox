Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316261AbSEZSrU>; Sun, 26 May 2002 14:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316267AbSEZSrT>; Sun, 26 May 2002 14:47:19 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.31]:15265 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S316261AbSEZSrS>; Sun, 26 May 2002 14:47:18 -0400
Date: Sun, 26 May 2002 14:52:19 -0400
From: jay <jbeatty@optonline.net>
Subject: usb mass storage  fails in 2.5.18
To: linux kernel <linux-kernel@vger.kernel.org>
Message-id: <3CF12EE3.6070609@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to set up 2.5.18 to read a digital camera memory stick - 
which I can in 2.4.18.

I think I've configured the kernel correctly:

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
.
.
.
.
#
# USB support
#
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_LONG_TIMEOUT is not set
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
# CONFIG_USB_STORAGE_DATAFAB is not set
..............


And the kernel sees it on bootup. See the dmesg snip below. But there is 
nothing in /proc/bus/usb. OTOH /proc/scsi/usb-storage-0 does exist. When 
I try to mount /dev/sda1 I get it's not a valid block device.

Can I get this to work? What am I missing?

thanks for any help
jay



cdrecord -scanbus
Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
Linux sg driver version: 3.5.25
Using libscg version 'schily-0.5'
scsibus0:
         0,0,0     0) 'ATAPI   ' 'CD-R/RW 20X10   ' 'H.PF' Removable CD-ROM
         0,1,0     1) *
         0,2,0     2) *
         0,3,0     3) *
         0,4,0     4) *
         0,5,0     5) *
         0,6,0     6) *
         0,7,0     7) *


Here the dmesg snippet:

May 26 14:26:10 daddy kernel: PCI: Sharing IRQ 14 with 00:09.0
May 26 14:26:10 daddy kernel: hcd.c: usb-uhci-hcd @ 00:04.2, Intel Corp. 
82371AB PIIX4 USB
May 26 14:26:10 daddy kernel: hcd.c: irq 14, io base 0000d400
May 26 14:26:10 daddy kernel: hcd.c: new USB bus registered, assigned 
bus number 1
May 26 14:26:10 daddy kernel: usb-uhci-hcd.c: Detected 2 ports
May 26 14:26:10 daddy kernel: Manufacturer: Linux 2.5.18 usb-uhci-hcd
May 26 14:26:10 daddy kernel: Product: Intel Corp. 82371AB PIIX4 USB
May 26 14:26:10 daddy kernel: SerialNumber: 00:04.2
May 26 14:26:10 daddy kernel: hub.c: USB hub found at /
........

May 26 14:26:10 daddy kernel: hub.c: new USB device 00:04.2-1, assigned 
address 2
May 26 14:26:10 daddy kernel: Manufacturer: Sony
May 26 14:26:10 daddy kernel: Product: Sony DSC
May 26 14:26:10 daddy kernel: scsi1 : SCSI emulation for USB Mass 
Storage devices
May 26 14:26:10 daddy kernel: usb-uhci-hcd.c: interrupt, status 2, 
frame# 820
May 26 14:26:10 daddy kernel: hub.c: new USB device 00:04.2-2, assigned 
address 3
May 26 14:26:10 daddy kernel: hub.c: USB hub found at 2
May 26 14:26:10 daddy kernel: hub.c: 4 ports detected
May 26 14:26:10 daddy kernel: hub.c: new USB device 00:04.2-2.4, 
assigned address 4
May 26 14:26:10 daddy kernel: usb.c: USB device 4 (vend/prod 0x452/0x51) 
is not claimed by any active driver.
May 26 14:26:10 daddy kernel:   Length              = 18
May 26 14:26:10 daddy kernel:   DescriptorType      = 01
May 26 14:26:10 daddy kernel:   USB version         = 1.00
May 26 14:26:10 daddy kernel:   Vendor:Product      = 0452:0051
May 26 14:26:10 daddy kernel:   MaxPacketSize0      = 8
May 26 14:26:10 daddy kernel:   NumConfigurations   = 1
May 26 14:26:10 daddy kernel:   Device version      = 2.06
May 26 14:26:10 daddy kernel:   Device Class:SubClass:Protocol = 00:00:00
May 26 14:26:10 daddy kernel:     Per-interface classes
May 26 14:26:10 daddy kernel: Configuration:
May 26 14:26:10 daddy kernel:   bLength             =    9
May 26 14:26:10 daddy kernel:   bDescriptorType     =   02
May 26 14:26:10 daddy kernel:   wTotalLength        = 0022
May 26 14:26:10 daddy kernel:   bNumInterfaces      =   01
May 26 14:26:10 daddy kernel:   bConfigurationValue =   01
May 26 14:26:10 daddy kernel:   iConfiguration      =   00
May 26 14:26:10 daddy kernel:   bmAttributes        =   40
May 26 14:26:10 daddy kernel:   MaxPower            =  100mA
May 26 14:26:10 daddy kernel:
May 26 14:26:10 daddy kernel:   Interface: 0
May 26 14:26:10 daddy kernel:   Alternate Setting:  0
May 26 14:26:10 daddy kernel:     bLength             =    9
May 26 14:26:10 daddy kernel:     bDescriptorType     =   04
May 26 14:26:10 daddy kernel:     bInterfaceNumber    =   00
May 26 14:26:10 daddy kernel:     bAlternateSetting   =   00
May 26 14:26:10 daddy kernel:     bNumEndpoints       =   01
May 26 14:26:10 daddy kernel:     bInterface Class:SubClass:Protocol = 
  03:00:00
May 26 14:26:10 daddy kernel:     iInterface          =   00
May 26 14:26:10 daddy kernel:     Endpoint:
May 26 14:26:10 daddy kernel:       bLength             =    7
May 26 14:26:10 daddy kernel:       bDescriptorType     =   05
May 26 14:26:10 daddy kernel:       bEndpointAddress    =   81 (in)
May 26 14:26:10 daddy kernel:       bmAttributes        =   03 (Interrupt)
May 26 14:26:10 daddy kernel:       wMaxPacketSize      = 0008
May 26 14:26:10 daddy kernel:       bInterval           =   20





