Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVHHI4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVHHI4X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 04:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVHHI4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 04:56:22 -0400
Received: from [202.125.86.130] ([202.125.86.130]:48284 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S1750767AbVHHI4V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 04:56:21 -0400
Subject: RE: Unable to mount the SD card formatted using the DIGITAL CAMREA on Linux box
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Date: Mon, 8 Aug 2005 14:26:18 +0530
Content-class: urn:content-classes:message
Message-ID: <C349E772C72290419567CFD84C26E017042680@mail.esn.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE: Unable to mount the SD card formatted using the DIGITAL CAMREA on Linux box
thread-index: AcWb9lQVBJEjCOgsRWWgzmG86NaEyA==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Erik Mouw" <erik@harddisk-recovery.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Erik & all,

Sorry for the delay in my latest updates. 
I was required to fix the partition problem first.

I have an update in gathering some partition info about in SD cards
formatted in windows and Camera.

I tried printing data from the ox1BE offset of 0th sector on windows
formatted SD card and Camera formatted SD card.

Please see the details below.

Windows SD_0_Sector details at 0x1BE offset
------------------------------------------

bootable 		= 111 	  ( 0x01BE)
beg-chs.heads 	= 116			.
beg-chs.sect 	= 104			.
beg-chs.cylin 	= 101			.
sys-type 		= 114			.
end-chs.heads 	= 32			.
end-chs.sect 	= 109			.
end-chs.cylin 	= 101			.
start sect  	= 778135908		.
n/o sec in part = 1141509631		.


Camera SD_0_Sector details at 0x1BE offset
------------------------------------------

bootable 		= 128
beg-chs.heads 	= 1
beg-chs.sect 	= 26
beg-chs.cylin 	= 0
sys-type 		= 1
end-chs.heads 	= 1
end-chs.sect 	= 96
end-chs.cylin 	= 193
start sect  	= 57
n/o sec in part = 28743

To the surprise of me, the windows partition table data looks corrupted
and the camera created partition table looks tome meaningful. But,
windows SD card mounts and camera SD card fails to mount.

I am planning to get the FAT12 details from the first partition of
camera starting at sector 57 as you can see in the 'start sect'
variable.

Please help me finding a way to fix this.

Thanks & Regards,
Mukund Jampala


>-----Original Message-----
>From: Erik Mouw [mailto:J.A.K.Mouw@its.tudelft.nl]
>Sent: Friday, July 29, 2005 5:56 PM
>To: Srinivas G.
>Cc: kernelnewbies@nl.linux.org
>Subject: Re: Unable to mount the SD card formatted using the DIGITAL 
>CAMREA on Linux box
>
>(don't write to me personally, I do read the list)
>
>On Fri, Jul 29, 2005 at 04:56:43PM +0530, Srinivas G. wrote:
>> We have developed a Block Device Driver to handle the flash media 
>> devices in Linux 2.6.x kernel. It is working fine. We are able to 
>> mount the SD cards that are formatted on Windows systems, but we 
>> unable mount the cards that are formatted using the DIGITAL CAMERA.
>>
>> We have found one thing that the Windows and Digital Camera both are 
>> formatting the SD cards in FAT12 only. But why we are not able to 
>> mount the SD cards on Linux Box that are formatted using the Digital 
>> Camera.
>
>Probably because the camera and linux disagree about the geometry in 
>CHS (cylinder, head, sector) of the flash device.
>
>Each partition table entry contains the start and end CHS of that 
>partition. However, since a flash device (and also modern hard drives) 
>doesn't have a meaningful geometry value, the same information is also 
>encoded in logical sectors (start and size of the partition).
>
>If the logical information is zero, the kernel falls back onto the CHS 
>information in the partition table and has to assume a certain 
>geometry. If that assumption differs from the assumption of the camera,

>the partition boundaries will be wrong and you will not be able to 
>mount the partition directly. However, you can figure out the start of 
>the partition by hand, and use a loop device to get at the correct 
>offset.
>
>
>Erik
>
>--
>Erik Mouw
>J.A.K.Mouw@its.tudelft.nl  mouw@nl.linux.org
