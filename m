Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUIEDwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUIEDwG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 23:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUIEDwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 23:52:06 -0400
Received: from mta1.wss.scd.yahoo.com ([66.218.85.32]:53713 "EHLO
	mta1.wss.scd.yahoo.com") by vger.kernel.org with ESMTP
	id S266181AbUIEDwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 23:52:00 -0400
Message-ID: <413A8D50.1040304@putzin.net>
Date: Sat, 04 Sep 2004 22:51:44 -0500
From: Pete <pete@putzin.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arne Henrichsen <ahenric@yahoo.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: sys_sem* undefined
References: <20040827092605.63433.qmail@web41504.mail.yahoo.com>
In-Reply-To: <20040827092605.63433.qmail@web41504.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arne Henrichsen wrote:

>>From an application (userspace) or from inside the
>>kernel?
>>    
>>
>
>I need to do the syscalls from kernel space. Basically
>I am porting our custom vxWorks driver to Linux. We
>want to basically keep the structure of the vxWorks
>driver the same, so I am porting the individual
>vxWorks functions such as semBcreate, semGive etc.
>Thats why I want to use the SysV IPC semaphores, as
>they seem to most closely resemble the vxWorks ones. I
>know that there are much better ways of writing a
>driver, but that wouldn't fit in with the currect
>structure we have at the moment.
>
>Now if I want to call lets say sys_semget() from
>kernel space, must I use the _syscall3() function? I
>saw some people using this. 
>
>Thanks for the help.
>Arne
>
>
>	
>  
>
Speaking as someone who has traveled down this road previously, I would 
suggest that you re-engineer your driver instead of going with your 
current plan. I realize that you think this would be quicker and easier, 
but the maintenance headaches are pretty heavy as you get further into 
this. Doing a driver the "right" way to fit the kernel makes sense 
because it becomes very easy to maintain, whereas your method will 
require much more work for changes to kernel versions, or changes to 
core logic. I'm guessing the driver is pretty mature at this point, but 
you still live with maintaining with the kernel.

As a side note, there are a lot of things that you might assume should 
be a driver because that's sort of how it works in the VxWorks system, 
but may map just as well to userspace, or some combo of userspace and 
kernel space. Essentially, all software in VxWorks is part of the 
kernel, so it's easy to just assume that what you are doing must be in 
the kernel as well. Again, I've been working on a project for 5+ years 
that was 3+ years of VxWorks, and is now migrating to Linux. I had to go 
through a lot of this stuff as well.

Basically, I'm saying that there are better ways to do what you want to 
do, but it's gonna involve some more up front work for you. I'd be 
willing to chat more about this if you feel the urge off the list.

Pete Buelow

