Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVCPOzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVCPOzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVCPOzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:55:51 -0500
Received: from alog0249.analogic.com ([208.224.222.25]:52356 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262609AbVCPOyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:54:00 -0500
Date: Wed, 16 Mar 2005 09:51:32 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Ian Campbell <ijc@hellion.org.uk>, Tom Felker <tfelker2@uiuc.edu>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bogus buffer length check in linux-2.6.11  read()
In-Reply-To: <423845DF.7080701@cosmosbay.com>
Message-ID: <Pine.LNX.4.61.0503160949580.16949@chaos.analogic.com>
References: <Pine.LNX.4.61.0503151257450.12264@chaos.analogic.com> 
 <200503152056.16287.tfelker2@uiuc.edu>  <Pine.LNX.4.61.0503160724120.16304@chaos.analogic.com>
 <1110979800.3057.69.camel@icampbell-debian> <Pine.LNX.4.61.0503160848420.16718@chaos.analogic.com>
 <423845DF.7080701@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Brilliant! And it even works!
Now if the kernel hadn't screwed up in the first place, then
your expertise wouldn't have been needed.

Thanks.

On Wed, 16 Mar 2005, Eric Dumazet wrote:

> linux-os wrote:
>
>> 
>> 
>> I don't know how much more precise I could have been. I show the
>> code that will cause the observed condition. I explain that this
>> condition is new, that it doesn't correspond to the previous
>> behavior.
>> 
>> Never before was some buffer checked for length before some data
>> was written to it. The EFAULT is supposed to occur IFF a write
>> attempt occurs outside the caller's accessible address space.
>> This used to be done by hardware during the write to user-space.
>> This had zero impact upon performance. Now there is some
>> software added that adds CPU cycles, subtracts performance,
>> and cannot possibly do anything useful.
>> 
>> Also, the code was written to show the problem. The code
>> is not designed to be an example of good coding practice.
>> 
>> The actual problem observed with the new kernel was
>> when some legacy code used gets() instead of fgets().
>> The call returned immediately with an EFAULT because
>> the 'C' runtime library put some value that the kernel
>> didn't 'like' (4096 bytes) in the subsequent read.
>
>
> If you use a buggy program, that had a hidden bug now exposed because of 
> different kernel checks, dont complain, and use your brain.
>
> If you do
>
> $ export VAR1=" A very very very very long chain just to be sure my 
> environnement (which is placed at the top of the stack at exec() time) will 
> use at least 4 Kb  : then my litle buggy program will run if I type few chars 
> but destroy my stack if I type a long string or if I use : cat longfile | 
> ./xxx : So I wont complain again on lkml that I am sooooo lazy. Oh what could 
> I type now, I'm tired, maybe I can copy this string to others variables. 
> Yes... sure...."
> $ export VAR2=$VAR1
> $ export VAR3=$VAR1
> $ export VAR4=$VAR1
> $ export VAR5=$VAR1
> Then check your env size is large enough
> $ env|wc -c
>   4508
> $ ./xxx
> ./xxx 2>/dev/null
>
> Apparently the kernel thinks 4096 is a good length!
>
> So what ? Your program works well now, on a linux-2.6.11 typical machine. 
> Ready to buffer overflow again.
>
> Maybe you can pay me $1000 :)
>
> Eric Dumazet
>> 
>> This is code for which there are no sources available
>> and it is required to be used, cannot be replaced,
>> cannot be thrown away and costs about US$ 10,000
>> from a company that is no longer in business.
>> 
>> Somebody's arbitrary and capricious addition of spook
>> code destroyed an application's functionality.
>> 
>> Cheers,
>> Dick Johnson
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
