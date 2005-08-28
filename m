Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVH1Ta5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVH1Ta5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 15:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVH1Ta5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 15:30:57 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:4500 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750756AbVH1Ta5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 15:30:57 -0400
Date: Sun, 28 Aug 2005 21:30:46 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
In-Reply-To: <20050828080959.GB2039@elf.ucw.cz>
Message-ID: <Pine.LNX.4.62.0508282109040.1489@artax.karlin.mff.cuni.cz>
References: <1125069494.18155.27.camel@betsy> <20050827124148.GE1109@openzaurus.ucw.cz>
 <Pine.LNX.4.62.0508280453320.13233@artax.karlin.mff.cuni.cz>
 <20050828080959.GB2039@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Of late I have been working on a driver for the IBM Hard Drive Active
>>>> Protection System (HDAPS), which provides a two-axis accelerometer and
>>>> some other misc. data.  The hardware is found on recent IBM ThinkPad
>>>> laptops.
>>>>
>>>> The following patch adds the driver to 2.6.13-rc6-mm2.  It is
>>>> self-contained and fairly simple.
>>>
>>> Do we really need input interface *and* sysfs interface? Input should be
>>> enough.
>>
>> I think he doesn't need to export it at all and he should write code to
>> park and disable hard disk instead.
>> (in userspace it's unsolvable --- i.e. you can't enable hard disk when
>> detected stable condition if the daemon is swapped out on that hard disk)
>
> man mlockall() :-).

You also must not use any syscall that allocates even temporary memory in 
kernel (select, poll, many others ...) or that waits on semaphore that 
might be held while allocating memory (i.e. audit and rewrite ide ioctl 
path).

And you need extra flags to protect the daemon from being killed at 
shutdown or blocked at suspend.

I think writing it as kernel thread would be easir than all this.

> Accelerometer is usefull for other stuff besides parking heads, like
> playing marble madness or what is the name of the game, and even
> parking heads is way too complex to be put into the kernel.
>
> Even if you don't like mlockall(), you can put timeout into
> disk-freezing interface.

That makes the protection less reliable (you shake the notebook and after 
the timeout drop it).

Mikulas

> 								Pavel
> -- 
> if you have sharp zaurus hardware you don't need... you know my address
>
