Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTEEPy2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 11:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTEEPy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 11:54:28 -0400
Received: from lakemtao02.cox.net ([68.1.17.243]:21674 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP id S262439AbTEEPy0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 11:54:26 -0400
Message-ID: <3EB68C13.9080000@cox.net>
Date: Mon, 05 May 2003 11:06:43 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69
References: <Pine.LNX.4.44.0305050851080.18785-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305050851080.18785-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> [ Linux-kernel added to the cc, since I got several queries about what the 
>   crashes were.. ]
> 
> On Mon, 5 May 2003, David van Hoose wrote:
> 
>>Can I get some details regarding the AGP problem? I had some really bad 
>>random crashes, panics, and hardlocks up through 2.5.68, and I'm 
>>wondering if this is the same issue. I first noticed them around 2.5.63. 
> 
> 
> They actually started in 2.5.60 if it's the same bug.
> 
> And yes, you'd get random crashes, panics, lockups and even reboots. The 
> problem was that the pmd/pgd's were put in the slab cache in between 
> 2.5.59 and 2.5.60, and that was simply wrong because the AGP code changes 
> the cacheability of the kernel pages when it maps stuff into the AGP 
> aperture. That in turn will change the page tables but it won't update the 
> cached entries in the pmd slab caches. 
> 
> So what happens is that once you exit X, and the page tables are put back
> together without the cacheability changes, and you start a new program,
> that program may get a page table with partly bogus kernel page table
> entries.
> 
> That, in turn, when it happens will cause _major_ memory corruption, and
> your machine is toast, often in very interesting ways because the internal
> kernel data structures got corrupted. It can also cause random SIGSEGV's
> etc.
> 
> But it only happens with AGP, and a lot of people either don't use it or 
> run only one X session.

Okay.. I kept having all of those problems. I guess the memory 
corruption could also explain the buffer overflow in the panic 
information I posted around the time of 2.5.65 then. I'll stick the beta 
kernel back on my system and play with it again. If I find anything 
else, I'll be sure to mention it. Don't want any nasty bugs like that 
hiding in 2.6.x.

Thanks!
David

