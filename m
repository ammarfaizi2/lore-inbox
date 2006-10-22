Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWJVRBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWJVRBg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 13:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWJVRBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 13:01:36 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:52946 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1751294AbWJVRBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 13:01:35 -0400
Message-ID: <453BA3E9.4050907@qumranet.com>
Date: Sun, 22 Oct 2006 19:01:29 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <200610221723.48646.arnd@arndb.de> <453B99D7.1050004@qumranet.com> <200610221851.06530.arnd@arndb.de>
In-Reply-To: <200610221851.06530.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2006 17:01:34.0752 (UTC) FILETIME=[BAE0AA00:01C6F5FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> I don't think it's that different. The Cell SPU scheduler is also
> implemented in kernel space. Every application using an SPU program
> has its own contexts in spufs and doesn't look at the others.
>
>   

Okay, I've misunderstood you before.


> While we don't have it yet, we're thinking about adding a sputop
> or something similar that shows the utilization of spus. You don't
> need that one, since get exactly that with the regular top, but you
> might want to have a tool that prints statistics about how often
> your guests drop out of the virtualisation mode, or the number
> of interrupts delivered to them.
>
>   

We have a debugfs interface and a kvm_stat script which shows exactly 
that (including a breakdown of the reasons for the exit).

>>> Have you thought about simply defining your guest to be a section
>>> of the processes virtual address space? That way you could use
>>> an anonymous mapping in the host as your guest address space, or
>>> even use a file backed mapping in order to make the state persistant
>>> over multiple runs. Or you could map the guest kernel into the
>>> guest real address space with a private mapping and share the
>>> text segment over multiple guests to save L2 and RAM.
>>>  
>>>       
>> I've thought of it but it can't work on i386 because guest physical
>> address space is larger than virtual address space on i386.  So we
>> mmap("/dev/kvm") with file offsets corresponding to guest physical
>> addresses.
>>
>> I still like that idea, since it allows using hugetlbfs and allowing
>> swapping.  Perhaps we'll just accept the limitation that guests on i386
>> are limited.
>>     
>
> What is the point of 32 bit hosts anyway? Isn't this only available
> on x86_64 type CPUs in the first place?
>   

No, 32-bit hosts are fully supported (except a 32-bit host can't run a 
32-bit guest).

Admittedly, virtualization is a memory-intensive operation, so a 64-bit 
host will usually be used.


-- 
error compiling committee.c: too many arguments to function

