Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbTFMQv1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbTFMQv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:51:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:35981 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265359AbTFMQvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:51:19 -0400
Date: Fri, 13 Jun 2003 10:06:57 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Steven Dake <sdake@mvista.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <3EE9FC6B.6020204@mvista.com>
Message-ID: <Pine.LNX.4.44.0306130952130.908-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >Please define: 
> >
> >- 'lots'
> >  
> >
> i tested 12 devices
> 
> >- 'poor'
> >
> 80% slower for enumeration.

Prove it. :)

> >>2) lots of processes can be forked with no policy to control how many 
> >>are forked at once potentially leading to OOM
> >>    
> >>
> >
> >Have you seen this happen? Sure, it's theoretically possible, but I highly 
> >doubt it will ever happen on a real system. Typically, if you have an 
> >astronomical number of devices, then you'll have an incredible amount of 
> >memory, too. Please post a bug report when you see this.
> >  
> >
> I have not seen this happen, however, it seems clear that it would 
> happen if /sbin/hotplug were called a sufficient number of times.

You have the same problem, theoretically. If the daemon dies, the event 
queue will fill and the system will crash. With the current scheme, user 
processes will be killed and we will lose hotplug events. With your 
scheme, the entire system will crash eventually. 

> >Thirdly, /sbin/hotplug is an ASCII interface, providing flexibility in the
> >userspace agent implementations. Your character device (which is not
> >appreciated) forces the userspace tools to use select(2), poll(2), or
> >ioctl(2). No simple read(2)/write(2). Binary interfaces == Bad(tm). If you 
> >have doubts, please read the threads concerning binary vs. ASCII 
> >interfaces over the last two years before replying. 
> >  
> >
> I believe it is highly desireable to be able to use select. Imagine the 
> case where the kernel generates an event, and some external agent, that 
> wants to enumerate devices, must also generate an event. This allows a C 
> program to select which fd to use for I/O. I don't understand the 
> problems with binary interfaces, as they are numerous in the kernel. For 
> an example, take a look at the syscall interface!

That doesn't mean they're the right thing to do in all cases. Binary
interfaces may offer better performance, but they're harder to maintain,
harder to debug, and harder to write agents to use them. You may be so
smart and arrogant to disregard those things as trite, but they are
important, from a long-term development standpoint. 

Again, please read the archives concerning this topic on linux-kernel 
before commenting on this subject again. 

> I did not disregard Greg's comments. The bottom line is the performance 
> issues and out-of-order issues have not been addressed. Perhaps the 
> out-of-order issue can be addressed, but performance of /sbin/hotplug 
> will _always_ be slower then the operation of one process on an event 
> queue. You can wait until enough people bitch about the performance of 
> /sbin/hotplug and evolve /sbin/hotplug into the scheme I propose, or you 
> can take this patch as is. I really don't care as I don't make patches 
> available for my benefit; they are for the benefit of the community.

Ok, I'll wait. I would rather see slow, marked improvements then blindly 
applying and believing the whims of some random kernel hacker under the 
farce of altruism and increased availability. 

> Finally, I didn't realize the sandbox was full. If you don't want to 
> play with my toys, you certainly don't have to.

It isn't full, and I will not touch your toys, thank you very much. But,
one of the first social rules that people usually learn in the sandbox is
that in order to play with the other kids, you have to play their games
with their rules.


	-pat

