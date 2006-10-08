Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWJHDIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWJHDIB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 23:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWJHDIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 23:08:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:21152 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750768AbWJHDIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 23:08:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PqdhpEBhbY90GaqZnEF0XwzefcowX84/LUosPa4KxK7mXYSPgvfRIMDM8EDoV0FD3qP8Z0V/2pSlsIbHwLlzAKA0spUB+W4FltRUoMarevBeAvKS9wNkyJjxaAb97oAFX48o0yP90YW7rzwGtVmDGCcNnBTpfs8bLNjc0+O3zgU=
Message-ID: <45286B85.90402@gmail.com>
Date: Sun, 08 Oct 2006 11:07:49 +0800
From: "raise.sail@gmail.com" <raise.sail@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Randy Dunlap <rdunlap@xenotime.net>, LKML <linux-kernel@vger.kernel.org>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       greg <greg@kroah.com>
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.3.2 (core)
References: <200609291624123283320@gmail.com>	 <20060929095913.f1b6f79d.rdunlap@xenotime.net> <d120d5000609291035q7dad5f7fqcb38d4d8b3b211e5@mail.gmail.com>
In-Reply-To: <d120d5000609291035q7dad5f7fqcb38d4d8b3b211e5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> I re-read these patches again and the main problem with the current
> implementation is that it alters input devices's properties after
> device has been registered and presented to userspace. That means that
> hotplug users that presently can inspect device's capabilities and
> decide if they are "interested" in device will not be able to do so
> anymore. For example I think X event interface drivers examine input
> devices and decide if it should be handled by as keyboard or pointing
> device so it is possible for them to not notice that touchpad
> capabilities were added to a keyboard later. For now the only thing
> that is allowed to change after device has been registered is keymap.
>
> Then there is issue with automatic loading of these sub-drivers. How
> do they get loaded? Or we force everything to be built-in making HID
> module very fat (like psmouse got pretty fat, but with HID prtential
> for it to get very fat is much bigger).
>
> The better way would be to split hid-input into a library module that
> parses hid usages and reports and is shared between device-specific
> modules that are "real" drivers (usb-drivers, not hid-sub-drivers).
>
I am sorry this reply so late, because of I had holiday for the National
Day.

Well, however, I don't think this is problem. ~_~

All troubles are come from between the generic driver and the specific
driver. Let me use
some words to explain both in my mind. First, the generic driver, for
instance, some
chipsets or some kinds of device driver, it let us use the common
feature of device. but may
be not complete, because of some devices may have some advanced
features, or more powerful
implementation. The other task of the generic driver is support API for
the specific
driver. Second, the specific driver, it base on the generic driver, use
the service that
is supplied by the generic driver, this let us some advanced feature
that the generic
driver can not support. Moreover, this architecture must not be two
layers: it can stack
into more layers. Use HID subsystem as one example, the hid-core can be
as the generic driver
for the hid-input, hid-input can be see as the specific driver that use
hid-core. The next layer,
The hid-input can be as the generic driver for usbnek4k.

And, I think the library module of design is not the best solution, The
library module, it can not
activate one kernel control path by itself, The most problem of this
design is it let some simple
device have rather complex driver. I think the generic driver frame of
design is good choice.

So, I think, the role of hid-input should support such interface for
other devices, not split out as one library module.

May be, I have some wrongs, please correct me, thanks.

PS:

    I apologized for wrote last email too hurry to lost some words for
Vincent Legoll in the announcement.

Goodluck.

-Liyu
