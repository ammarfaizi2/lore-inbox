Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVBAViV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVBAViV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 16:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVBAViV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 16:38:21 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:4757 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262129AbVBAVhy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 16:37:54 -0500
Subject: Re: Patch to add usbmon
From: Marcel Holtmann <marcel@holtmann.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050201095526.0ee2e0f4@localhost.localdomain>
References: <20050131212903.6e3a35e5@localhost.localdomain>
	 <20050201071000.GF20783@kroah.com>
	 <20050201003218.478f031e@localhost.localdomain>
	 <1107256383.9652.26.camel@pegasus>
	 <20050201095526.0ee2e0f4@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 22:37:50 +0100
Message-Id: <1107293870.9652.76.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,

> > By accident I removed the debugfs option from my kernel config and this
> > makes usbmon totally useless. So I think the module approach is wrong
> > from my point of view. Why not compile it always and if debugfs is
> > available, then enable it when the usbcore gets loaded?
> 
> This may be a good idea, but I'm too lazy to think in trinary. Care to
> send a patch?

I can do this if you think that this is a good idea. Acutally I see
usbmon as an option of the USB core. This will also reduce the code a
little bit, because you don't need an registration interface. You can
call the usbmon functions directly.

> > And btw don't you think that you split your code into too much separate
> > files? I count less than 900 lines of code.
> 
> What does it hurt? I think the split was rather clean, along well defined
> functional lines, with minimum dependencies. They may even be separate
> modules later.

I think that separation is a good idea, but dividing such a minimum code
into four files didn't make it cleaner. Two much separation makes it
even worse and sometimes harder to understand. I personally vote for
having a single driver/usb/core/usbmon.c and link it into usbcore if
selected.

> > However it works fine for me, but I can't find a document that describes
> > the information (without looking at the code) you get, when running cat
> > on a specific bus.
> 
> I'm sorry about that. I will add a file in Documentation/ .

This would be great and btw the official mount point for debugfs should
be /sys/kernel/debug as Greg posted some time ago.

> > control urb endpoint 0x00 flags 0x00 buflen 3 actlen 0
> > bRequestType 0x20 bRequest 0x00 wValue 0 wIndex 0 wLength 3
> > pipe 0x80003900 flags 0x00 buffer f7f2e4e0 length 3 setup f64895a0 start 0 packets 0 interval 0
> > data 36 fc 00
> 
> You are right, the current text format (0t) is not easily readable.
> 
> My plan calls for the parsing of control messages and things like SCSI
> commands to be placed in user mode applications, like USBMon. This is how
> tcpdump and Ethereal operate. I don't like to keep too much of this in
> kernel. Do you think it's a wrong approach?

I think if cat is the prefered tool for viewing this file then it should
be more human readable. If not, then a binary format should be choosen.
Maybe we can implement both. Is this possible?

> > [...] I think it makes sense to present the device number of that device.
> 
> When I read dumps, I mentally fetch the device number from the pipe.
> Just use that for now, please.

I don't, because I need to check the encoding in the kernel source to do
that. I also think that we should abstract from the definition of pipe.
>From my view this is a kernel encoding and should not be visible to the
user. Maybe I am wrong, because I am not an expert of USB internals.

> But if you or someone else were to hack on something like usbdump(1),
> it would be peachy, I think.

I can start with usbdump if we agree on an interface. I personally would
prefer a binary interface for that.

Regards

Marcel


