Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKOJDP>; Wed, 15 Nov 2000 04:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129148AbQKOJDG>; Wed, 15 Nov 2000 04:03:06 -0500
Received: from [209.249.10.20] ([209.249.10.20]:15489 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129091AbQKOJC4>; Wed, 15 Nov 2000 04:02:56 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 15 Nov 2000 00:32:53 -0800
Message-Id: <200011150832.AAA01842@adam.yggdrasil.com>
To: greg@wirex.com
Subject: Re: Patch(?): linux-2.4.0-test11-pre4/drivers/sound/yss225.c compilefailure
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  = Greg KH
>> = Jeff Garzik


>> I -want- there to be only one hotplug strategy, but Adam seemed to be
>> talking about the opposite, with his CONFIG_USB_HOTPLUG suggestion.

>Here's Adam's proposal for CONFIG_USB_HOTPLUG:
>	http://www.geocrawler.com/lists/3/SourceForge/2571/250/4599696/

Thanks, Greg!


>>From what I remember (and from looking at this message), all he seems to
>want is to redefine the __init and __initdata macros depending on a
>config item.  There's no other grander scheme of things, right Adam?

	Yes, I would have __usbdev{init,exit}{,data} be defined based
on CONFIG_USB_HOTPLUG.

>Although such a small memory savings for turning a bus whose main goal
>in life is to enable hot plugged devices into a fixed connection doesn't
>seem worth it.
[...]
>Comments Adam?

	There would be more memory savings from tagging all USB
device driver initialization and exit routines with __usbdevinit
and __usbdevexit.

	Although hot plugging is a convenient feature of USB, there 
are plenty of applications of USB that do not use hot plugging.  For
example, imagine some kind of kiosk or internet appliciance that
uses a USB keyboard or camera, because that is the commodity hardware,
but which the user is not able to physically unplug.   Perhaps this
embedded would get cost benefits from a smaller kernel.  That is the
sort of potential use that I can imagine for "CONFIG_USB_HOTPLUG=n".
As I said, I am interested in feedback from potential users of
CONFIG_USB_HOTPLUG=n to determine if anyone would use it or if
it is just an intellectual exercise.

	The part that is more clearly useful is being able to have USB
hot plugging without compiling in PCI hot plugging.  So, CONFIG_HOTPLUG
be CONFIG_PCI_HOTPLUG, or at least should be thought of that way,
regardless of whether CONFIG_USB_HOTPLUG is added.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
