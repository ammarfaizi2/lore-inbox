Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287976AbSACAOo>; Wed, 2 Jan 2002 19:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287992AbSACAOh>; Wed, 2 Jan 2002 19:14:37 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18379 "EHLO
	VL-MS-MR001.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S288006AbSACANi>; Wed, 2 Jan 2002 19:13:38 -0500
Message-ID: <3C33A22F.40906@videotron.ca>
Date: Wed, 02 Jan 2002 19:13:35 -0500
From: Roger Leblanc <r_leblanc@videotron.ca>
Organization: General DataComm
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Deadlock in kernel on USB shutdown
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Greg KH" <greg@kroah.com>
To: "Roger Leblanc" <r_leblanc@videotron.ca>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, January 02, 2002 9:40 AM
Subject: Re: Deadlock in kernel on USB shutdown



>> On Tue, Jan 01, 2002 at 04:48:41PM -0500, Roger Leblanc wrote:
>
>>> > Hi,
>>> >
>>> > I just compiled version 2.4.17 of the Linux kernel for my Pentium III.
>>> > It is compiled with modular USB support so I can run my USB scanner (an
>>> > Epson Perfection 1200U).
>>> >
>>> > The scanner works fine but the system freeses when I shut it down. I
>>> > investigated a bit and found that in the file:
>>> > <kernel_root>/drivers/usb/usb.c
>>> > in function:
>>> > usb_disconnect(struct usb_device **pdev)
>>> >
>>> > there is a call to function:
>>> > usbdevfs_remove_device(dev)
>>> > at line 2423.
>>> >
>>> > That is the exact point where it freeses. If I comment out that line,
>>> > everything goes fine. I know! This is not the proper way to fix it! But
>>> > at least, it fixes my problem. Since I'm not a kernel expert, I will
>>> > leave it to you to find the right way to fix it.
>>
>>
>> Does the system lock up when you unload the usbcore module by hand
>> without shutting the system down?
>>
>> Are your init scripts unmounting the usbdevfs filesystem properly before
>> trying to unload the usbcore module?
>
It doesn't get that far. The first thing my init script (or Mandrake 8.1 
script) does at shutdown is to run modprobe -r on modules usb-ohci, 
usb-uhci and uhci. The system freeses when it gets to usb-uhci. It does 
it also if I run these commands on the command line.

Thanks

Roger



