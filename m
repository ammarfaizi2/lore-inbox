Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFAtD>; Fri, 5 Jan 2001 19:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAFAsx>; Fri, 5 Jan 2001 19:48:53 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:18948 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129324AbRAFAsk>; Fri, 5 Jan 2001 19:48:40 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDEBE@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'antirez@invece.org'" <antirez@invece.org>
Cc: Greg KH <greg@wirex.com>, Heitzso <xxh1@cdc.gov>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Johannes Erdfelt'" <johannes@erdfelt.com>
Subject: RE: USB broken in 2.4.0
Date: Fri, 5 Jan 2001 16:48:00 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This rings a small bell with me.
There was a change by Dan Streetman IIRC to limit
usbdevfs bulk transfers to PAGE_SIZE (4 KB for x86,
or 0x1000).  Anything larger than that returns
an error (-EINVAL).

~Randy
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------

> -----Original Message-----
> From: antirez [mailto:antirez@invece.org]
> Sent: Friday, January 05, 2001 6:40 PM
> To: antirez
> Cc: Greg KH; Heitzso; 'linux-kernel@vger.kernel.org'; 
> 'Johannes Erdfelt'
> Subject: Re: USB broken in 2.4.0
> 
> 
> On Sat, Jan 06, 2001 at 12:04:29AM +0100, antirez wrote:
> > I'll do some test with the new 2.4 kernel to find if there 
> is a problem
> > in s10sh itself. A good test can be to try if the equivalent driver
> > of gphoto works without problems using the 2.4 kernel 
> (however it also
> > uses the libusb). The s10sh bug may be not necessarly 
> related to the USB
> > subsystem.
> 
> Ok, the problem is the same that I ecountered developing the file
> upload for the powershot USB driver performing a bulk write with
> a big data size, but this time it is present even reading.
> 
> s10sh reads 0x1400 bytes at once downloading jpges from the
> digicam, but the ioctl() that performs the bulk read fails with 2.4
> using this size. If I resize it (for example to 0x300) it 
> works without
> problems (with high performace penality, of course, 60% of slow-down).
> I don't know why. I checked at the time of the file upload the kernel
> code finding nothing.
> 
> Anyway with the old releases of the USB subsystem libusb failed to
> initialize the camera some time, now it seems fixed.
> 
> For the users: just edit usb.c and check the function USB_get_data(),
> substituting all the occurrence of 0x1400 to 0x300 as a work-around.
> 
> Please CC: me since I'm not subscribed to the list.
> 
> regards,
> antirez
> 
> -- 
> Salvatore Sanfilippo              |                      
> <antirez@invece.org>
> http://www.kyuzz.org/antirez      |      PGP: finger 
> antirez@tella.alicom.com
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
