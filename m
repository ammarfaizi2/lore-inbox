Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315627AbSFOW25>; Sat, 15 Jun 2002 18:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSFOW24>; Sat, 15 Jun 2002 18:28:56 -0400
Received: from moutvdomng0.kundenserver.de ([195.20.224.130]:35281 "EHLO
	moutvdomng0.schlund.de") by vger.kernel.org with ESMTP
	id <S315627AbSFOW2z>; Sat, 15 Jun 2002 18:28:55 -0400
Message-Id: <5.0.2.1.2.20020616001036.02a01320@pop.puretec.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sun, 16 Jun 2002 00:28:43 +0200
To: Andries.Brouwer@cwi.nl, garloff@suse.de, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
From: Sancho Dauskardt <sancho@dauskardt.de>
Subject: Re: /proc/scsi/map
Cc: linux-usb-devel@lists.sourceforge.net,
        linux1394-devel@lists.sourceforge.net
In-Reply-To: <UTC200206152154.g5FLsCI23053.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>     Both usb-storage and iee1394-sbp2 know the GUID. It only needs to be
>     communicated..
>
>The usb-storage GUID is just one random item of information.

Why is this 'one random item' ??
For usb-storage devices the GUID is built using Vendor ID & Device ID and 
the device's Serial Nr.

For identification purposes, the serial number is useless without Vendor ID 
& Device ID.
Ofcourse we'll never have a change of creating stable name for devices that 
don't have a serialnr.


>One might wish for much more.
>
>And: this information is already somewhere:
Sure. But
a) not easily readable
b) totall different for FireWire devices
c) race-conditions (reading multiple files).



>% cat /proc/scsi/usb-storage-0/2
>    Host scsi2: usb-storage
>        Vendor: DataFab Systems Inc.
>       Product: USB CF+SM
>Serial Number: 5DC69477C6
>      Protocol: Transparent SCSI
>     Transport: Datafab Bulk-Only
>          GUID: 07c4a1090000005dc69477c6
>      Attached: Yes
Exactly, but finding this out at the moment involves reading: 
/proc/scsi/scsi, scanning /proc/scsi/usb-storage-*, scanning 
/proc/scsi/usb-storage-X/*, reading /proc/scsi/usb-storage-X/Y.


>% cat /proc/scsi/usb-storage-1/3
>    Host scsi3: usb-storage
>        Vendor: SCM Microsystems Inc.
>       Product: eUSB SmartMedia / CompactFlash
>Serial Number: None
>      Protocol: Transparent SCSI
>     Transport: Control/Bulk-EUSB/SDDR09
>          GUID: 04e600050000000000000000
>      Attached: Yes

Well that's just SCM, huh ? The newer SCM-Orca chipset has a S/N.



>Finally, the GUIDs you see here do not determine the LUN.
>So, there is no well-defined line in /proc/scsi/map
>where they would belong.

But the LUN-map for such a device will never change ?
Incase a device has 4 LUN's, well have 4 /proc/scsi/map entries with the 
same GUID.

The hotplug agent will indeed be watching GUID+Lun.

- sda

