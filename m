Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVBAR7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVBAR7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 12:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVBAR6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 12:58:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61885 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262089AbVBARzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 12:55:36 -0500
Date: Tue, 1 Feb 2005 09:55:26 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zaitcev@redhat.com
Subject: Re: Patch to add usbmon
Message-ID: <20050201095526.0ee2e0f4@localhost.localdomain>
In-Reply-To: <1107256383.9652.26.camel@pegasus>
References: <20050131212903.6e3a35e5@localhost.localdomain>
	<20050201071000.GF20783@kroah.com>
	<20050201003218.478f031e@localhost.localdomain>
	<1107256383.9652.26.camel@pegasus>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Feb 2005 12:13:03 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:

> By accident I removed the debugfs option from my kernel config and this
> makes usbmon totally useless. So I think the module approach is wrong
> from my point of view. Why not compile it always and if debugfs is
> available, then enable it when the usbcore gets loaded?

This may be a good idea, but I'm too lazy to think in trinary. Care to
send a patch?

> And btw don't you think that you split your code into too much separate
> files? I count less than 900 lines of code.

What does it hurt? I think the split was rather clean, along well defined
functional lines, with minimum dependencies. They may even be separate
modules later.

> However it works fine for me, but I can't find a document that describes
> the information (without looking at the code) you get, when running cat
> on a specific bus.

I'm sorry about that. I will add a file in Documentation/ .

> control urb endpoint 0x00 flags 0x00 buflen 3 actlen 0
> bRequestType 0x20 bRequest 0x00 wValue 0 wIndex 0 wLength 3
> pipe 0x80003900 flags 0x00 buffer f7f2e4e0 length 3 setup f64895a0 start 0 packets 0 interval 0
> data 36 fc 00

You are right, the current text format (0t) is not easily readable.

My plan calls for the parsing of control messages and things like SCSI
commands to be placed in user mode applications, like USBMon. This is how
tcpdump and Ethereal operate. I don't like to keep too much of this in
kernel. Do you think it's a wrong approach?

> [...] I think it makes sense to present the device number of that device.

When I read dumps, I mentally fetch the device number from the pipe.
Just use that for now, please.

But if you or someone else were to hack on something like usbdump(1),
it would be peachy, I think.

-- Pete
