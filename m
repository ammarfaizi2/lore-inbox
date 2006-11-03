Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752910AbWKCB2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbWKCB2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 20:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbWKCB2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 20:28:18 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:5526 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1752907AbWKCB2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 20:28:18 -0500
Date: Fri, 3 Nov 2006 02:28:17 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <454A76CC.6030003@cosmosbay.com>
Message-ID: <Pine.LNX.4.64.0611030223190.7781@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <454A76CC.6030003@cosmosbay.com>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have these questions:
>> 
>> * There is a rw semaphore that is locked for read for nearly all operations 
>> and locked for write only rarely. However locking for read causes cache 
>> line pingpong on SMP systems. Do you have an idea how to make it better?
>> 
>> It could be improved by making a semaphore for each CPU and locking for 
>> read only the CPU's semaphore and for write all semaphores. Or is there a 
>> better method?
>> 
>
> If you believe you need a semaphore for protecting a mostly read structure, 
> then RCU is certainly a good candidate. (ie no locked operation at all)

RCU is for non-blocking operation only.

Maybe it could be use for maintaining an unlocked variable that prevents 
readers from entering a critical section --- but waiting in a write for a 
quiscent state would hurt.

> The problem with a per_cpu biglock is that you may consume a lot of RAM for 
> big NR_CPUS. Count 32 KB per 'biglock' if NR_CPUS=1024
>
>> * This leads to another observation --- on i386 locking a semaphore is 2 
>> instructions, on x86_64 it is a call to two nested functions. Has it some 
>> reason or was it just implementator's laziness? Given the fact that locked 
>> instruction takes 16 ticks on Opteron (and can overlap about 2 ticks with 
>> other instructions), it would make sense to have optimized semaphores too.
>
> Hum, please dont use *lazy*, this could make Andi unhappy :)
>
> What are you calling semaphore exactly ?
> Did you read Documentation/mutex-design.txt ?

I see --- I could replace that semaphore with mutex. But rw-semaphores 
can't be replaces with them.

Mikulas
