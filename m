Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWI3HpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWI3HpK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 03:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWI3HpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 03:45:10 -0400
Received: from main.gmane.org ([80.91.229.2]:5279 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751118AbWI3HpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 03:45:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?B=E1r=F0ur_=C1rantsson?= <spam@scientician.net>
Subject: USB resets with Nokia 6131 in Data Storage mode
Date: Sat, 30 Sep 2006 09:38:17 +0200
Message-ID: <efl6t9$edg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 0x5731d08c.bynxx18.adsl-dhcp.tele.dk
User-Agent: Thunderbird 1.5.0.7 (X11/20060919)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm having some problems using a Nokia 6131 in 'Data Storage' mode, i.e. 
when it acts as a USB mass storage device. This is with a Gentoo patched 
kernel 2.6.18, but AFAICT there are no patches against the USB subsystem 
in Gentoo's version of the kernel.

The symptoms: The system scans the partitions fine, I can mount the 
device and see the directory contents fine, but when I try to actually 
transfer files the USB subsystem seems to be doing bus resets 
continually until either of the sides simply gives up; I think it may be 
the phone that simply goes out of data storage mode into normal mode 
after a number of resets (or a fixed amount of time with no data transfer).

I've done a run with all the above steps with USB mass storage verbose 
debug enabled, the log can be retrieved from here:

    http://imada.sdu.dk/~bardur/usb-storage.log.gz

The thing I that my untrained eye noticed was that most of the small 
transfers seem to succeed (at least before the bus resets kick in), 
while all the large transfers fail. This of course explains why reading 
the partition table and directory contents works.

Here's the phone's lsusb -v data:

> Bus 002 Device 004: ID 0421:047c Nokia Mobile Phones
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x0421 Nokia Mobile Phones
>   idProduct          0x047c
>   bcdDevice            3.70
>   iManufacturer           1 Nokia
>   iProduct                2 Nokia 6131
>   iSerial                 3 359390005710019
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           32
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xc0
>       Self Powered
>     MaxPower                8mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass         8 Mass Storage
>       bInterfaceSubClass      6 SCSI
>       bInterfaceProtocol     80 Bulk (Zip)
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0

(I should note that the product ID changes to 0x47b when the phone is 
NOT in data storage mode just in case it matters.)

Does anyone have any clues to impart or anything I can try to make it work?

-- 
Bardur Arantsson
<bardurREMOVE@THISscientician.net>

- Sometimes it's hard to see your own face without a mirror.
                                              Dr. Phil, 'Dr. Phil'

