Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285062AbSAGSzt>; Mon, 7 Jan 2002 13:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285099AbSAGSzm>; Mon, 7 Jan 2002 13:55:42 -0500
Received: from daytona.gci.com ([205.140.80.57]:33801 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S285062AbSAGSzY>;
	Mon, 7 Jan 2002 13:55:24 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA31506DB4618@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Dylan Egan <crack_me@bigpond.com.au>, Greg KH <greg@kroah.com>,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: RE: 2.4.17 - hanging due to usb
Date: Mon, 7 Jan 2002 09:55:15 -0900 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dylan,

It looks like you're using an H45 technologies USB->IDE adapter (or equiv).
At least, that's the exact same vendor/product that i've got on mine.

This doesn't work with any 2.4 kernel right now.  There's no
information for this device in drivers/usb/storage/unusual_devs.h

There's been some work on the usb-storage.c file, which may help
out once it's completed.

in the mean time, you can add these lines to
drivers/usb/storage/unusual_devs.h
manually, and get a little closer to using this.  (I'm going to use this
interface with my MSN companion. w00t!)

This is from memory, but around line 90, add:

UNUSUAL_DEV( 0x04ce, 0x0002, 0x0200, 0x0260,
	"ScanLogic", 
	"H45/ScanLogic USB-IDE",
	US_SC_SCSI, US_PR_BULK, NULL, US_FL_FIX_INQUIRY),

Leif

> -----Original Message-----
> From: Dylan Egan [mailto:crack_me@bigpond.com.au]
> Sent: Sunday, January 06, 2002 10:12 PM
> To: Greg KH; linux-kernel@vger.kernel.org;
> linux-usb-devel@lists.sourceforge.net
> Subject: Re: 2.4.17 - hanging due to usb
> 
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=04ce ProdID=0002 Rev= 2.60
> S:  Manufacturer=ScanLogic USBIDE
> S:  Product=ScanLogic USBIDE
> C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
> T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
