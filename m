Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266604AbUG0UXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266604AbUG0UXC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266605AbUG0UXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:23:00 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:20573 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S266604AbUG0UVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:21:23 -0400
Message-Id: <200407272018.i6RKIiYB028210@falcon10.austin.ibm.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.1
In-reply-to: <41067543.3090003@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IDE/ATA/SATA controller hotplug
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Jul 2004 15:18:44 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Jul 2004 11:31:15 EDT, Jeff Garzik wrote:
>Doug Maxey wrote:
>> Howdy!
>>
>>   This note went out originally to a semi-internal list, but after
>>   several comments, posting it here...
>>
>>   As we chug along here in PPC64 land, we (meaning IBM internal) have
>>   been given a requirement to make all devices on our new DLPAR
>>   (POWER5 and later) systems be hotplug capable.  This includes ALL
>>   PCI devices on the system, even those that are soldered on the
>>   motherboard.
>>
>>   This raises some interesting issues when dealing with IDE devices.
>>
>>   I realize there is considerable work under way (hi Bart :) to clean
>>   up the 2.6 trees.  This hotplug work would be another delta on top
>>   of that work.
>>   The changes could also possibly affect the libata work, as that
>>   could also be touched by work on the attached devices themselves.
>
>Why do you think libata is not already hotplug capable, WRT controllers?

Notice that I did qualify with "possibly".  Am not 100% up to speed on
the libata, although it did appear clean, and I am attempting to get
to total understanding.  My perception at this time is that the PATA
controllers is where the bulk of the work would be needed.  If that is
not true, then great, the kernel is much further along.

Do you have any test cases that are normally run?  Assuming that if
these did it exist, they would be more manually than ant kind of
automated.

>
>
>>   What I would like is input on the general strategy that should be
>>   taken to modify the controller/adapter and device stack to:
>>
>>   1) be first class modules, where all controllers/adapters are
>>      capable of being loaded and unloaded.  This is directed mostly at
>>      IDE/Southbridge controller/adapter devices.
>
>this is already the case in IDE and libata

I would have to differ with you here.  From conversations and fairly
(2 or 3 months ago) experience, the IDE core is not capable of being
unloaded.

>
>
>>   2) extend that support to all child devices; disk, optical,
>>      and tape.
>
>this is already the case in IDE and SCSI

Educational question, what would I be looking for when grokking code
to see this is in place?

>
>
>>   3) be part of mainline.
>
>this is already the case

Yes, the drivers are in the mainline.  Just not sure of how many
platforms will have non-pluggable controllers that need to have them
hot-plugged. :-)

>
>
>>   The items I perceive at the top of the issue list are:
>>
>>   - The primary platforms for IDE/ATA devices are x86 based, and
>>     certainly do not care about having this capability.
>
>incorrect

Ok, please delineate.  Working off the assumption that 95+% of the
systems that run Linux are x86 based, and have a single partition for
the system. In other words, no virtual processors, where each is
totally separate from the other.

>
>
>>   - Assuming the capability is added, what rework would be acceptable
>>     for block devices?
>
>none

None, in the sense that notification is already present, and no new
mechanism is required, or none in the sense that if a hotplug event
occurs, no one cares?

>
>
>>   - Where should this capability go?  Fork a subset of IDE
>>     controllers, and put them under the arch specific dir?
>>     Or include all devices?
>
>there is nothing arch-specific about this

Again, going back to my original premise, that is, which platforms do
you foresee needing this capability?  I know that all should have
eventually.

>
>
>>   - should we work to the goal of having the capability for all
>>     platforms, and all IDE devices?
>
>of course
>
>	Jeff
>
>


