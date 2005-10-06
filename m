Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbVJFTY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVJFTY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVJFTY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:24:29 -0400
Received: from mail.weatherflow.com ([65.57.243.55]:3345 "EHLO weatherflow.com")
	by vger.kernel.org with ESMTP id S1751324AbVJFTY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:24:28 -0400
Message-ID: <434579DD.3000104@weatherflow.com>
Date: Thu, 06 Oct 2005 15:24:13 -0400
From: Robert Derr <rderr@weatherflow.com>
User-Agent: Thunderbird 1.4 (Windows/20050908)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: 2.6.13.3 Memory leak, names_cache
References: <43456E31.8000906@weatherflow.com> <Pine.LNX.4.64.0510061150290.31407@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510061150290.31407@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: rderr@weatherflow.com
X-Spam-Processed: weatherflow.com, Thu, 06 Oct 2005 15:24:17 -0400
	(not processed: message from valid local sender)
X-MDRemoteIP: 24.227.114.94
X-Return-Path: rderr@weatherflow.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Thu, 6 Oct 2005, Robert Derr wrote:
>   
>> I'm having a problem with a memory leak in the kernel.  I'm running 2.6.13.3
>> from kernel.org on FC4 on a Dell  Poweredge 2850 Duel Xeon 3ghz with 2GB RAM.
>>     
>
> Just out of interest, do you have CONFIG_AUDIT_SYSCALL enabled? Does it go 
> away if you disable it?
>   
It looks like it is enabled.  CONFIG_AUDITSYSCALL=y in .config, right?
> Also, what filesystems do you use? And if you run
>
> 	while : ; do cat /proc/slabinfo | grep names_cache ; sleep 2; done
>
> in one terminal, can you see if you can find any correlation to some 
> particular action or behaviour that would seem to be part of leaking it?
>   
I'm not sure if I can find the action or behavior causing the problem.  
The server is the master node on a 14 computer cluster running a 
mesoscale weather forecasting package so there's a million things going 
on all the time.  I guess I could write a program to compare all the 
processes running against the names_cache and look for any correlation.

Here's the output of mount.  The drives are all ext3

/dev/sda2 on / type ext3 (rw)
/dev/proc on /proc type proc (rw)
/dev/sys on /sys type sysfs (rw)
/dev/devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/sda1 on /boot type ext3 (rw)
/dev/shm on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
> It really shouldn't grow very big at all normally. Ie the counts are 
> normally something like a few tens of entries used or whatever - all the 
> allocations should basically be temporary, and your 200+ _thousand_ 
> entries are way out of line.
>
> If you can't find anything obvious, then we can try to figure out a way to 
> just print out the contents of your name entries, I bet that would give a 
> clue about who is allocating them. But there's also been various leak 
> debugging patches out there that may help.  Manfred may have pointers.
>
> 		Linus
>   
I'll look for those leak debugging patches.
Thanks for your time. 

Robert J Derr
Weatherflow, Inc.


