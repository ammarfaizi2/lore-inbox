Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbTD3AcO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 20:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbTD3AcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 20:32:14 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:35717 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S261231AbTD3AcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 20:32:13 -0400
Message-Id: <5.1.0.14.2.20030429152151.10dc8db0@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 29 Apr 2003 17:44:21 -0700
To: Greg KH <greg@kroah.com>, oliver@neukum.name
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluetooth] HCI USB driver update. Support for SCO over
  HCI USB.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20030429214004.GA8891@kroah.com>
References: <200304292334.19447.oliver@neukum.org>
 <200304290317.h3T3HOdA027579@hera.kernel.org>
 <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com>
 <20030429211550.GA8669@kroah.com>
 <200304292334.19447.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:40 PM 4/29/2003, Greg KH wrote:
>On Tue, Apr 29, 2003 at 11:34:19PM +0200, Oliver Neukum wrote:
>> 
>> > +int usb_init_urb(struct urb *urb)
>> > +{
>> > +   if (!urb)
>> > +           return -EINVAL;
>> > +   memset(urb, 0, sizeof(*urb));
>> > +   urb->count = (atomic_t)ATOMIC_INIT(1);
>> > +   spin_lock_init(&urb->lock);
>> > +
>> > +   return 0;
>> > +}
>> 
>> Greg, please don't do it this way. Somebody will
>> try to free this urb. If the urb is part of a structure
>> this must not lead to a kfree. Please init it to some
>> insanely high dummy value in this case.
Uh, I didn't think about that one. This stuff was first implemented 
for 2.4 which didn't have refcount in urb and then forward ported to 2.5.

>We can't init it to a high value, if we want to use it ourself in
>usb_alloc_urb().
>
>And yes, I agree this is a very dangerous function to use on your own,
>I thought I conveyed that in the documentation for the function.
>
>But if we don't have such a function, then people like Max will just
>roll their own, like he just did :)
>
>Might as well make it easy for him to shoot himself in the foot if he
>really wants to...
Thanks. I'll wear bullet proof shoes, just in case :-).

Max

