Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKOSQL>; Wed, 15 Nov 2000 13:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQKOSQB>; Wed, 15 Nov 2000 13:16:01 -0500
Received: from [209.249.10.20] ([209.249.10.20]:3219 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S129132AbQKOSPz>;
	Wed, 15 Nov 2000 13:15:55 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 15 Nov 2000 09:45:52 -0800
Message-Id: <200011151745.JAA02400@adam.yggdrasil.com>
To: randy.dunlap@intel.com
Subject: CONFIG_USB_HOTPLUG (was Patch(?): linux-2.4.0-test11-pre4/drivers/sound/yss225.c  compile failure)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From randy.dunlap@intel.com Wed Nov 15 09:04:36 2000
>> From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
>> 
>> Greg KH wrote:
>> > On Wed, Nov 15, 2000 at 12:29:15AM -0500, Jeff Garzik wrote:
>> > > If we are going to create CONFIG_USB_HOTPLUG, we must -eliminate-
>> > > CONFIG_HOTPLUG, and create CONFIG_PCI_HOTPLUG, and
>> > > CONFIG_ANOTHERBUS_HOTPLUG and so on, for each hotplug bus.
>> > 
>> > Argh!
>> > I thought the whole point of this was to make there be only 
>> one hotplug
>> > strategy, due to the fact that this is a real need.
>> > 
>> > Please let's not go down this path.  It was all starting to look so
>> > nice...
>> 
>> I -want- there to be only one hotplug strategy, but Adam seemed to be
>> talking about the opposite, with his CONFIG_USB_HOTPLUG suggestion.

>I told Adam that I didn't want that patch, but it's not
>up to me now.

	You said you wanted to "hold of on CONFIG_USB_HOTPLUG for now",
which I take to mean up to 2.4.0.

	I have not asked that CONFIG_USB_HOTPLUG be put in 2.4.0, although
I would not mind.  I am just agreeing with you (Randy) when you
identified the problem and wrote in linux-usb-devel "[Why] is it safe to
use __devinitdata on the usb_device_id table?  It's used during any new
device connect, after driver init, right ...?"  You were right: the
__devinitdata being used in the USB drivers will probably crash the
kernel if CONFIG_HOTPLUG is not defined and the USB code attempts to
recover from an error by faking disconnect/reconnect.

	The statements about how we might address this issue more
fully have been about in the context of after 2.4.0.  To refresh your
memory, in my first message on this thread I wrote:

|        After 2.4.0, and after the fake disconnect/reconnect code in
         ^^^^^^^^^^^
| drivers/usb/{devio,storage/scsiglue}.c is designed out, then we may
| want to explore adding __usbdevinit{,data} defines in include/linux/init.h
| that would be controlled by a new CONFIG_USB_HOTPLUG option, as in
| the patches that I posted for this to linux-usb-devel. 

	Until there is __usbdev{init,exit}{,data}, the incorrect
__devinitdata qualifiers should be removed from the USB device
drivers (but not from the host controller drivers, which are PCI drivers).

	Would you like to propose a different solution, Randy?

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
