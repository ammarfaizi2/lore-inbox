Return-Path: <linux-kernel-owner+w=401wt.eu-S964870AbWLMBLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWLMBLE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWLMBLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:11:04 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:37997 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964870AbWLMBLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:11:03 -0500
X-Greylist: delayed 1923 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 20:11:03 EST
Message-ID: <457F4BA1.4010700@vmware.com>
Date: Tue, 12 Dec 2006 16:38:57 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 2/5] Paravirt cpu batching.patch
References: <200612121853_MC3-1-D4D2-191A@compuserve.com>
In-Reply-To: <200612121853_MC3-1-D4D2-191A@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <20061212225430.GC10475@sequoia.sous-sol.org>
>
> On Tue, 12 Dec 2006 14:54:30 -0800, Chros Wright wrote:
>
>   
>>> --- a/arch/i386/kernel/process.c    Tue Dec 12 13:50:50 2006 -0800
>>> +++ b/arch/i386/kernel/process.c    Tue Dec 12 13:50:53 2006 -0800
>>> @@ -665,6 +665,37 @@ struct task_struct fastcall * __switch_t
>>>     load_TLS(next, cpu);
>>>  
>>>     /*
>>> +    * Restore IOPL if needed.
>>> +    */
>>> +   if (unlikely(prev->iopl != next->iopl))
>>> +           set_iopl_mask(next->iopl);
>>>       
>> Small sidenote that this bit undoes a recent change from Chuck Ebbert, which
>> killed iopl_mask update via hypervisor.
>>     
>
> This whole thing needs a proper fix IMO.  I posted something a while back
> but Andi didn't like it, I guess.
>   

We can handle this one with an #ifdef CONFIG_PARAVIRT, though.

Zach
