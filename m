Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbUKTXrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUKTXrv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUKTXqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:46:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:23951 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261624AbUKTXYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:24:15 -0500
Message-ID: <419FD192.1040604@osdl.org>
Date: Sat, 20 Nov 2004 15:21:54 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: Stelian Pop <stelian@popies.net>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com
Subject: Re: [PATCH] usb-storage should enable scsi disk in Kconfig
References: <20041119193350.GE2700@deep-space-9.dsnet> <20041119195736.GA8466@infradead.org> <20041119213942.GG2700@deep-space-9.dsnet> <20041119230820.GB32455@one-eyed-alien.net>
In-Reply-To: <20041119230820.GB32455@one-eyed-alien.net>
Content-Type: multipart/mixed;
 boundary="------------010500090309050703030409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010500090309050703030409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matthew Dharm wrote:
> On Fri, Nov 19, 2004 at 10:39:42PM +0100, Stelian Pop wrote:
> 
>>On Fri, Nov 19, 2004 at 07:57:36PM +0000, Christoph Hellwig wrote:
>>
>>
>>>On Fri, Nov 19, 2004 at 08:33:50PM +0100, Stelian Pop wrote:
>>>
>>>>As $subject says, usb-storage storage should automatically enable
>>>>scsi disk support in Kconfig.
>>>>
>>>>Please apply.
>>>
>>>No, it shouldn't.  There's lots of usb storage devices that don't use
>>>sd, as there are lots of SPI/FC/etc.. devices.
>>
>>Indeed, I should have checked more carefully. My bad.
>>
>>Still, it is not obvious that one should go into a completly different
>>config section and manually enable sd support, and I have been bitten
>>by this more than one time.
>>
>>Maybe we should add, just below the 'USB storage' Kconfig option another
>>one, let's say 'SCSI disk based USB storage support', which documentation
>>would talk about 'usb keys, memory stick readers, USB floppy drives etc',
>>which should just be a dummy option selecting  BLK_DEV_SD ?
>>
>>Or perhaps we should add something along the Debian's dpkg 'suggests' rule
>>to Kconfig ? :)
> 
> 
> I get enough e-mail on this topic that we should do something about it.
> We need some sort of 'suggests' rule, or at least some sort of message to
> the user to tell them to enable the high-level drivers.

Until 'suggests' is available, does this help any?
It's tough getting people to read Help messages though.



Add comment/NOTE that USB_STORAGE probably needs BLK_DEV_SD also.
Add a few device types to help text and reformat it.

diffstat:=
  drivers/usb/storage/Kconfig |   15 +++++++++++----
  1 files changed, 11 insertions(+), 4 deletions(-)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

--------------010500090309050703030409
Content-Type: text/x-patch;
 name="usb_sd_comment.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usb_sd_comment.patch"

diff -Naurp ./drivers/usb/storage/Kconfig~usb_comment ./drivers/usb/storage/Kconfig
--- ./drivers/usb/storage/Kconfig~usb_comment	2004-10-18 14:55:28.000000000 -0700
+++ ./drivers/usb/storage/Kconfig	2004-11-20 15:15:10.640398000 -0800
@@ -2,16 +2,23 @@
 # USB Storage driver configuration
 #
 
+comment "NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information"
+
 config USB_STORAGE
 	tristate "USB Mass Storage support"
 	depends on USB
 	select SCSI
 	---help---
 	  Say Y here if you want to connect USB mass storage devices to your
-	  computer's USB port. This is the driver you need for USB floppy drives,
-	  USB hard disks, USB tape drives and USB CD-ROMs, along with
-	  similar devices. This driver may also be used for some cameras and
-	  card readers.
+	  computer's USB port. This is the driver you need for USB
+	  floppy drives, USB hard disks, USB tape drives, USB CD-ROMs,
+	  USB flash devices, and memory sticks, along with
+	  similar devices. This driver may also be used for some cameras
+	  and card readers.
+
+	  This option 'selects' (turns on, enables) 'SCSI', but you
+	  probably also need 'SCSI device support: SCSI disk support'
+	  (BLK_DEV_SD) for most USB storage devices.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called usb-storage.

--------------010500090309050703030409--
