Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbUKDBSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbUKDBSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 20:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUKDBSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 20:18:43 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:46499 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S261929AbUKDBSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:18:21 -0500
Message-ID: <4189838E.1030808@metaparadigm.com>
Date: Thu, 04 Nov 2004 09:19:10 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, DervishD <lkml@dervishd.net>,
       Gene Heskett <gene.heskett@verizon.net>,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411031353.39468.gene.heskett@verizon.net><200411031353.39468.gene.heskett@verizon.net> <20041103192648.GA23274@DervishD> <418964A3.7030105@tmr.com>
In-Reply-To: <418964A3.7030105@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/04 07:07, Bill Davidsen wrote:
> DervishD wrote:
> 
>>     Hi Gene :)
>>
>>  * Gene Heskett <gene.heskett@verizon.net> dixit:
>>
>>>>   Then the children are reparented to 'init' and 'init' gets rid
>>>> of them. That's the way UNIX behaves.
>>>
>>>
>>> Unforch, I've *never* had it work that way.  Any dead process I've 
>>> ever had while running linux has only been disposable by a reboot.
>>
>>
>>
>>     Well, you know, shit happens... Anyway, could you define 'dead'?
>> Because if you're talking about zombies whose parent dies, they're
>> killable easily: just wait until init reaps them (usually in less
>> than 5 minutes since they dead). If you are talking about zombies who
>> has their parent alive, then it's a bug in the application, not the
>> kernel. In fact I wouldn't like if the kernel reaps my children
>> before I do, just in case I want to do something.
>>
>>     If you're talking about unkillable processes (those stuck in
>> disk-sleep state), you're right: only rebooting can kill them
>> (although sometimes they go out of D state and die normally). Bad
>> luck for you if any dead process you've ever had while running linux
>> has been of this kind :(
> 
> 
> That often seems to be the case, the kernel thinks there's an i/o going 
> on which isn't, and doesn't time it out. It would be nice if there were 
> a way to get the kernel to abort all outstanding i/o on kill -9, but I'm 
> sure if it were easy it would have happened. Timeouts in the application 
> are useful, but in some cases I believe the process dies because it 
> detects a long i/o time but has nothing to do but terminate, which 
> creates the zombie.

It could be any driver code that uses uninterruptible sleeps rather
than interruptible sleeps I believe. If a process is doing a read or
write to one of these devices and it stays stuck in kernel code with
TASK_UNINTERRUPTIBLE and never gets it's expected wake up, then the
signal will never be delivered and the process is stuck indefinately.
The buggy driver code needs to be fixed (either to use interruptible
sleeps and handle the signals or to imlement some sort of timeout).

~mc
