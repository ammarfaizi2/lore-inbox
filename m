Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKOI3K>; Wed, 15 Nov 2000 03:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129665AbQKOI3B>; Wed, 15 Nov 2000 03:29:01 -0500
Received: from [209.249.10.20] ([209.249.10.20]:18670 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129045AbQKOI2q>; Wed, 15 Nov 2000 03:28:46 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 14 Nov 2000 23:58:44 -0800
Message-Id: <200011150758.XAA01802@adam.yggdrasil.com>
To: jgarzik@mandrakesoft.com
Subject: Re: Patch(?): linux-2.4.0-test11-pre4/drivers/sound/yss225.c compilefailure
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>"Adam J. Richter" wrote:
>>         If a programmer errs in favor of __devinit, the result is
>> extra memory consumption under CONFIG_HOTPLUG.  If a programmer
>> errs in favor of __init, the result is a crash during hot p
>> ug insertion.  Avoiding crashes at the expensive of a pretty small
>> amount of memory usage is the more "conservative" way to err.

>You suggest avoiding correctness in order to protect against dumb
>programmers.  That path leads to Windows.

	No, I was saying that if you are unsure whether to use
__devinit{,data} or __init{,data}, using __dev version more closely
fulfulls your request that we "Please err on the conservative side."

	 If you are sure of the correct one to use, then, of
course, I am sure we all agree you should use it.

>>         Having USB hot plugging without needing to build in PCI
>> hot plugging is useful,

>Of course.  But CONFIG_HOTPLUG does not mean PCI hotplugging.  It means
>any hotplug support in the kernel.  That is why __devinit exists and is
>used in a generic fashion.

	Could you please cite an example or two of where __devinit
is currently correctly used for a non-PCI non-USB device?  I think you
can skip the places in the ISA parallel port code where it is apparently
being incorrectly used (where some non-hot-pluggable ISA code that could
safely be freed will be retained if the kernel is compied with
CONFIG_HOTPLUG).

	Earlier in your email, you made an argument about the
development culture ("That path leads to Windows").  In that
same spirit, let's not rely on bureaucratic doctrines like "But
CONFIG_HOTPLUG does not mean..." and, instead, let's look at
the underlying technical issues, which I believe are:

	       1. there is essentially no call graph dependency between
		  the hot plugging mechanisms of different busses,

	       2. we agree that having USB hot plugging without needing
		  to build in PCI hot plugging is useful.

>>         After 2.4.0, [...] we may
>> want to explore adding __usbdevinit{,data} defines in include/linux/init.h
>> that would be controlled by a new CONFIG_USB_HOTPLUG option, as in
>> the patches that I posted for this to linux-usb-devel.

>This is not just a USB issue.  Please discuss this on linux-kernel, so
>we can have a coherent hotplug strategy for the entire kernel.

>If we are going to create CONFIG_USB_HOTPLUG, we must -eliminate-
>CONFIG_HOTPLUG, and create CONFIG_PCI_HOTPLUG, and
>CONFIG_ANOTHERBUS_HOTPLUG and so on, for each hotplug bus.

	s/must/should/  (since you are not changing the resulting binary)

	I agree that CONFIG_HOTPLUG should be renamed CONFIG_PCI_HOTPLUG
and I would further like to see __devinit{,data} become __pcidevinit{,data}.
Not only does this configurability have real world uses, but the clearer
labelling would also make the effected code a little more self documenting
as to why the code and data in question is not just __init{,data}.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
