Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQKOWfV>; Wed, 15 Nov 2000 17:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129190AbQKOWfM>; Wed, 15 Nov 2000 17:35:12 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:43424 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129210AbQKOWfF>; Wed, 15 Nov 2000 17:35:05 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 15 Nov 2000 14:05:01 -0800
Message-Id: <200011152205.OAA14787@baldur.yggdrasil.com>
To: jgarzik@mandrakesoft.com
Subject: Re: CONFIG_USB_HOTPLUG (was Patch(?): linux-2.4.0-test11-pre4/drivers/sound/yss225.c  compile failure)
Cc: linux-kernel@vger.kernel.org, randy.dunlap@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>"Adam J. Richter" wrote:
>> You were right: the
>> __devinitdata being used in the USB drivers will probably crash the
>> kernel if CONFIG_HOTPLUG is not defined and the USB code attempts to
>> recover from an error by faking disconnect/reconnect.
>[...]
>>         Until there is __usbdev{init,exit}{,data}, the incorrect
>> __devinitdata qualifiers should be removed from the USB device
>> drivers (but not from the host controller drivers, which are PCI drivers).

>If a user hotplugs a device into a kernel which does not support
>CONFIG_HOTPLUG, they are shooting themselves in the foot.

	I have always agreed with that (ultimately, I would have the
non-hot-plug kernel simply ignore hot insert events, which would
make it a bit smaller anyhow).  That was not the scenario I was
warning about.  Please reread this section of the message you
were resonding to:

| __devinitdata being used in the USB drivers will probably crash the
| kernel if CONFIG_HOTPLUG is not defined and the USB code attempts to
| recover from an error by faking disconnect/reconnect.

	It has nothing to do with the user physically trying
to do hot plugging.


>I don't see that __devinitdata should be removed.

	The reason that __devinitdata should be removed from
the USB drivers (or replaced with __usbdevinitdata) is that
under the status quo, USB storage error recovery code and the
usbdevfs reset code will crash on any non-CONFIG_HOTPLUG kernel
without the user doing anything wrong.


>*plonk*

	I expect an apology for that.


Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
