Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbWCPSVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbWCPSVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWCPSVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:21:33 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:3335 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932705AbWCPSVc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:21:32 -0500
Message-ID: <4419A4A1.9030509@vmware.com>
Date: Thu, 16 Mar 2006 09:47:13 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, Jan Beulich <JBeulich@novell.com>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Virtualization Mailing List <virtualization@lists.osdl.org>
Subject: Re: [RFC, PATCH 12/24] i386 Vmi processor header
References: <200603161133_MC3-1-BACA-4C6C@compuserve.com>
In-Reply-To: <200603161133_MC3-1-BACA-4C6C@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
>
>> +/* Some CPUID calls want 'count' to be placed in ecx */
>> +static inline void cpuid_count(int op, int count, int *eax, int *ebx, int *ecx,
>> +             int *edx)
>> +{
>> +     asm volatile(""::"c"(count));
>> +     vmi_cpuid(op, eax, ebx, ecx, edx);
>> +}
>>     
>
> You can't assume those last two statements will stay together.
> >From the gcc 4.0.2 info file:
>   

I know.  I've abused this a bit.  When we originally wrote the cpuid 
call, there were no ecx dependencies on cpuid.  Never got around to 
fixing it properly.
>   
>> <...> you can't expect a sequence of volatile `asm' instructions
>> to remain perfectly consecutive.  If you want consecutive output, use a
>> single `asm'.
>>     
>
> Maybe you could make vmi_cpuid always take a 'count' param, then just make cpuid
> do:
>
>         vmi_cpuid(op, 0, eax, ebx, ecx, edx);
>
> and cpuid_count do:
>
>         vmi_cpuid(op, count, eax, ebx, ecx, edx);
>   

That is the proper fix.  I'll put that in the next round.

>
> (And sorry about trimming the cc: but I'm reading from a digest and that list
> is too long to enter manually.)
>   

N.P.

Thanks for looking at my code,
Zach
