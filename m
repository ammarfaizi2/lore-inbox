Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264301AbTCXVh5>; Mon, 24 Mar 2003 16:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264431AbTCXVh5>; Mon, 24 Mar 2003 16:37:57 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:48102 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S264301AbTCXVh4>; Mon, 24 Mar 2003 16:37:56 -0500
Message-Id: <5.1.0.14.2.20030324134343.075a00d8@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 24 Mar 2003 13:44:22 -0800
To: Greg KH <greg@kroah.com>, Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Sleeping in illegal context with 2.5.65-mm2
Cc: linux-kernel@vger.kernel.org, Alexander Hoogerhuis <alexh@ihatent.com>
In-Reply-To: <20030320050537.GA19436@kroah.com>
References: <Pine.LNX.4.44.0303192300410.11075-100000@chaos.physics.uiowa.edu>
 <20030320043931.GC18787@kroah.com>
 <Pine.LNX.4.44.0303192300410.11075-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:05 PM 3/19/2003, Greg KH wrote:
>On Wed, Mar 19, 2003 at 11:03:51PM -0600, Kai Germaschewski wrote:
>> On Wed, 19 Mar 2003, Greg KH wrote:
>> 
>> > > Debug: sleeping function called from illegal context at mm/slab.c:1723
>> > > Call Trace:
>> > >  [<c0119d92>] __might_sleep+0x5f/0x65
>> > >  [<c013a097>] kmalloc+0x88/0x8f
>> > >  [<c0238111>] usb_alloc_urb+0x21/0x51
>> > >  [<f09180bc>] hci_usb_enable_intr+0x20/0xf8 [hci_usb]
>> > 
>> > The call to usb_alloc_urb() here is being done with the GFP_ATOMIC flag,
>> > which is correct.  Do we need to fix up the warning message to prevent
>> > false positives like this from happening?
>> 
>> Not in my tree: (drivers/bluetooth/hci_sb.c)
>> 
>>       if (!(urb = usb_alloc_urb(0, GFP_KERNEL)))
>>               return -ENOMEM;
>
>Doh, nevermind, I was looking at the wrong function, sorry.
>
>> And the function is called in a write_lock_irqsave(), so the complaint is 
>> justified. 
>
>Max, you should probably fix this up.
Will do.

Thanks
Max


