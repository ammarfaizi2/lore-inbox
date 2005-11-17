Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVKQVYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVKQVYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVKQVYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:24:10 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:1873 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1751253AbVKQVYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:24:08 -0500
Message-ID: <437CF478.7010406@samwel.tk>
Date: Thu, 17 Nov 2005 22:22:00 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Bradley Chapman <kakadu@gmail.com>
CC: linux-kernel@vger.kernel.org, Jan Niehusmann <jan@gondor.com>
Subject: Re: Laptop mode causing writes to wrong sectors?
References: <e294b46e0511170522v5762d48jcaff8413e33b2ebe@mail.gmail.com>	 <437C9334.3020606@samwel.tk> <e294b46e0511170822w79e5478asf49183c8447c7c77@mail.gmail.com>
In-Reply-To: <e294b46e0511170822w79e5478asf49183c8447c7c77@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley Chapman wrote:
> Mr. Samwel,
> 
> On 11/17/05, Bart Samwel <bart@samwel.tk> wrote:
>> OK, that's the second report then. I'm beginning to worry. :/
>>
>> Are you seeing any DMA timeout messages in your kernel log?
> 
> Once, when my /var partition got trashed - about thirty or forty loud
> and scary messages from the IDE core saying that various disk accesses
> (i.e. normal read/writes) were failing. I do believe DMA was
> mentioned.

This could be the problem I was talking about. Was this happening during 
spindown or not?

> Another time (i.e. just now), I got five Oopses in a row, most of them
> in kmem_cache_alloc() but with one in generic_aio_file_read(). 
> Unfortunately I am using fglrx right now so they are probably quite
> meaningless...*

I guess so. They all oops on reading the same address (0x05c2a5bb), 
there's something corrupted in the slab cache, cause unknown. Very 
possibly fglrx.

> Most of the time though, I don't see anything.

...while still experiencing corruption?

>> Bradley, Jan, since when have these problems been happening? Kernel
>> version-wise, I mean?
> 
> They started with 2.6.13. I can't remember ever expereincing random
> partition trashing or random file corruption in 2.6.12. I tried
> 2.6.14.1 - that kernel did Bad Things as well.
> 
> So far though, as long as I stay on juice, 2.6.13 seems to behave.

Hmmmm. This means that you could still be experiencing the same thing 
that Andrea Gelmini was reporting. Could you try the things he said made 
it worse, and check if things go wrong? You are, of course, allowed to 
decline because of the risk involved. :-) The things are:

Big activity:

* iozone -A
* unrar big file
* In order to make it happen faster:
	cd /proc/sys/vm
	echo 100 > dirty_background_ratio
	echo 1000000 > dirty_expire_centisecs
	echo 100 > dirty_ratio
	echo 1000000 > dirty_writeback_centisecs

--Bart
