Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423226AbWANAZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423226AbWANAZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423230AbWANAZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:25:27 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:28981 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1423226AbWANAZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:25:25 -0500
Date: Fri, 13 Jan 2006 18:24:05 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Dual core Athlons and unsynced TSCs
In-reply-to: <5uCtj-4Fi-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43C844A5.7050400@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5ujmj-1UQ-511@gated-at.bofh.it> <5uBnF-2SG-11@gated-at.bofh.it>
 <5uBnF-2SG-9@gated-at.bofh.it> <5uBxi-3iM-21@gated-at.bofh.it>
 <5uBGY-3ul-21@gated-at.bofh.it> <5uCa5-443-45@gated-at.bofh.it>
 <5uCjF-4fW-15@gated-at.bofh.it> <5uCtj-4Fi-15@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
>>>>But obviously if the TSC gives wildly inaccurate results, it cannot be
>>>>used no matter how low the overhead.
>>>
>>>unless we can re-sync the TSCs often enough that apps don't notice.
>>>
>>
>>You'd have to quantify that somehow, in terms of the max drift rate
>>(ppm), and the max resolution available (< tsc frequency).  
>>
>>Either that, or track an offset, and use one TSC as truth, and update
>>the correction factor for the other TSCs as often as needed, maybe?
>>
>>This is kind of analogous to the "drift" NTP calculates against a
>>free-running oscillator. 
>>
>>So you'd be pushing that functionality deeper into the OS-core.
>>
>>Dave Mills had that "hardpps" stuff in there for a while, it might be a
>>starting point.
>>
>>Just some thoughts for now... 
> 
> It kind of makes you wonder what in the heck AMD were thinking, whether
> they realized that this design decision would cause so many problems at
> the OS level (it's broken at least Linux and Solaris).  Maybe Windows
> keeps time in a way that was unaffected by this?

Sounds to me like they are doing something like what was being mentioned 
above:

http://support.microsoft.com/kb/896256/en-us

"When TSC does not increment monotonically, system components that use 
the kernel KeQueryPerformanceCounter function may not work correctly. To 
address this problem, Microsoft makes it possible for the ACPI Power 
Management Timer to be used as the operating system timer that supports 
the kernel KeQueryPerformanceCounter function. However, some programs 
may directly access the TSC by bypassing the Windows timer APIs. The 
multiple-processor Hardware Abstraction Layer (HAL) makes sure that the 
TSC registers on all processors on a multiple-processor computer remain 
closely synchronized. Therefore, access by system software that may be 
directed to different processors does not return different results."

Also, Microsoft's docs for QueryPerformanceCounter specify that 
different results on different CPUs will only occur if there are "bugs 
in the basic input/output system (BIOS) or the hardware abstraction 
layer (HAL)" and recommends that threads using this function set their 
affinity to run on one processor only.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

