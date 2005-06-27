Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVF0K5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVF0K5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 06:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVF0K5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 06:57:11 -0400
Received: from tornado.reub.net ([60.234.136.108]:4283 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261659AbVF0K5G (ORCPT
	<rfc822;<linux-kernel@vger.kernel.org>>);
	Mon, 27 Jun 2005 06:57:06 -0400
Message-ID: <42BFDB83.9080500@reub.net>
Date: Mon, 27 Jun 2005 22:57:07 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050624)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlock-debug fix
References: <fa.h6rvsi4.j68fhk@ifi.uio.no> <42BFA05B.1090208@reub.net> <20050627002429.40231fdf.akpm@osdl.org> <42BFAF1F.8050201@reub.net> <20050627012226.450bc86d.akpm@osdl.org> <20050627094844.GA16357@elte.hu>
In-Reply-To: <20050627094844.GA16357@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/06/2005 9:48 p.m., Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
>> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>>>  > Anyway, scary trace.  It look like some spinlock is thought to be in the
>>>  > wrong state in schedule().  Send the .config, please.
>>>
>>>  Now online at  http://www.reub.net/kernel/.config
>> Me too.
>>
>> BUG: spinlock recursion on CPU#0, swapper/0, c120d520             
>>  [<c01039ed>] dump_stack+0x19/0x20                   
>>  [<c01d9af2>] spin_bug+0x42/0x54  
>>  [<c01d9bfa>] _raw_spin_lock+0x3e/0x84
>>  [<c031d0ad>] _spin_lock+0x9/0x10     
>>  [<c031b9e9>] schedule+0x479/0xbc8
>>  [<c0100cb4>] cpu_idle+0x88/0x8c  
>>  [<c01002c1>] rest_init+0x21/0x28
>>  [<c0442899>] start_kernel+0x151/0x158
>>  [<c010020f>] 0xc010020f              
>> Kernel panic - not syncing: bad locking
>>
>> The bug is in the new spinlock debugging code itself.  Ingo, can you 
>> test that .config please?
> 
> couldnt reproduce it on an UP box, nor on an SMP/HT 2/4-way box, but it 
> finally triggered on a 2-way SMP box.
> 
> the bug is that current->pid is not a unique identifier on SMP (doh!).  
> 
> The patch below fixes the bug - which also happens to be a speedup for 
> the debugging code, as the ->pid dereferencing does not have to be done 
> anymore. Also, i've disabled the panicing for now.
> 
> 	Ingo

This patch fixes it - thanks Ingo.

reuben
