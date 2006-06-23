Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWFWN5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWFWN5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWFWN5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:57:44 -0400
Received: from fmr18.intel.com ([134.134.136.17]:51920 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750736AbWFWNut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:50:49 -0400
Message-ID: <449BF1AD.9010304@intel.com>
Date: Fri, 23 Jun 2006 09:50:37 -0400
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: George Nychis <gnychis@cmu.edu>
CC: Jeremy Fitzhardinge <jeremy@goop.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: cdrom support with thinkpad x6 ultrabay
References: <4490E776.7080000@cmu.edu> <4490F4BC.1040300@goop.org> <44910B54.8000408@cmu.edu> <44910E2A.5090205@goop.org> <44917B30.9010904@cmu.edu> <449188FF.7030700@goop.org> <44961246.1040509@cmu.edu>
In-Reply-To: <44961246.1040509@cmu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Nychis wrote:
> any update on this? anyone else have a clue?
>
> Thanks!
> George
>
>
> Jeremy Fitzhardinge wrote:
>   
>> George Nychis wrote:
>>     
>>> I applied the acpi-dock patch that I specified, and that patch only, and
>>> i'm getting errors building:
>>>
>>> drivers/acpi/dock.c: In function 'dock_notify':
>>> drivers/acpi/dock.c:543: error: 'KOBJ_DOCK' undeclared (first use in
>>> this function)
>>> drivers/acpi/dock.c:543: error: (Each undeclared identifier is reported
>>> only once
>>> drivers/acpi/dock.c:543: error: for each function it appears in.)
>>> drivers/acpi/dock.c:562: error: 'KOBJ_UNDOCK' undeclared (first use in
>>> this function)
>>>
>>> Is there something else I need to apply that I am missing?
>>>   
>>>       
>> Kristen?
>>
>>    J
>>     
>>> Thanks!
>>> George
>>>
>>>
>>> Jeremy Fitzhardinge wrote:
>>>  
>>>       
>>>> George Nychis wrote:
>>>>    
>>>>         
>>>>> it successfully is applied, and i notice that CONFIG_ACPI_DOCK needs to
>>>>> be set, so I did a "make oldconfig" after applying the patch, expecting
>>>>> it to ask me whether or not i wanted to support it... it didn't.  So
>>>>> then I manually added "CONFIG_ACPI_DOCK=y" to the .config and built the
>>>>> kernel, but dock.o is never built... what else do i need to do?
>>>>>         
>>>>>           
>>>> Make sure you disable the (obsolete?) ACPI_IBM_DOCK stuff.
>>>>
>>>>    
>>>>         
>>>>> If i can't get hot swappable support yet, I might as well get what is
>>>>> supported for now so I can atleast use it sometimes :)
>>>>>
>>>>> Maybe this cry for help will spark someone to finish off the work on
>>>>> hot
>>>>> swapping the optical drive.
>>>>>         
>>>>>           
>>>> Yeah, I'm hoping all the work on power management in libata will make
>>>> things "just work" soon, but I think there's more to it.  When you press
>>>> the dock eject button, it really needs to go out to acpid, activate a
>>>> script to unmount any filesystems mounted off the device, and then poke
>>>> the ata layer to remove the device, before OKing the dock eject so the
>>>> hardware's "don't do that" light goes out.
>>>>
>>>> But in the meantime I'm having enough trouble getting plain old
>>>> suspend/resume reliable.
>>>>
>>>>    J
>>>>
>>>>     
>>>>         
Hi, sorry for the delay in responding - I am out of town at the moment 
and have sporadic access to email.

You are indeed missing a patch that you need:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/broken-out/kevent-add-new-uevent.patch

If you have any PCI devices, you also need the patches to acpiphp:
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/broken-out/acpiphp-use-new-dock-driver.patch

