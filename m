Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbTD2VnL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 17:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTD2VnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 17:43:10 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:54260 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S261878AbTD2VnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 17:43:08 -0400
Message-Id: <5.1.0.14.2.20030429144842.10c95000@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 29 Apr 2003 14:55:17 -0700
To: Greg KH <greg@kroah.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluetooth] HCI USB driver update. Support for SCO over
  HCI USB.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20030429211550.GA8669@kroah.com>
References: <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com>
 <200304290317.h3T3HOdA027579@hera.kernel.org>
 <200304290317.h3T3HOdA027579@hera.kernel.org>
 <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:15 PM 4/29/2003, Greg KH wrote:
>On Tue, Apr 29, 2003 at 01:29:41PM -0700, Max Krasnyansky wrote:
>> >You aren't calling usb_free_urb() as you are embedding a struct urb
>> >within your struct _urb structure.  Any reason you can't use a struct
>> >urb * instead and call the usb core's functions to create and return 
>> >a urb ?
>> I didn't want to do two allocations (one for struct _urb and one for
>> struct urb).
>
>I agree, and understand what you are doing, it makes sense for your case.  
>Just wanted to make sure you were aware of the future danger :)
:)

>> >Otherwise any changes to the internal urb structures, and the
>> >usb_alloc_urb() and usb_free_urb() functions will have to be mirrored
>> >here in your functions, and I know I will forget to do that :)
>> How about 
>
><snip>
>
>Ok, that works for me.  Does the patch below work out for you?
Yep. I'd make it return void though.

I'll fix hci_usb to use usb_init_urb() when your patch get's in.

>> I was actually going to ask you guys if you'd be interested in
>> generalizing this _urb_queue() stuff that I have for other drivers.
>> Current URB api does not provide any interface for
>> queueing/linking/etc of URBs in the _driver_ itself. Things like next,
>> prev, etc are used in the HCD. So if driver submits bunch of different
>> URBs (and potentially multiple URBs of the same type like hci_usb
>> does) it has to implement its own lists, arrays and stuff. I used to
>> use SKBs for URB queues but struct sk_buff is to big for that simple
>> task.
>
>Yes, generalizing that stuff would be nice to have.  Lots of drivers
>have to manage their urbs on their own today, and making that easier to
>do would be a good thing.
Good. I'll reply do Dave's email were he asked for more details.

Thanks. 
Max

