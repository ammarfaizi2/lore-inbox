Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVAWUfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVAWUfy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 15:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVAWUfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 15:35:54 -0500
Received: from weber.sscnet.ucla.edu ([128.97.42.3]:43429 "EHLO
	weber.sscnet.ucla.edu") by vger.kernel.org with ESMTP
	id S261353AbVAWUfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 15:35:07 -0500
Message-ID: <41F40A72.1000400@cogweb.net>
Date: Sun, 23 Jan 2005 12:34:58 -0800
From: David Liontooth <liontooth@cogweb.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cpia@risc.uni-linz.ac.at,
       Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>,
       linux-kernel@vger.kernel.org
Subject: CPIA under 2.6.10-ac8 -- lacking sysfs support?
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a black screen from my Ezonics ez.com usb webcam:

$ xawtv
This is xawtv-3.94, running on Linux/i686 (2.6.10-ac8)
xinerama 0: 1600x1200+0+0
xinerama 1: 1280x854+0+1200
/dev/video0 [v4l]: no overlay support
v4l-conf had some trouble, trying to continue anyway
ioctl: VIDIOCGFBUF(base=(nil);height=0;width=0;depth=0;bytesperline=0): 
Invalid argument
ioctl: 
VIDIOCSPICT(brightness=32768;hue=32768;colour=32767;contrast=32768;whiteness=0;depth=24;palette=RGB24): 
Invalid argument
ioctl: 
VIDIOCSPICT(brightness=32767;hue=32768;colour=32768;contrast=32768;whiteness=0;depth=24;palette=RGB24): 
Invalid argument
ioctl: 
VIDIOCSPICT(brightness=32768;hue=32767;colour=32768;contrast=32768;whiteness=0;depth=24;palette=RGB24): 
Invalid argument
ioctl: 
VIDIOCSPICT(brightness=32768;hue=32768;colour=32768;contrast=32767;whiteness=0;depth=24;palette=RGB24): 
Invalid argument

The directory /proc/cpia exists but is empty, which means cpia-control 
isn't working.
Is this a sysfs issue? dmesg says "Please fix your driver for proper 
sysfs support, see http://lwn.net/Articles/36850/"

Cheers,
Dave


Details:

I'm running Debian sid with kernel 2.6.10-ac8 and

libsysfs1               1.2.0-4        
sysfsutils              1.2.0-4        

$ v4l-conf
v4l-conf: using X11 display :0
dga: version 2.0
mode: 1600x2054, depth=24, bpp=32, bpl=7168, base=0xec000000
/dev/video0 [v4l2]: ioctl VIDIOC_QUERYCAP: Invalid argument
/dev/video0 [v4l]: no overlay support

# dmesg:

cpia: Ignoring new-style parameters in presence of obsolete ones
V4L-Driver for Vision CPiA based cameras v1.2.3
Since in-kernel colorspace conversion is not allowed, it is disabled by 
default now. Users should fix the applic
ations in case they don't work without conversion reenabled by setting 
the 'colorspace_conv' module parameter to
 1<6>USB driver for Vision CPiA based cameras v1.2.3
USB CPiA camera found
videodev: "CPiA Camera" has no release callback.
Please fix your driver for proper sysfs support, see 
http://lwn.net/Articles/36850/
usbcore: registered new driver cpia

# lspci:

0000:00:0b.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 50)
0000:00:0b.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 50)
0000:00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)

# lsusb
Bus 002 Device 004: ID 0553:0002 STMicroelectronics Imaging Division 
(VLSI Vision) CPiA WebCam
Bus 002 Device 003: ID 06bd:0001 AGFA-Gevaert NV SnapScan 1212U
Bus 002 Device 002: ID 0451:1446 Texas Instruments, Inc. TUSB2040/2070 Hub
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 002: ID 046d:c00c Logitech, Inc. Optical Wheel Mouse
Bus 001 Device 001: ID 0000:0000

# lsusb -vvv
Bus 002 Device 004: ID 0553:0002 STMicroelectronics Imaging Division 
(VLSI Vision) CPiA WebCam
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0553 STMicroelectronics Imaging Division (VLSI 
Vision)
  idProduct          0x0002 CPiA WebCam
  bcdDevice            1.00
  iManufacturer           0
  iProduct                1
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           73
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              250mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol    255
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  bytes 0 once
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol    255
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x01c0  bytes 448 once
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol    255
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x02c0  bytes 704 once
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       3
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol    255
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x03c0  bytes 960 once
        bInterval               1

# usbview

USB Camera
Speed: 12Mb/s (full)
USB Version:  1.00
Device Class: 00(>ifc )
Device Subclass: 00
Device Protocol: 00
Maximum Default Endpoint Size: 8
Number of Configurations: 1
Vendor Id: 0553
Product Id: 0002
Revision Number:  1.00

Config Number: 1
    Number of Interfaces: 1
    Attributes: 80
    MaxPower Needed: 250mA

    Interface Number: 0
        Name: cpia
        Alternate Number: 0
        Class: ff(vend.)
        Sub Class: 0
        Protocol: 0
        Number of Endpoints: 1

            Endpoint Address: 81
            Direction: in
            Attribute: 1
            Type: Isoc
            Max Packet Size: 0
            Interval: 1ms

    Interface Number: 0
        Name: cpia
        Alternate Number: 1
        Class: ff(vend.)
        Sub Class: 0
        Protocol: 0
        Number of Endpoints: 1

            Endpoint Address: 81
            Direction: in
            Attribute: 1
            Type: Isoc
            Max Packet Size: 448
            Interval: 1ms

    Interface Number: 0
        Name: cpia
        Alternate Number: 2
        Class: ff(vend.)
        Sub Class: 0
        Protocol: 0
        Number of Endpoints: 1

            Endpoint Address: 81
            Direction: in
            Attribute: 1
            Type: Isoc
            Max Packet Size: 704
            Interval: 1ms

    Interface Number: 0
        Name: cpia
        Alternate Number: 3
        Class: ff(vend.)
        Sub Class: 0
        Protocol: 0
        Number of Endpoints: 1

            Endpoint Address: 81
            Direction: in
            Attribute: 1
            Type: Isoc
            Max Packet Size: 960
            Interval: 1ms

# v4l-info

### video4linux device info [/dev/video0] ###
general info
    VIDIOCGCAP
        name                    : "CPiA Camera"
        type                    : 0x201 [CAPTURE,SUBCAPTURE]
        channels                : 1
        audios                  : 0
        maxwidth                : 352
        maxheight               : 288
        minwidth                : 48
        minheight               : 48

channels
    VIDIOCGCHAN(0)
        channel                 : 0
        name                    : "Camera"
        tuners                  : 0
        flags                   : 0x0 []
        type                    : CAMERA
        norm                    : 0

tuner
ioctl VIDIOCGTUNER: Invalid argument

audio
ioctl VIDIOCGAUDIO: Invalid argument

picture
    VIDIOCGPICT
        brightness              : 32768
        hue                     : 32768
        colour                  : 32768
        contrast                : 32768
        whiteness               : 0
        depth                   : 24
        palette                 : RGB24

buffer
ioctl VIDIOCGFBUF: Invalid argument

window
    VIDIOCGWIN
        x                       : 0
        y                       : 0
        width                   : 352
        height                  : 288
        chromakey               : 0
        flags                   : 0




