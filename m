Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbWJMEKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWJMEKa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 00:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbWJMEKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 00:10:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:49812 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1751602AbWJMEK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 00:10:29 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,302,1157353200"; 
   d="scan'208"; a="144341672:sNHT23322565"
Message-ID: <452F1142.3000400@intel.com>
Date: Thu, 12 Oct 2006 21:08:34 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Aleksey Gorelov <dared1st@yahoo.com>
CC: xhejtman@mail.muni.cz, linux-kernel@vger.kernel.org, magnus.damm@gmail.com,
       pavel@suse.cz
Subject: Re: Machine reboot
References: <20061013000556.89570.qmail@web83108.mail.mud.yahoo.com>
In-Reply-To: <20061013000556.89570.qmail@web83108.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksey Gorelov wrote:
> Auke Kok <sofar@foo-projects.org> wrote:
>> Aleksey Gorelov wrote:
>>>> -----Original Message-----
>>>> From: linux-kernel-owner@vger.kernel.org 
>>>> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Lukas 
>>>> Hejtmanek
>>>> Sent: Thursday, October 05, 2006 3:53 AM
>>>> To: linux-kernel@vger.kernel.org
>>>> Subject: Machine reboot
>>>>
>>>> Hello,
>>>>
>>>> I'm facing troubles with machine restart. While sysrq-b 
>>>> restarts machine, reboot
>>>> command does not. Using printk I found that kernel does not 
>>>> hang and issues
>>>> reset properly but BIOS does not initiate boot sequence. Is 
>>>> there something
>>>> I could do?
>>>   I have similar issue on Intel DG965WH board. Did you try to shutdown network interface and
>>> 'rmmod e1000' right before reboot ? In my case machine reboots fine after that.
>>>
>>> Aleks.
 >>
>> interesting, do you do that because it specifically fixes a problem you have? if so, I'd 
>> like to know about it :)
>>
>> Auke
>>
> I'm just trying to localize the issue. 
> Since right before machine stalls during reboot I see something like
> 
> ACPI: PCI interrupt for device 000:00:19.0 disabled
> Restarting system.

that's quite a normal message, not sure why that would constitute a problem.

> and this device is Gb ethernet, e1000 is perfect candidate to look at. And yes, removing e1000
> before reboot works around the issue.

Have you tried to only `ifconfig ethX down` ? my own i965 board shuts down perfectly 
fine without unloading the e1000 driver.

> I'm afraid this is now common issue across Intel 965 board series, at least with their latest BIOS
> updates.

first time I've heard of it!

I'm unsure my BIOS version will be the same as it's a devel system for our drivers, but 
still I have never heard of anyone requiring the full unload of the NIC driver to be 
able to shutdown.

Would you be able to debug a failed shutdown perhaps and capture the console output? 
when exactly does it `stall` ? What other interrupts are assigned on your system? Did 
other BIOS versions work correctly?

Auke
