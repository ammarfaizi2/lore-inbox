Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVKXQl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVKXQl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVKXQlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:41:55 -0500
Received: from mail.deathmatch.net ([216.200.85.210]:14533 "EHLO
	mail.deathmatch.net") by vger.kernel.org with ESMTP id S932362AbVKXQlz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:41:55 -0500
From: "Bob Copeland" <me@bobcopeland.com>
To: Alan Stern <stern@rowland.harvard.edu>, Bob Copeland <me@bobcopeland.com>,
       linux-kernel@vger.kernel.org, <usb-storage@lists.one-eyed-alien.net>
CC: phil@ipom.com, Andries.Brouwer@cwi.nl
Subject: Re: [usb-storage] Re: [PATCH] usb-storage: Add support for Rio Karma
X-Mailer: NeoMail 1.27
X-IPAddress: 209.86.141.27
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E1EfKA6-00029s-00@hash.localnet>
Date: Thu, 24 Nov 2005 11:41:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 23 Nov 2005, Bob Copeland wrote:
> > +#ifdef CONFIG_USB_STORAGE_KARMA
> > +UNUSUAL_DEV(  0x045a, 0x5210, 0x0101, 0x0101,
> > +		"Rio",
> > +		"Rio Karma",
> > +		US_SC_SCSI, US_PR_BULK, rio_karma_init, US_FL_FIX_INQUIRY),
> 
> Are you sure you need US_SC_SCSI and US_PR_BULK?  Wouldn't US_SC_DEVICE 
> and US_PR_DEVICE be sufficient?
> 
> And do you really need US_FL_FIX_INQUIRY?  Hardly any devices do (maybe 
> none).

Alan, 

Thanks again for your comments.

The Karma does some rather broken things.  If you look at the dump below you'll
see that a lot of fields are just zeroed out, such as the serial number.  There
are obviously wrong things, e.g. the device class and protocols are zero,  but
the interface class is also zero, which is reserved according to the spec.  The
protocol is interpreted as CBI but there are actually no control or interrupt
endpoints.  Thus US_PR_BULK... and maybe US_SC_SCSI, I'll check that.

I set US_FL_FIX_INQUIRY because I have noticed that, on occasion, the unit
would report itself as being either the USB controller or the disk drive
contained within, so instead of "Rio" it says "HitachiXYZ" or "Cypress," and
the device acts funny.  I can only reproduce this rarely on the device, but I
assumed that this flag would help.

T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  8 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=045a ProdID=5210 Rev= 1.01
S:  Manufacturer=Rio
S:  Product=Rio Karma
S:  SerialNumber=0000000000000000
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=usb-storage
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

I freely admit ignorance on many of the fine points on scsi/usb so please
enlighten me as necessary.

-- 
Bob Copeland %% www.bobcopeland.com
