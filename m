Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287751AbSAPIMi>; Wed, 16 Jan 2002 03:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289888AbSAPIMb>; Wed, 16 Jan 2002 03:12:31 -0500
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:21234
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S287751AbSAPIMO>; Wed, 16 Jan 2002 03:12:14 -0500
Message-ID: <3C4535D1.8050903@dplanet.ch>
Date: Wed, 16 Jan 2002 09:12:01 +0100
From: Giacomo Catenazzi <cate@dplanet.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Giacomo Catenazzi <cate@debian.org>, Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Autoconfiguration: Original design scenario
In-Reply-To: <3C4401CD.3040408@debian.org> <20020115105733.B994@flint.arm.linux.org.uk> <3C442395.8010500@debian.org> <20020115183432.GC27059@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> On Tue, Jan 15, 2002 at 01:41:57PM +0100, Giacomo Catenazzi wrote:
> 
>>Russell King wrote:
>>
>>
>>
>>>I really don't see why hisax couldn't say "oh, you have an ISDN card with
>>>IDs xxxx:xxxx, that's hisax type nn" and be done with it, rather than
>>>needing to be told "pci id xxxx:xxxx type nn".  Have a look at
>>>drivers/isdn/hisax/config.c and wonder how the hell you take some random
>>>vendors PCI ISDN card and work out how to drive it under Linux.
>>>
>>>(For the record, the card was:
>>>  1397:2bd0       - Cologne Chip Designs GmbH - HFC-PCI 2BD0 ISDN
>>>and the driver requirements were:  hisax type 35 proto 2)
>>>
>>>Realistically, I don't think any autoconfigurator will solve such cases
>>>until these areas can be fixed up reasonably.
>>>
>>
>>Autoconfigure cannnot solve this.
>>The card is not in my database.
>>To help user, you should tell the driver maintainer to add our card
>>in the know pci devices. In this manner autoconfigure, hotplug and
>>modutils can take easy use your card.
>>
> 
> The hisax driver already has a MODULE_DEVICE_TABLE entry for it's pci
> devices, and this data shows up in the modules.pcimap table in the
> modules directory.
> 
> Russell, when /sbin/hotplug is part of the initramfs in 2.5, the driver
> will automatically be loaded for your new card, IF you have all the
> different modules already built.  You will not need autoconfigure, just
> a good vendor kernel :)


You should read better the mail of Russell.
Russel should give special parameter, because the card IS NOT
in MODULES_DEVICE_TABLE.

We need good MODULES_DEVICE_TABLE. Autoconfigure and hotplug
need correct and complete MODULED_DEVICE_TABLES.

(The card is 1397:2bd0)

> 
> Giacomo, please, please, please, just use the info in the
> MODULE_DEVICE_TABLE entries for your autoconfigure program.  Don't try
> to keep all of this data up to date by hand, just use the info that is
> already in the kernel.  It is a battle you will always loose.  Automate
> this process (David Brownell has made a proposal that will work for
> you), and you will never have to generate those PCI and USB tables by
> hand again.


IIRC I've already told you that I generated the list in a semi-automated
way. But MODULE_DEVICE_TABLE is not complete. The ide controller use a
different procedure.
Until enought drivers (IDE controller are important) will use the
pci_device_id, I will maintain also other kind of pci detection.
Unfortunatelly these are less accurate: sometime drivers check for
PCI controller/moptherboard for workaround. And my tools don't know
about 'right' cards and workorund driver detections.

 
> One other autoconfigure problem that I don't think anyone has mentioned,
> USB devices that only show up when they want to transfer data to/from
> the host.  Like all of the Palm based devices.  They don't stay
> connected long enough for a "probe all the busses" tool like
> you are currently developing to detect.


This ia a problem.
In my design: I detect mouse and other important USB devices,
and let user to select other devices.
In Eric design: the USB devices are automatically set to 'm' if
we found a USB controller.

 
Yes, it is a problem. Thus we cannot make 'autoconfiguration in

one key touch/mouse click'
I will think more about this problem in next days.


		giacomo



