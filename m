Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbVKJO63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbVKJO63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbVKJO63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:58:29 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:18949 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750985AbVKJO62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:58:28 -0500
Message-ID: <43736011.7060902@vmware.com>
Date: Thu, 10 Nov 2005 06:58:25 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: prasanna@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [PATCH 19/21] i386 Kprobes semaphore fix
References: <200511080439.jA84diI6009951@zach-dev.vmware.com> <200511081412.05285.ak@suse.de> <4370A9F5.4060103@vmware.com> <200511091438.11848.ak@suse.de> <437227FD.6040905@vmware.com> <20051109165804.GA15481@elte.hu> <43723768.2060103@vmware.com> <20051110180954.GD8514@in.ibm.com>
In-Reply-To: <20051110180954.GD8514@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Nov 2005 14:58:27.0323 (UTC) FILETIME=[34B2F4B0:01C5E607]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi wrote:

>On Wed, Nov 09, 2005 at 09:52:40AM -0800, Zachary Amsden wrote:
>  
>
>>Ingo Molnar wrote:
>>
>>    
>>
>>>* Zachary Amsden <zach@vmware.com> wrote:
>>>
>>>
>>>
>>>      
>>>
>>>>>I believe user space kprobes are being worked on by some IBM India folks 
>>>>>yes.
>>>>>    
>>>>>
>>>>>          
>>>>>
>>>>I'm convinced this is pointless.  What does it buy you over a ptrace 
>>>>based debugger?  Why would you want extra code running in the kernel 
>>>>that can be done perfectly well in userspace?
>>>>  
>>>>
>>>>        
>>>>
>>>kprobes are not just for 'debuggers', they are also used for tracing and 
>>>other dynamic instrumentation in projects like systemtap. Ptrace is way 
>>>too slow and limited for things like that.
>>>
>>>
>>>      
>>>
>>Well, if there is a justification for it, that means we really should 
>>handle all the nasty EIP conversion cases due to segmentation and v8086 
>>mode in the kprobes code.  I was hoping that might not be the case.
>>
>>    
>>
>
>As Ingo mentioned above, Systemtap uses kprobes infrastructure to provide
>dynamic kernel instrumentation. Using which user can add lots of probes 
>easily, so we need to take care of this fast path.  
>
>Instead of calling convert_eip_to_linear() for all cases, you can
>just check if it is in kernel mode and calculate the address directly
>
>	if (kernel mode)
>                addr = regs->eip - sizeof(kprobe_opcode_t);
>        else
>                addr = convert_eip_to_linear(..);
>
>there by avoiding call to convert_eip_to_linear () for every kernel probes.
>
>As Andi mentioned user space probes support is in progress and 
>this address conversion will help in case of user space probes as well.
>

I like this better.  I have to rework that patch anyways, since it no 
longer applies cleanly.

Zach

