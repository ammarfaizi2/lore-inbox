Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVBALNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVBALNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 06:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVBALNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 06:13:25 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:13458 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261989AbVBALNT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 06:13:19 -0500
Subject: Re: Patch to add usbmon
From: Marcel Holtmann <marcel@holtmann.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050201003218.478f031e@localhost.localdomain>
References: <20050131212903.6e3a35e5@localhost.localdomain>
	 <20050201071000.GF20783@kroah.com>
	 <20050201003218.478f031e@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 12:13:03 +0100
Message-Id: <1107256383.9652.26.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,

today I just thought to give usbmon a try. Previously I used a hacked
devio thing around usbfs_snoop to monitor the USB communication between
a VMware and the Linux host.

Greg, will such patch accepted for inclusion or will usbfs_snoop go away
when usbmon is included?

> > First off, why make usbmon a module?  You aren't allowing it to happen,
> > so just take out the parts of the patch that allow it.
> 
> No, I do allow it. This way I can load and unload it when debugging it.
> Perhaps in the future we may simply link it with usbcore, but for now
> it is a separate module. Also, I do not think it's possible not to build
> it as a module when usbcore is a module.
> 
> I do not think it's a good idea for most users to build it as a module,
> but it's not prohibited.

By accident I removed the debugfs option from my kernel config and this
makes usbmon totally useless. So I think the module approach is wrong
from my point of view. Why not compile it always and if debugfs is
available, then enable it when the usbcore gets loaded?

And btw don't you think that you split your code into too much separate
files? I count less than 900 lines of code.

However it works fine for me, but I can't find a document that describes
the information (without looking at the code) you get, when running cat
on a specific bus. I think for using cat this format should be a lot
more easier to read by humans. With my devio patch I used something
like:

control urb endpoint 0x00 flags 0x00 buflen 3 actlen 0
bRequestType 0x20 bRequest 0x00 wValue 0 wIndex 0 wLength 3
pipe 0x80003900 flags 0x00 buffer f7f2e4e0 length 3 setup f64895a0 start 0 packets 0 interval 0
data 36 fc 00

Especially the information about endpoint, type of the URB and the data
should be presented in a better way. I would insert a space after each
byte of data to make it easier to read. Instead of using the URB pointer
for the id, I think it makes sense to present the device number of that
device. If you have multiple devices on the bus you can differ between
them.

Only my 2 cents. Keep on the good work. I really like it and it will
become very handy to me, I think.

Regards

Marcel


