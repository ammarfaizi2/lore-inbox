Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbUAZKnK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 05:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbUAZKnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 05:43:10 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:33225 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264364AbUAZKnF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 05:43:05 -0500
Message-ID: <4014EF35.9090006@cyberone.com.au>
Date: Mon, 26 Jan 2004 21:43:01 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Lutz Vieweg <lkv@isg.de>
CC: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       adilger@clusterfs.com
Subject: Re: Is there a way to keep the 2.6 kjournald from writing to idle
 disks? (to allow spin-downs)
References: <40140B0A.90707@isg.de> <1075058769.1756.8.camel@teapot.felipe-alfaro.com> <4014E8E6.7050007@isg.de>
In-Reply-To: <4014E8E6.7050007@isg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lutz Vieweg wrote:

> Felipe Alfaro Solana wrote:
>
>> On Sun, 2004-01-25 at 19:29, Lutz Vieweg wrote:
>>
>>> I run a server that usually doesn't have to do anything on the local 
>>> filesystems,
>>> it just needs to answer some requests and perform some computations 
>>> in RAM.
>>>
>>> So I use the "hdparm -S 123" parameter setting to keep the (IDE) 
>>> system disk from
>>> spinning unneccessarily.
>>>
>>> Alas, since an upgrade to kernel 2.6 and ext3 filesystem, I cannot 
>>> find a way to
>>> let the harddisk spin down - I found out that "kjournald" writes a 
>>> few blocks every
>>> few seconds.
>>>
>>> As I wouldn't like to downgrade to ext2: Is there any way to keep 
>>> the 2.6 kjournald
>>> from writing to idle disks?
>>>
>>> I cannot see a good reason why kjournald would write when there are 
>>> no dirty buffers -
>>> but still it does.
>>
>>
>>
>> Have you tried playing with the laptop-mode patch? It's already in the
>> -mm kernel tree from Andrew Morton. I've been playing with it a little
>> (just a few minutes) and seems keep the disks spun down for some time.
>
>
> This "laptop-mode" patch would make things far worse than they're now: 
> Spinning
> up the disk about every 10min would reduce their lifetime 
> significantly instead
> of extending it.
>
> It's not a laptop, but a server with an ordinary 3.5" harddisk I'm 
> speaking about,
> my goal is not saving power, but spinning down a harddisk that does 
> not need to
> spin up the whole day long.
>
> What I'm questioning is whether there's a need to write to idle disks 
> at all -
> does anybody know why kjournald writes data even if there is nothing 
> to commit at all?


Because you aren't using the noatime option?


