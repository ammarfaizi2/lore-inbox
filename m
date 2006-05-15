Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWEOUyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWEOUyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWEOUyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:54:12 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:64445 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964777AbWEOUyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:54:11 -0400
Message-ID: <4468EA58.8040805@tmr.com>
Date: Mon, 15 May 2006 16:53:44 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060409 SeaMonkey/1.0.1
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Segfault on the i386 enter instruction
References: <20060512131654.GB2994@duch.mimuw.edu.pl> <Pine.LNX.4.61.0605121003450.9012@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0605121003450.9012@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Fri, 12 May 2006, Tomasz Malesinski wrote:
> 
>> The code attached below segfaults on the enter instruction. It works
>> when a stack frame is created by the three commented out
>> instructions and also when the first operand of the enter instruction
>> is small (less than about 6500 on my system).
>>
>> AFAIK, the only difference between creating a stack frame with the
>> enter instruction or push/mov/sub is that enter checks if the new
>> value of esp is inside the stack segment limit.
>>
>> I tested it on a vanilla kernel 2.4.26 on Intel Celeron and also on
>> probably non-vanilla 2.6.16.13 running on 3 dual core AMD Opteron,
>> quite busy, server. It is working in 32-bit mode. Interestingly, on
>> the second machine sometimes the program worked correctly.
>>
>> I am not subscribed to the list. Please cc replies to me.
>>
>>
>> 	.file	"a.c"
>> 	.version	"01.01"
>> gcc2_compiled.:
>> .section	.rodata
>> .LC0:
>> 	.string	"asdf\n"
>> .text
>> 	.align 4
>> .globl main
>> 	.type	 main,@function
>> main:
>> 	enter $10008, $0
>> #	pushl %ebp
>> #	movl %esp,%ebp
>> #	subl $10008,%esp
>> 	addl $-12,%esp
>          ^^^^^^^^^^^^^^____________ WTF
>          adding a negative number is subtracting that positive value.
Right, adding -12 is the same as subtracting 12. I have no idea what 
you're getting at with the next two lines.
>          You just subtracted 0xfffffff3 (on a 32-bit machine) from
>          the stack pointer. It damn-well better seg-fault!
No, we subtracted 12. I'm not sure where that number came from, it's the 
1's complement of 12 but I'm dead sure Linux code isn't running on any 
1's comp machines.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
