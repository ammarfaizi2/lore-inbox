Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVLMOCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVLMOCu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVLMOCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:02:49 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:45771 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932308AbVLMOCt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:02:49 -0500
Message-ID: <439ED47D.3080504@us.ibm.com>
Date: Tue, 13 Dec 2005 09:02:37 -0500
From: JANAK DESAI <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.gov, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 0/9] unshare system call (take 3)
References: <1134441527.14136.1.camel@hobbs.atlanta.ibm.com> <20051213112029.GA14653@elte.hu>
In-Reply-To: <20051213112029.GA14653@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* JANAK DESAI <janak@us.ibm.com> wrote:
>
>  
>
>>Patches are organized as follows:
>>
>>1. Patch implementing system call handler sys_unshare. System call
>>   accepts all clone(2) flags but returns -EINVAL when attempt is
>>   made to unshare any shared context.
>>2. Patch registering system call for i386 architecture
>>3. Patch registering system call for powerpc architecture
>>4. Patch registering system call for ppc architecture
>>5. Patch registering system call for x86_64 architecture
>>6. Patch implementing unsharing of filesystem information
>>7. Patch implementing unsharing of namespace
>>8. Patch implementing unsharing of vm
>>9. Patch implementing unsharing of files
>>
>>Unsharing of singnal handlers is still not implemented. As far as I 
>>can tell, issues raised by Chris Wright regarding possible problems 
>>stemming from interaction of timers with unsharing of signal handlers, 
>>has been resolved by a 2.6.14 patch that fixed race in send_sigqueue 
>>with thread exit. However, I do want to understand the code better and 
>>experiment with it some more before implementing signal handler 
>>unsharing. If deemed ok, it would be easy to add that functionality.
>>    
>>
>
>yes, it would be preferrable to have them all at once, once it hits 
>upstream. Also, would unsharing the thread group make sense?
>
>	Ingo
>
>  
>
Hope you mean all flags when you say "have them all at once" because I
hoping to get unsharing of namespace, fs. files and vm in now then
implementing other primitives in an incremental manner. Since the
reorg, these incremental addition of functionality will not require ABI
changes. Namespace and fs unsharing (in addition to shared tree)
is needed for polyinstantiation, critical component for common criteria
lspp evaluation.

As far as unsharing of thread group, IMO implications of signal
unsharing are even messier than signal handler unsharing. I can
investigate it further if folks see usefulness of doing that. However,
I was hoping to get namespace, fs, files and vm unsharing
upstream first.

-Janak

