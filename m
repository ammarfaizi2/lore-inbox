Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131813AbRADAvM>; Wed, 3 Jan 2001 19:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131306AbRADAuv>; Wed, 3 Jan 2001 19:50:51 -0500
Received: from ns1.megapath.net ([216.200.176.4]:56582 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S131481AbRADAur>;
	Wed, 3 Jan 2001 19:50:47 -0500
Message-ID: <3A53C8AA.8060103@megapathdsl.net>
Date: Wed, 03 Jan 2001 16:49:46 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12-pre8 i686; en-US; m18) Gecko/20001231
X-Accept-Language: en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Prerelease kernel will not hotplug a USB host-controller when it
	 isinserted into a Cardbus slot.
In-Reply-To: <3A53187B.9030601@megapathdsl.net> <032e01c07595$7be8b8c0$6600000a@brownell.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>> I am writing to let you know that in all test12-pre6+ kernels,
>> I get a "Bad PCI invocation" error when hotplug attempts to
>> handle the insertion of a USB host-controller into a Cardbus
>> slot.
> 
> 
> That's new info ... you'd previously thought that it wasn't even
> invoking /sbin/hotplug!

I fscked up that test.  The results I reported as being with
prerelease were actually with a messed up test11.  The whole
"Bad PCI invocation" error was a red herring, sorry.

I have since gone in a tested test12-pre5, test12-pre6 and
test12-pre8.  test12-pre5 works.  test12-pre6 fails utterly.
It looks like Cardbus was just completely hosed in that
tree, because I can't get my network card (3c575) to be recognized
by that kernel, either.  I checked the patches and Andrew's
"04X" change went into test12-pre8.  I just tested test12-pre8
with both your latest hotplug script, David, and with the
pertinent "0x" locations changed to "04x".  Both scripts fail
to load usb-ohci.

Bottom line, I have yet to see a test12-pre6+ kernel load usb-ohci
whether or not I use "04x" in the hotplug script.  Something else
is messed up here.

> The scripts I know about will produce that message when they're
> invoked without PCI_CLASS set.  That's a sanity check which was
> needed for the intial PCI hotplug support, which wouldn't pass
> that info -- needed to hotplug devices using class drivers, such
> as USB host controllers.
> 
> But they'll also dump all the arguments and environment of
> hotplug before they get that far, if you set DEBUG=yes; please
> enable that and let us know the whole environment that's getting
> passed !

For the Cardbus hotplug event, is it expected that the hotplug
debug info would be dumped after the insert event is processed
and the required driver is loaded?

With test12-pre5, I get this when I insert the BusPort Mobile:

Jan  3 15:00:15 agate kernel: cs: cb_alloc(bus 5): vendor 0x1045, device 
0xc861 Jan  3 15:00:15 agate kernel:   got res[11000000:11000fff] for 
resource 0 of PCI device 1045:c861
Jan  3 15:00:15 agate kernel: PCI: Enabling device 05:00.0 (0000 -> 0002)
Jan  3 15:00:15 agate kernel: PCI: Found IRQ 11 for device 05:00.0
Jan  3 15:00:15 agate kernel: PCI: The same IRQ used for device 00:04.0
Jan  3 15:00:15 agate kernel: PCI: Setting latency timer of device 
05:00.0 to 64
Jan  3 15:00:15 agate kernel: usb-ohci.c: USB OHCI at membase 
0xc5850000, IRQ 11
Jan  3 15:00:15 agate kernel: usb-ohci.c: usb-05:00.0, PCI device 1045:c861
Jan  3 15:00:15 agate kernel: usb.c: new USB bus registered, assigned 
bus number 1
Jan  3 15:00:15 agate kernel: Product: USB OHCI Root Hub
Jan  3 15:00:15 agate kernel: SerialNumber: c5850000
Jan  3 15:00:15 agate kernel: hub.c: USB hub found
Jan  3 15:00:15 agate kernel: hub.c: 2 ports detected
Jan  3 15:00:16 agate /sbin/hotplug: arguments (usb) env (TYPE=9/0/0 
ACTION=add DEVFS=/proc/bus/usb TERM=dumb DEVICE=/proc/bus/usb/001/001 
HOSTTYPE=i386 PATH=/bin:/sbin:/usr/sbin:/usr/bin HOME=/ SHELL=/bin/bash 
DEBUG=kernel OSTYPE=Linux PRODUCT=0/0/0 SHLVL=1 _=/usr/bin/env)

Thanks and sorry for the inaccurate info last night.

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
