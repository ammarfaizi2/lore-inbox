Return-Path: <linux-kernel-owner+w=401wt.eu-S965261AbXAKAqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbXAKAqX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 19:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbXAKAqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 19:46:23 -0500
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:48930 "EHLO
	smtp-out.rrz.uni-koeln.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965261AbXAKAqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 19:46:22 -0500
Message-ID: <45A588C6.6040008@rrz.uni-koeln.de>
Date: Thu, 11 Jan 2007 01:45:58 +0100
From: Berthold Cogel <cogel@rrz.uni-koeln.de>
User-Agent: IceDove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Regression in kernel linux-2.6.20-rc1/2: Problems with poweroff
References: <459069AA.20809@rrz.uni-koeln.de> <20061228221616.GI20714@stusta.de> <45999C47.40204@rrz.uni-koeln.de> <459D5079.70605@linux.intel.com> <459EE89F.1010505@rrz.uni-koeln.de> <459F6366.5080609@linux.intel.com> <45A13DF8.2030207@rrz.uni-koeln.de> <45A29C09.8050901@linux.intel.com> <45A4391E.7080805@rrz.uni-koeln.de> <45A4D333.4090109@linux.intel.com>
In-Reply-To: <45A4D333.4090109@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Starikovskiy schrieb:
> Berthold Cogel wrote:
>> Alexey Starikovskiy schrieb:
>>  
>>> Berthold Cogel wrote:
>>>    
>>>> Alexey Starikovskiy schrieb:
>>>>
>>>>  
>>>>      
>>>>>> Hello Alex,
>>>>>>
>>>>>> I still get the same diffs. Except the yenta part of course. And the
>>>>>> system is still rebooting.
>>>>>>
>>>>>> Berthold
>>>>>>                   
>>>>> Good, yenta is cleared :) Could you replace /drivers/acpi/ec.c with
>>>>> the
>>>>> version from 2.6.19.x and try again?
>>>>>
>>>>> Regards,
>>>>>    Alex.
>>>>>             
>>>> Hi Alex!
>>>>
>>>> I did what you suggested. First I replaced ec.c in linux-2.6.20-rc2
>>>> (see
>>>> attached dmesg-2.6.20-rc2.ec.txt) with the version from linux-2.6.19.1
>>>> and in a second step I also replaced i2c_ec.c and i2c_ec.h
>>>> (dmesg-2.6.20-rc2.i2c_ec.txt).
>>>>
>>>> In both cases the only result I can see is the absence of the 'ACPI:
>>>> EC:
>>>> evaluating' messages in the logs. The system is still rebooting instead
>>>> of doing a clean shutdown.
>>>>
>>>> Regards,
>>>> Berthold
>>>>
>>>>         
>>> Excellent, ACPI printing of queries is cleared as well :)
>>> There are two ways to debug further... git-bisect and unloading modules
>>> before shutdown (or not loading them)...
>>> While second is easier and could isolate a module, the first could be
>>> way more productive:
>>> http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt
>>>
>>>
>>>
>>> Thanks in advance,
>>>    Alex.
>>>
>>>     
>>
>> Hi Alex!
>>
>> I will have to set up git first for the bisect way. So I decided to give
>> the second way a try.
>>
>> The module in question is ehci_hcd. After blacklisting it, 'shutdown -h
>> now' worked fine.
>>
>>   
> Hi Berthold,
> 
> That is good news, but with ehci_hcd you basically disable the whole USB
> subsystem. Please try to locate more
> by turning off USB options in your kernel config, starting with USB
> suspend.
> Probably, USB maintainers could give you some more hints on there to look.
> 
> Regards,
>    Alex.

Hello Alex!

How did you guess ...

It's USB_SUSPEND.


Regards,
Berthold
