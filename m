Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWDDRvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWDDRvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 13:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWDDRvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 13:51:45 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:29956 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750775AbWDDRvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 13:51:45 -0400
Message-ID: <4432B22F.6090803@vmware.com>
Date: Tue, 04 Apr 2006 10:51:43 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net, fastboot@osdl.org
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
References: <20060404014504.564bf45a.akpm@osdl.org>	<20060404162921.GK6529@stusta.de> <m1acb15ja2.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1acb15ja2.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Adrian Bunk <bunk@stusta.de> writes:
>
>   
>> On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
>>     
>>> ...
>>> Changes since 2.6.16-mm2:
>>> ...
>>> +x86-clean-up-subarch-definitions.patch
>>> ...
>>>  x86 updates.
>>> ...
>>>       
>> The following looks bogus:
>>     
>
> It is. 
>
>   
>>  config KEXEC
>>         bool "kexec system call (EXPERIMENTAL)"
>> -       depends on EXPERIMENTAL
>> +       depends on EXPERIMENTAL && (!X86_VOYAGER && SMP)
>>
>> The dependencies do now say that KEXEC is only offered for machines that 
>> are _both_ non-Voyager and SMP.
>>
>> Is the problem you wanted to express that a non-SMP Voyager config 
>> didn't compile?
>>
>> AFAIR I recently sent a patch disallowing non-SMP Voyager configurations 
>> that wasn't yet applied.
>>     
>
> I think this cleanup patch is even going in the wrong direction.  The
> subarch code right now is a real pain because it is never clear when
> you are calling a function with multiple definitions.  Which makes it
> really easy to break.
>   
> If we are going to refactor this can we please move in the direction
> of a machine vector like alpha, ppc, and arm.  I don't see the current
> this cleanup making it any easier to tell there is code in a subarch.
>   

No, this cleanup only eliminates the need to duplicate redundant code.   
How does a machine vector make it any harder to break?  You still have a 
function with multiple definitions.  Duplicating code makes things 
really easy to break - twice.
