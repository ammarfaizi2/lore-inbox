Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVL0XUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVL0XUE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 18:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVL0XUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 18:20:03 -0500
Received: from mail.gmx.de ([213.165.64.21]:57313 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932376AbVL0XUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 18:20:01 -0500
X-Authenticated: #556111
Date: Wed, 28 Dec 2005 00:19:31 +0100
From: Sebastian Reichelt <SebastianR@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: TerraTec MIDI HUBBLE USB quirk
Message-Id: <20051228001931.3cd9b044.SebastianR@gmx.de>
X-Mailer: Sylpheed version 1.9.12 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__28_Dec_2005_00_19_31_+0100_QZi/YX+O.EFfiM+a"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Wed__28_Dec_2005_00_19_31_+0100_QZi/YX+O.EFfiM+a
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

The TerraTec MIDI HUBBLE USB device provides two MIDI IN and OUT ports, 
but it seems to lack the correct interface class value (see attached 
output of lsusb -v). I thought this could be fixed by adding the 
following to sound/usb/usbquirks.h:

{
        USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0032),
        .driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
                .vendor_name = "TerraTec Producer",
                .product_name = "MIDI HUBBLE",
                .ifnum = 0,
                .type = QUIRK_MIDI_STANDARD_INTERFACE
        }
},

But the USB subsystem still doesn't know it can use the snd_usb_audio 
driver for this device (e.g. shown by usbmodules), and it is not 
registered as an ALSA card. Is there anything I have to do in addition 
to this, or did I do something wrong? The files modules.alias and 
modules.usbmap got updated correctly, but I don't know who reads them 
at what time.

The strangest thing is that it worked on one day, even though I had not 
done anything special yet.

I hope you can help me. Thank you very much in advance.

BTW: I thought about posting this in the linux-sound mailing list, but 
it seems to be dead. Posts are almost never answered, including a post 
I made about a solution to another sound problem 
(http://marc.theaimsgroup.com/?l=linux-sound&m=113261865703607&w=2). 
(Since then, a few people who have the same problem have contacted me; 
all of them would like the fix to be integrated into the kernel.)

-- 
Sebastian Reichelt

--Multipart=_Wed__28_Dec_2005_00_19_31_+0100_QZi/YX+O.EFfiM+a
Content-Type: text/plain;
 name="hubble.txt"
Content-Disposition: attachment;
 filename="hubble.txt"
Content-Transfer-Encoding: 7bit


Bus 002 Device 003: ID 0ccd:0032 TerraTec Electronic GmbH 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0ccd TerraTec Electronic GmbH
  idProduct          0x0032 
  bcdDevice            1.08
  iManufacturer           1 TerraTec Producer
  iProduct                2 MIDI HUBBLE
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           54
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower               98mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           4
      bInterfaceClass         0 (Defined at Interface level)
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
Device Status:     0x0000
  (Bus Powered)


--Multipart=_Wed__28_Dec_2005_00_19_31_+0100_QZi/YX+O.EFfiM+a--
