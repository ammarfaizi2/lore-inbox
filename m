Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbTKYXkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 18:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTKYXkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 18:40:40 -0500
Received: from cantvc.canterbury.ac.nz ([132.181.2.36]:28688 "EHLO
	cantvc.canterbury.ac.nz") by vger.kernel.org with ESMTP
	id S263702AbTKYXkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 18:40:37 -0500
Date: Wed, 26 Nov 2003 12:40:28 +1300
From: Oliver <ojh16@student.canterbury.ac.nz>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
In-reply-to: <3FC3E2F4.4080809@softhome.net>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: linux-kernel@vger.kernel.org
Message-id: <3FC3E86C.5040205@student.canterbury.ac.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.5b)
 Gecko/20030727 Thunderbird/0.1
References: <3FC358B5.3000501@softhome.net>
 <Pine.LNX.4.53.0311251510310.6584@chaos> <3FC3E2F4.4080809@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought it did return NULL, now...  Before that i didn't check for NULL :)

--Oliver

Ihar 'Philips' Filipau wrote:

> Richard B. Johnson wrote:
> 
>>
>> As documented, malloc() will never fail as long as there
>> is still address space (not memory) available. This is
>> the required nature of the over-commit strategy. This is
>> necessary because many programs never even touch all the
>> memory they allocate.
>>
> 
>   We are reading different mans? My man malloc(3) clearly states that 
> malloc() can return NULL. (*)
> 
>   May I ask you one question? Did you were ever doing once graceful
> failure of application under memory pressure? Looks like not.
> 
>   I can guess why sendmail allocates memory it never touches - memory
> pools. There are situations where you really cannot fail - and memory
> allocation failures are really nasty. Do you wanna to lose your e-mails? 
> No? So then think twice, while implementing lazy allocators.
> 
>   So from my tests I see that by default Linux is not safe. You allocate
> memory - malloc() != NULL. Then later you try to write to this memory
> and you get killed by oom_killer. What is the point of this? Your
> reasoning doesn't sound to me.
> 
>   Memory pools used by applications exactly to make grace error
> handling under memory pressure - but it looks like this stuff under
> Linux gets no testing at all. And default settings could make from
> simple bug complete disaster.
> 
>  > You can turn OFF over-commit by doing:
>  >
>  > echo "2" >proc/sys/vm/overcommit_memory
>  >
>  > However, you will probably find that many programs fail
>  > or seg-fault when normally they wouldn't. So, if you don't
>  > mind restarting sendmail occasionally, then turn off over-commit.
>  >
> 
>   I shall try overcommit_memory == 2 tomorrow and say what I see.
> 
> P.S. For example application I have ported right now to kernel space has
> a limitiation - it must never ever allocate memory: memory consumption
> is known, protocol just have no situation like ENOMEM - it _must_ fail
> to initialize on start-up. No - not to being killed by oom_killer in
> middle of processing. think carrier grade and/or just good programming
> technics.
> 
> (*) Great optimization opportunities: remove from all programmes checks 
> of the return value if malloc(). As by your words - why not?
> 


