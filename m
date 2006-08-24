Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWHXK5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWHXK5p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWHXK5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:57:45 -0400
Received: from web25811.mail.ukl.yahoo.com ([217.146.176.244]:44682 "HELO
	web25811.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750921AbWHXK5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:57:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=jtoK78HbbGK0AtitQUQhzh34WRQgn2JGHGPZwZb2LtHSkh6bSWl6Uzo7ItM98+I8RDiNh4voqdfJiECa8zSM2DTUsgnraU3wudyxhuRn/mDA5OtodPkogJGxbt5QkE/laC/pY8nWlKZv96zkCKmjqDFMIBn2fq2pWlbfrtplUOg=  ;
Message-ID: <20060824105743.60250.qmail@web25811.mail.ukl.yahoo.com>
Date: Thu, 24 Aug 2006 10:57:43 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : Re : [HELP] Power management for embedded system
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060824101125.GA21439@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Aug 24, 2006 at 09:37:39AM +0000, moreau francis wrote:
>> Russell King wrote:
>>> On Thu, Aug 24, 2006 at 08:44:25AM +0000, moreau francis wrote:
>>>> Mips one seems to be a copy and paste of arm one and both of them
>>>> have removed all APM bios stuff orginally part of i386 implementation.
>>> The BIOS stuff makes no sense on ARM - there isn't a BIOS to do anything
>>> with.
>> I haven't said that it has been widely/wrongly removed...
> 
> ROTFL!  No, you were stating that the APM bios stuff was removed, and
> I gave the reason for it.  Why are you now objecting to my explaination?
> 

Take it easy ! I'm not objecting your explanation. Your explanation, which
was not asked, sounded to me like I said something wrong/bad on this
amputation. I have prefered to make things clear, no more.

>>>> It doesn't seem that APM is something really stable and finished.
>>> It's complete.  It's purpose is to provide the interface to userland so
>>> that programs know about suspend/resume events, and can initiate suspends.
>>> Eg, the X server.
>>>
>> Is there something specific to ARM in this implementation ? I don't think
>> so and it's surely the reason why MIPS did copy it with almost no changes.
> 
> MIPS copied it because presumably it was useful for them.
> 

Actually my point is that it could be usefull for _all_ embedded systems,
whatever the arches it comes from, couldn't it ?

>> I understand that ARM implementation has been the first one but maybe now

So does it make sense to you to have

linux/driver/apm
|-- apm_userland_interface_emulation_and_not_a_power_management_infrastructure.c
|-- idle.c
|-- core.c

linux/arch/arm/kernel/
|- apm_specific_to_arm_which_is_needed_by_generic_driver.c
| ...

for example ?


>> why not making it the common power management for embedded system that
>> could be used by all arches which need it ?
> 
> It could well become a common interface.  But it is NOT power management
> infrastructure.  It is merely a _userland_ interface.  Nothing more.  It
> does not do anything other than that.
> 

apm_queue_event() (and kapmd) doens't seem something usefull for user space.
It seems to be designed to be used by the kernel no ?

>> BTW, why has apm_cpu_idle() logic been removed from ARM implementation ?
> 
> This APM is just a userland interface.  It has nothing to do with actual
> power management.  CPU idling is handled entirely differently on ARM.
> 

Could you point out where it is handled ?

>>> The power management really comes from the Linux drivers themselves,
>>> which are written to peripherals off when they're not in use.  The other
>>> power saving comes from things like cpufreq - again, nothing to do with
>>> the magical "APM" or "ACPI" terms.
>> BTW why is it still called "APM" on ARM ?
> 
> That's what the userland interface is called on x86.  We could've called it
> apm_userland_interface_emulation_and_not_a_power_management_infrastructure.c
> but although that clearly states what it is, it would've been far too long
> a name. 8)
> 

Sure, but something that can reflect that it's a userland interface emulation
implementation would have been usefull. APM, despite it's already used by APM
BIOS terminology, is rather a name for a complete subsystem.

Francis



