Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWJWUQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWJWUQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWJWUQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:16:27 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:29489 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1750766AbWJWUQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:16:27 -0400
Message-ID: <453D230D.7070403@qumranet.com>
Date: Mon, 23 Oct 2006 22:16:13 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/13] KVM: vcpu execution loop
References: <453CC390.9080508@qumranet.com> <20061023133056.B3615250143@cleopatra.q> <200610232141.45802.arnd@arndb.de>
In-Reply-To: <200610232141.45802.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Oct 2006 20:16:18.0668 (UTC) FILETIME=[197282C0:01C6F6E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Monday 23 October 2006 15:30, Avi Kivity wrote:
>   
>> +       asm (
>> +               /* Store host registers */
>> +               "pushf \n\t"
>> +#ifdef __x86_64__
>> +               "push %%rax; push %%rbx; push %%rdx;"
>> +               "push %%rsi; push %%rdi; push %%rbp;"
>> +               "push %%r8;  push %%r9;  push %%r10; push %%r11;"
>> +               "push %%r12; push %%r13; push %%r14; push %%r15;"
>> +               "push %%rcx \n\t"
>> +               "vmwrite %%rsp, %2 \n\t"
>> +#else
>> +               "pusha; push %%ecx \n\t"
>> +               "vmwrite %%esp, %2 \n\t"
>> +#endif
>> +               /* Check if vmlaunch of vmresume is needed */
>> +               "cmp $0, %1 \n\t"
>> +               /* Load guest registers.  Don't clobber flags. */
>> +#ifdef __x86_64__
>> +               "mov %c[cr2](%3), %%rax \n\t"
>> +               "mov %%rax, %%cr2 \n\t"
>> +               "mov %c[rax](%3), %%rax \n\t"
>> +               "mov %c[rbx](%3), %%rbx \n\t"
>> +               "mov %c[rdx](%3), %%rdx \n\t"
>> +               "mov %c[rsi](%3), %%rsi \n\t"
>> +               "mov %c[rdi](%3), %%rdi \n\t"
>> +               "mov %c[rbp](%3), %%rbp \n\t"
>> ...
>>     
>
> This looks like you should simply put it into a .S file.
>
>   

Then I lose all the offsetof constants down the line.  Sure, I could do 
the asm-offsets dance but it seems to me like needless obfuscation.



-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

