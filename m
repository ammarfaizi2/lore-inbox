Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268845AbUIMRXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268845AbUIMRXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 13:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268839AbUIMRXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 13:23:52 -0400
Received: from mail5.iserv.net ([204.177.184.155]:61632 "EHLO mail5.iserv.net")
	by vger.kernel.org with ESMTP id S268848AbUIMRVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 13:21:41 -0400
Message-ID: <4145D71C.9090209@didntduck.org>
Date: Mon, 13 Sep 2004 13:21:32 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Constantine Gavrilov <constg@qlusters.com>
CC: Christoph Hellwig <hch@infradead.org>, bugs@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on Opteron
 machines
References: <4145A8E1.8010409@qlusters.com> <20040913153803.A27282@infradead.org> <4145B750.6060900@qlusters.com>
In-Reply-To: <4145B750.6060900@qlusters.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Constantine Gavrilov wrote:

> Christoph Hellwig wrote:
> 
>> On Mon, Sep 13, 2004 at 05:04:17PM +0300, Constantine Gavrilov wrote:
>>  
>>
>>> Hello:
>>>
>>> We have a piece of kernel code that calls some system calls in kernel 
>>> context (
>>>   
>>
>>
>> Which you shouldn't do in the first place.
>>  
>>
> 
> Function kernel_thread() on i386 is implemented by putting the args to 
> appropriate regs and calling int 0x80, resulting in a system call 
> clone() on i386.

It's gone in 2.6, in favor of calling do_fork() directly.

> I have also found the "syscall" instruction in x86-64 kernel specific 
> code (it does not call _syscall() macros directly, though). So, 
> "shouldn't do" is a bit too strong.
> 
> What I am writing is an application, and not interface. As such, it is 
> not much different from its requierements from a user-space application. 
> If user-space application may call system calls, why a kernel space 
> application cannot?
> 
> And BTW, kernel-space applications have their own place even if the 
> concept seems foreign to you.

What are you trying to do that can't be done in user space?  The only 
possible reason for a kernel space app is for performance (like knfsd), 
at the cost of risking system stability and security.

--
				Brian Gerst

