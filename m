Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbWFOOd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWFOOd2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 10:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWFOOd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 10:33:28 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:55304 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S965057AbWFOOd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 10:33:27 -0400
Message-ID: <44916F99.7030006@onelan.co.uk>
Date: Thu, 15 Jun 2006 15:32:57 +0100
From: Barry Scott <barry.scott@onelan.co.uk>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI extended conf space when MMCONFIG disabled  because
 of e820
References: <200606150443_MC3-1-C283-D4F7@compuserve.com> <44915E3C.5000608@linux.intel.com>
In-Reply-To: <44915E3C.5000608@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Chuck Ebbert wrote:
>> In-Reply-To: <p73ac8fqjix.fsf@verdi.suse.de>
>>
>> On 15 Jun 2006 03:45:10 +0200, Andi Kleen wrote:
>>
>>> Anyways I would say that if the BIOS can't get MCFG right then it's 
>>> likely not been validated on that board and shouldn't be used.
>>
>> According to Petr Vandrovec:
>>
>>  ... "What is important (and checked) is address of MMCONFIG reported 
>> by MCFG
>>  table...  Unfortunately code does not bother with printing that 
>> address :-(
>>  
>>  "Another problem is that code has hardcoded that MMCONFIG area is 
>> 256MB large.  Unfortunately for the code PCI specification allows any 
>> power of two between 2MB  and 256MB if vendor knows that such amount 
>> of busses (from 2 to 128) will be  sufficient for system.  With 
>> notebook it is quite possible that not full 8 bits  are implemented 
>> for MMCONFIG bus number."
>>
>>
>> So here is a patch.  Unfortunately my system still fails the test 
>> because
>> it doesn't reserve any part of the MMCONFIG area, but this may fix 
>> others.
>>
>> Booted on x86_64, only compiled on i386.  x86_64 still remaps the max 
>> area
>> (256MB) even though only 2MB is checked... but 2.6.16 had no check at 
>> all
>> so it is still better.
>>
>>
>> PCI: reduce size of x86 MMCONFIG reserved area check
>>
>> 1.  Print the address of the MMCONFIG area when the test for that area
>>     being reserved fails.
>>
>> 2.  Only check if the first 2MB is reserved, as that is the minimum.
>>
>> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
>
> Acked-by: Arjan van de Ven <arjan@linux.intel.com>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
I have a system that fails to boot reporting MCFG problems.
I've applied your patch and it allowed the HP dc7600U to boot past
the MCFG problem. (I still have LVM problems - but that nothing
to do with this patch).

My shuttle P4 system also boots with your patch applied.

Barry

