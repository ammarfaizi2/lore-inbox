Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268898AbRHPVpY>; Thu, 16 Aug 2001 17:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268900AbRHPVpO>; Thu, 16 Aug 2001 17:45:14 -0400
Received: from archive.osdlab.org ([65.201.151.11]:56752 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S268898AbRHPVo5>;
	Thu, 16 Aug 2001 17:44:57 -0400
Message-ID: <3B7C3DC4.1DE74EF8@osdlab.org>
Date: Thu, 16 Aug 2001 14:40:20 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sarada prasanna <csaradap@mihy.mot.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: _IOR('t',90,int)
In-Reply-To: <C1590740235CD211BA5600A0C9E1F6FF02602296@hydmail.mihy.mot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sarada prasanna wrote:
> 
> Hi friends,
>           While reading a source code of pppd i came across a macro
> declaration like
> 
> #define PPPIOCGFLAGS    _IOR('t', 90, int)      /* get configuration flags
> */
> 
> I refered to the book called "Linux kernel internals by Beck and others" and
> on
> the page 219 (chap implementing a device driver) i found out the line
> telling
> 
> _IOR(c,d,t)   for commands which write back to the user address space a
> value of
>               the C type t
> 
> but still i am not being able to understand the macro declaration. Can
> someone kindly tell me about the _IOW
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A better reference would be "Linux Device Drivers", 2nd edition.
See http://www.xml.com/ldd/chapter/book/ch05.html#t1 for info
on I/O controls.  (search for /_IOR/ or /_IOW/ for example)

In general, _IOR() and _IOW() take 3 parameters and make a
number out of them.  That number is used in a driver's ioctl
function to decide what the request is, its direction (in or out),
its data type, and data size.

For example, on x86, _IOR and _IOW make a 32-bit number, used as:

  |dd|ssssssssssssss|tttttttt|nnnnnnnn|
   |    \-size        \-type  \-number
   \-direction

Size is limited to 14 bits; Direction is Read, Write, or None.
Type is usually (meant to be) a constant for any one driver,
such as 'T' for ttys, 'S' for SCSI, 'M' for MTRR driver,
'A' for APM, 'a' for ATM, 0x93 for autofs, 'C' for CAPI,
'B' for CCISS, 's' for cdk, 'c' for coda, 'd' for devfsd,
0x89 for DECNET, 'f' and 'v' for ext2/3, 'F' for frame buffer,
2 for floppy driver, 0x12 for block layer, 'H' for HID driver,

Is there a registry of IOCTL magic numbers?  Yep, see
linux/Documentation/ioctl-number.txt for more info and numbers.

See linux/include/asm-i386/ioctl.h for macro specifics.

-- 
~Randy
