Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWFFN0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWFFN0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWFFN0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:26:08 -0400
Received: from [207.35.253.199] ([207.35.253.199]:62143 "EHLO
	smtp.discreet.com") by vger.kernel.org with ESMTP id S1751299AbWFFN0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:26:07 -0400
Message-ID: <4485825D.9000606@discreet.com>
Date: Tue, 06 Jun 2006 09:25:49 -0400
From: Martin Bisson <bissonm@discreet.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: x86_64 system call entry points II
References: <44846210.4080602@discreet.com> <p73verezw9t.fsf@verdi.suse.de>
In-Reply-To: <p73verezw9t.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Martin Bisson <bissonm@discreet.com> writes:
>  
>
>>- int $0x80/64 bits: All system calls return -1 (EINTR).  Is there
>>something wrong in the way I call it:
>>pid_t getpid64()
>>{
>>    pid_t resultvar;
>>
>>    asm volatile (
>>    "int $0x80\n\t"
>>    : "=a" (resultvar)     : "0" (__NR_getpid)
>>    : "memory");
>>
>>    return resultvar;
>>}
>>    
>>
>
>I tested it now. Since it ends up as a 32bit syscall you're not 
>actually calling 64bit getpid() - but 32bit mkdir(). That is because 32bit and 64bit
>have different syscall numbers. For me it returns -14, which is EFAULT.
>Expected for a random argument to mkdir()
>  
>
It makes a lot of sense...

I think the bottom line for me is simply that I cannot enter system 
calls any way I want with any kernel, among other things because the 
kernel expects that we got into the system call using vsyscall stuff and 
that the correct way to return to user space is also found in the 
vsyscall page.

Thanks for your input.

Mart
