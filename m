Return-Path: <linux-kernel-owner+w=401wt.eu-S1755180AbWL3SGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180AbWL3SGc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 13:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755187AbWL3SGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 13:06:32 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:3320 "EHLO
	anchor-post-34.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755180AbWL3SGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 13:06:31 -0500
Message-ID: <4596AAA5.9020506@superbug.co.uk>
Date: Sat, 30 Dec 2006 18:06:29 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.9 (X11/20061222)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.6.19.1
References: <200612201550_MC3-1-D5C7-74C6@compuserve.com>
In-Reply-To: <200612201550_MC3-1-D5C7-74C6@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <200612201421.03514.s0348365@sms.ed.ac.uk>
> 
> On Wed, 20 Dec 2006 14:21:03 +0000, Alistair John Strachan wrote:
> 
>> Any ideas?
>>
>> BUG: unable to handle kernel NULL pointer dereference at virtual address 
>> 00000009
> 
>     83 ca 10                  or     $0x10,%edx
>     3b                        .byte 0x3b
>     87 68 01                  xchg   %ebp,0x1(%eax)   <=====
>     00 00                     add    %al,(%eax)
> 
> Somehow it is trying to execute code in the middle of an instruction.
> That almost never works, even when the resulting fragment is a legal
> opcode. :)
> 
> The real instruction is:
> 
>     3b 87 68 01 00 00 00        cmp    0x168(%edi),%eax
> 
> I'd guess you have some kind of hardware problem.  It could also be
> a kernel problem where the saved address was corrupted during an
> interrupt, but that's not likely.

This looks rather strange.
The times I have seen this sort of problem is:
1) when one bit of the kernel is corrupting another part of it.
2) Kernel modules compiled with different gcc than rest of kernel.
3) kernel headers do not match the kernel being used.

One way to start tracking this down would be to run it with the fewest 
amount of kernel modules loaded as one can, but still reproduce the problem.

James
