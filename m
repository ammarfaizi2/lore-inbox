Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266536AbUGLAIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266536AbUGLAIz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 20:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266676AbUGLAIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 20:08:55 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:11674 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S266536AbUGLAIu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 20:08:50 -0400
In-Reply-To: <20040626190827.7c919940@lembas.zaitcev.lan>
References: <20040626130645.55be13ce@lembas.zaitcev.lan><20040626201225.GA21
	 49@one-eyed-alien.net> <20040626190827.7c919940@lembas.zaitcev.lan>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Message-Id: <ECBA0960-D397-11D8-AD73-00039398BB5E@ieee.org>
Content-Transfer-Encoding: 7bit
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       USB Storage List <usb-storage@lists.one-eyed-alien.net>,
       tburke@redhat.com, david-b@pacbell.net, arjanv@redhat.com,
       jgarzik@redhat.com
From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [usb-storage] Re: drivers/block/ub.c
Date: Sun, 11 Jul 2004 18:10:47 -0600
To: Pete Zaitcev <zaitcev@redhat.com>
X-Mailer: Apple Mail (2.618)
X-OriginalArrivalTime: 12 Jul 2004 00:08:49.0018 (UTC) FILETIME=[67FD7DA0:01
	C467A4]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:19.78058 C:4 M:6 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> (1) UB only supports direct-access type devices
>> (2) UB only supports 'transparent scsi' devices
>> (3) UB only supports 'bulk-only transport' devices
>
> Yes, ... Someone mentioned on usb-storage list that Windows supports
> two things only without extra drivers: Transparent SCSI over Bulk, and 
> UFI.
> IIRC, it was Pat.

I'd rather say,

Windows since ME/ 2K supports only Bulk USB Storage without 
device-specific software.

Generic USB storage remains generic SCSI over USB no matter whether UFI 
or not, direct access or not, tape or not, etc.

People tell me Apple Mac OS X supports every published spec of USB 
Storage.

Pat LaVarre
http://plavarre.blog-city.com/read/725648.htm

P.S. Same answer, detailed:

--- [1 of 4] Microsoft

x 08 (06|05|02) 50 = bInterfaceClass ...SubClass ...Protocol
is the shipping Microsoft Windows definition of generic USB Storage 
we've seen whenever we actually see C:/Windows/inf/usbstor.inf say 
only:

[Generic]
%GenericBulkOnly.DeviceDesc%=USBSTOR_BULK, 
USB\Class_08&SubClass_02&Prot_50
%GenericBulkOnly.DeviceDesc%=USBSTOR_BULK, 
USB\Class_08&SubClass_05&Prot_50
%GenericBulkOnly.DeviceDesc%=USBSTOR_BULK, 
USB\Class_08&SubClass_06&Prot_50

Translated to English, I guess that plain hex says:

Windows since ME/ 2K supports only Bulk USB Storage without 
device-specific software.

Generic USB storage remains generic SCSI over USB no matter whether UFI 
or not, direct access or not, tape or not, etc.

I find talking about this in English gets very confusing quickly 
because USB bInterfaceSubClass is by design partially redundant with 
SCSI PDT.  Also in practice USB FDD mostly say bInterfaceProtocol 
x01/00.  So experimenting with shipped devices does not always clearly 
distinguish which field is causing which effect.

UFI I see as yet another small, mostly binary compatible, variation in 
command set for "direct access" devices that report one of PDT x 0E 07 
04 00 in order to suggest one of RBC/ SBC/ UFI/ SFF 8070i.  (The 
relationships are complex, not one-to-one, e.g. PDT x0E suggests RBC, 
e.g. UFI and SFF 8070i suggest PDT x00.)

--- [2 of 4] Apple

x 08 (06|05|04|03|02|01) (50|01|00) = bInterfaceClass ...SubClass 
...Protocol

may be the definition of generic SCSI over USB that appears in Apple 
Mac OS X.  In English that may mean:

People tell me Apple Mac OS X supports every published spec of USB 
Storage.

--- [3 of 4] Pat LaVarre

x 08 06 50 = bInterfaceClass ...SubClass ...Protocol
is my definition of generic USB Storage i.e. of generic SCSI over USB.

In 1998, I invented the x 06 50 specifically because previously there 
was no other USB storage standard generic enough to solve the thirteen 
cases and read/ write my device at speed (which was 19 * 64 bytes/ms = 
81+ % of a 12 MHz USB 1 FS bus).  Lately the USB committee has 
obsoleted x 08 xx (01|00) except for USB1FS FDD.

As yet I have seen Microsoft specifically recommend x 08 06 50 only for 
USB Flash.

I also hoped to see x 08 06 50 obsolete x 08 (05|02) 50.  I find the 
bInterfaceSubClass of mass storage abominable.  It's redundant to begin 
with and then not formally required to be equal.  Ugh.  I imagine by 
now people are abusing x 08 02 50 to mean DVD/ CD and x 08 05 50 to 
mean HDD/ FDD, no matter that the published text refers only to the 
obsolete and read-only "SFF-8020i, MMC-2 (ATAPI)" and the 
vendor-specific "SFF-8070i".

--- [4 of 4] links

http://www.google.com/search?q=LaVarre+generic+usb+storage
http://members.aol.com/plscsi/tools/usbpnp.html

http://www.google.com/search?q=Pat+LaVarre+generic+usb+storage
http://www.google.com/search?q=bInterfaceSubClass+x01
http://developer.apple.com/hardware/usb/usb_mail/2001/usbmail0601.htm

http://plavarre.blog-city.com/
http://plavarre.blog-city.com/read/614076.htm
http://www.microsoft.com/whdc/device/storage/usbfaq.mspx

---

