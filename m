Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268171AbUHKTdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268171AbUHKTdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 15:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268053AbUHKTdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 15:33:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10417 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268012AbUHKTdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 15:33:21 -0400
Message-ID: <411A7472.9010606@pobox.com>
Date: Wed, 11 Aug 2004 15:33:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug Maxey <dwm@austin.ibm.com>
CC: Linux IDE Mailing List <linux-ide@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IDE/ATA/SATA controller hotplug
References: <200407272018.i6RKIiYB028210@falcon10.austin.ibm.com>
In-Reply-To: <200407272018.i6RKIiYB028210@falcon10.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Maxey wrote:
> On Tue, 27 Jul 2004 11:31:15 EDT, Jeff Garzik wrote:
>>>  What I would like is input on the general strategy that should be
>>>  taken to modify the controller/adapter and device stack to:
>>>
>>>  1) be first class modules, where all controllers/adapters are
>>>     capable of being loaded and unloaded.  This is directed mostly at
>>>     IDE/Southbridge controller/adapter devices.
>>
>>this is already the case in IDE and libata
> 
> 
> I would have to differ with you here.  From conversations and fairly
> (2 or 3 months ago) experience, the IDE core is not capable of being
> unloaded.

As long as the low-level driver can be unloaded, that's sufficient for 
hardware- and device-hotplug.


>>>  2) extend that support to all child devices; disk, optical,
>>>     and tape.
>>
>>this is already the case in IDE and SCSI
> 
> 
> Educational question, what would I be looking for when grokking code
> to see this is in place?

Just general refcounting / module support code.


>>>  3) be part of mainline.
>>
>>this is already the case
> 
> 
> Yes, the drivers are in the mainline.  Just not sure of how many
> platforms will have non-pluggable controllers that need to have them
> hot-plugged. :-)

The PCI API is a hotplug API.  Whether the underlying controller is 
hotpluggable or not is largely irrelevant to low-level drivers.


>>>  The items I perceive at the top of the issue list are:
>>>
>>>  - The primary platforms for IDE/ATA devices are x86 based, and
>>>    certainly do not care about having this capability.
>>
>>incorrect
> 
> 
> Ok, please delineate.  Working off the assumption that 95+% of the
> systems that run Linux are x86 based, and have a single partition for
> the system. In other words, no virtual processors, where each is
> totally separate from the other.

That's completely irrelevant.  libata and the IDE core work without 
change on x86 and non-x86 systems.


>>>  - Where should this capability go?  Fork a subset of IDE
>>>    controllers, and put them under the arch specific dir?
>>>    Or include all devices?
>>
>>there is nothing arch-specific about this
> 
> 
> Again, going back to my original premise, that is, which platforms do
> you foresee needing this capability?  I know that all should have
> eventually.

All platforms should be considered hotplug.

	Jeff


