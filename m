Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbUBYWCI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbUBYV70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:59:26 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:28666 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261654AbUBYV6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:58:16 -0500
Message-ID: <403D1A72.5000906@mvista.com>
Date: Wed, 25 Feb 2004 13:58:10 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Diehl <lists@mdiehl.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: tasklets vs. workqueues
References: <Pine.LNX.4.44.0402252205580.18112-100000@notebook.home.mdiehl.de>
In-Reply-To: <Pine.LNX.4.44.0402252205580.18112-100000@notebook.home.mdiehl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Diehl wrote:
> On Wed, 25 Feb 2004, George Anzinger wrote:
> 
> 
>>>>Being in process context, you can also change the priority and schedule policy 
>>>>as needed to fit your application, while you are rather stuck with tasklets in 
>>>>this regard.
>>>
>>>
>>>How would one do that correctly? Something like
>>
>>Depends on where you want to be when you do it.  From user land you would do 
>>exactly what the attached program does.  In SMP you would, likely, want to do 
>>all the tasks in the work queue (one per cpu).
> 
> 
> Ok, thanks - primary concern was kernelthread anyway. Sorry if I wasn't 
> clear enough.
> 
> 
>> From the kernel, again calling setscheduler() is the way to go.  I am not sure 
>>what is in the community tree just now, but if I recall properly, the scheduler 
>>itself does this so, one should be able to copy that code.
>>
>>Ah, yes, there it is in  migration_thread().  It calls setscheduler().
> 
> 
> Basically yes. Except that setscheduler is static in kernel/sched.c so one 
> has to use sys_sched_setscheduler (and add some EXPORT_SYMBOL for it). And 
> of course it needs the set_fs(KERNEL_DS) magic.

I don't think it needs the set_fs(KERNEL_DS) magic if you use the internal 
setscheduler().  If it is static, that should be changed.... as well as the 
EXPORT  sigh.
-g
> 
> Thanks, I was hoping I've missed some simple "official" entry point there 
> to create a SCHED_FIFO kernel thread from a module.
> 
> Martin
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

