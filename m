Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTIGOA2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 10:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTIGOA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 10:00:28 -0400
Received: from mail-06.iinet.net.au ([203.59.3.38]:35806 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263268AbTIGOAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 10:00:01 -0400
Subject: USB - UHCI not SMP capable? linux-2.6-test4
From: Sven Dowideit <svenud@ozemail.com.au>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1062978875.1679.40.camel@sven>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 08 Sep 2003 09:54:35 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dual pIII VIA VP6 which is not doing usb properly. it appears
to work when i re-build with SMP off , but with SMP on devices don't get
detected/powered up.

as a simple test I have a logitech usb mouse plugged in (but you don't
get to see it :).

as an added wierdness, when i added a pcmcia-PCI bridge to the system,
to test Russell's pcmcia patch (when didn't work well (but that could
have been config issues)) and repeatedly pulled and added pcmcia cards,
the usb mouse somethimes turned up.. but not at boot time.

does anyone have any ideas?

the following logs are with SMP enabled
------
dmesg

niform CD-ROM driver Revision: 3.12
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
uhci-hcd 0000:00:07.2: UHCI Host Controller
uhci-hcd 0000:00:07.2: irq 19, io base 0000a400
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
PM: Adding info for usb:usb1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PM: Adding info for usb:1-0:0
uhci-hcd 0000:00:07.3: UHCI Host Controller
uhci-hcd 0000:00:07.3: irq 19, io base 0000a800
uhci-hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
PM: Adding info for usb:usb2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PM: Adding info for usb:2-0:0
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 19

------
lspci -v

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at a400 [size=32]Bus 002 Device 001: ID 0000:0000
        Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at a800 [size=32]
        Capabilities: [80] Power Management version 2


---------
lsusb -v

Bus 002 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.0-test4 uhci-hcd
  iProduct                2 UHCI Host Controller
  iSerial                 1 0000:00:07.3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
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

Bus 001 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.0-test4 uhci-hcd
  iProduct                2 UHCI Host Controller
  iSerial                 1 0000:00:07.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
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


------
.config

#
# USB
support                                                                                          
#                                                                                                      
CONFIG_USB=y                                                                                           
# CONFIG_USB_DEBUG is not
set                                                                          
                                                                                                       
#                                                                                                      
# Miscellaneous USB
options                                                                            
#                                                                                                      
CONFIG_USB_DEVICEFS=y                                                                                  
# CONFIG_USB_BANDWIDTH is not
set                                                                     
# CONFIG_USB_DYNAMIC_MINORS is not
set                                                                 
                                                                                                       
#                                                                                                      
# USB Host Controller
Drivers                                                                          
#                                                                                                      
# CONFIG_USB_EHCI_HCD is not
set                                                                       
# CONFIG_USB_OHCI_HCD is not
set                                                                       
CONFIG_USB_UHCI_HCD=y                                                                                  
                                                                                                       
#                                                                                                      
# USB Device Class
drivers                                                                             
#                                                                                                      
# CONFIG_USB_AUDIO is not
set                                                                          
# CONFIG_USB_BLUETOOTH_TTY is not
set                                                                  
# CONFIG_USB_MIDI is not
set                                                                           
# CONFIG_USB_ACM is not
set                                                                            
CONFIG_USB_PRINTER=m                                                                                   
                                                                                                       
#                                                                                                      
# SCSI support is needed for USB
Storage                                                               
#                                                                                                      
# CONFIG_USB_STORAGE is not
set                                                                        
                                                                                                       
#                                                                                                      
# USB Human Interface Devices
(HID)                                                                   
#                                                                                                      
CONFIG_USB_HID=y                                                                                       
CONFIG_USB_HIDINPUT=y                                                                                  
# CONFIG_HID_FF is not
set                                                                             
# CONFIG_USB_HIDDEV is not
set                                                                         
# CONFIG_USB_AIPTEK is not
set                                                                         
# CONFIG_USB_WACOM is not
set                                                                          
# CONFIG_USB_KBTAB is not
set                                                                          
# CONFIG_USB_POWERMATE is not
set                                                                     
# CONFIG_USB_XPAD is not
set                                                                           
                                                                                                       
#                                                                                                      
# USB Imaging
devices                                                                                  
#                                                                                                      
# CONFIG_USB_MDC800 is not
set                                                                         
# CONFIG_USB_SCANNER is not
set                                                                        
                                                                                                       
#                                                                                                      
# USB Multimedia
devices                                                                               
#                                                                                                      
# CONFIG_USB_DABUSB is not
set                                                                         
# CONFIG_USB_VICAM is not
set                                                                          
# CONFIG_USB_DSBR is not
set                                                                           
# CONFIG_USB_IBMCAM is not
set                                                                         
# CONFIG_USB_KONICAWC is not
set                                                                       
# CONFIG_USB_OV511 is not
set                                                                          
# CONFIG_USB_PWC is not
set                                                                            
# CONFIG_USB_SE401 is not
set                                                                          
# CONFIG_USB_STV680 is not
set                                                                         
                                                                                                       
#                                                                                                      
# USB Network
adaptors                                                                                 
#                                                                                                      
# CONFIG_USB_AX8817X is not
set                                                                        
# CONFIG_USB_CATC is not
set                                                                           
# CONFIG_USB_KAWETH is not
set                                                                         
# CONFIG_USB_PEGASUS is not
set                                                                        
# CONFIG_USB_RTL8150 is not
set                                                                        
# CONFIG_USB_USBNET is not
set                                                                         
                                                                                                       
#                                                                                                      
# USB port
drivers                                                                                     
#                                                                                                      
# CONFIG_USB_USS720 is not
set                                                                         
                                                                                                       
#                                                                                                      
# USB Serial Converter
support                                                                         
#                                                                                                      
# CONFIG_USB_SERIAL is not
set                                                                         
                                                                                                       
#                                                                                                      
# USB Miscellaneous
drivers                                                                            
#                                                                                                      
# CONFIG_USB_TIGL is not
set                                                                           
# CONFIG_USB_AUERSWALD is not
set                                                                     
# CONFIG_USB_RIO500 is not
set                                                                         
# CONFIG_USB_BRLVGER is not
set                                                                        
# CONFIG_USB_LCD is not
set                                                                            
# CONFIG_USB_TEST is not
set                                                                           
# CONFIG_USB_GADGET is not set    


