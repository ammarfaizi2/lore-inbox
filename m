Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUCHWTe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUCHWTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:19:33 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:36594 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261326AbUCHWT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:19:28 -0500
Message-ID: <404CF165.1010402@mvista.com>
Date: Mon, 08 Mar 2004 14:19:17 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       trini@kernel.crashing.org, pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
References: <200403081504.30840.amitkale@emsyssoft.com> <20040308030722.01948c93.akpm@osdl.org> <200403081650.18641.amitkale@emsyssoft.com> <200403081714.05521.amitkale@emsyssoft.com>
In-Reply-To: <200403081714.05521.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Monday 08 Mar 2004 4:50 pm, Amit S. Kale wrote:
> 
>>On Monday 08 Mar 2004 4:37 pm, Andrew Morton wrote:
>>
>>>"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>>>
>>>>On Monday 08 Mar 2004 3:56 pm, Andrew Morton wrote:
>>>> > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>>>> > > Here are features that are present only in full kgdb:
>>>> > >  1. Thread support  (aka info threads)
>>>> >
>>>> > argh, disaster.  I discussed this with Tom a week or so ago when it
>>>> > looked like this it was being chopped out and I recall being told
>>>> > that the discussion was referring to something else.
>>>> >
>>>> > Ho-hum, sorry.  Can we please put this back in?
>>>>
>>>> Err., well this is one of the particularly dirty parts of kgdb. That's
>>>>why it's been kept away. It takes care of correct thread backtraces in
>>>>some rare cases.
>>>
>>>Let me just make sure we're taking about the same thing here.  Are you
>>>saying that with kgdb-lite, `info threads' is completely missing, or does
>>>it just not work correctly with threads (as opposed to heavyweight
>>>processes)?
>>
>>info threads shows a list of threads. Heavy/light weight processes doesn't
>>matter. Thread frame shown is incorrect.
>>
>>I looked at i386 dependent code again. Following code in it is incorrect. I
>>never noticed it because this code is rarely used in full version of kgdb:
>>
>>+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct
>>task_struct *p)
>>....
>>+	gdb_regs[_EBP] = *(int *)p->thread.esp;
>>
>>We can't guss ebp this way. This line should be removed.
>>
>>+	gdb_regs[_DS] = __KERNEL_DS;
>>+	gdb_regs[_ES] = __KERNEL_DS;
>>+	gdb_regs[_PS] = 0;
>>+	gdb_regs[_CS] = __KERNEL_CS;
>>+	gdb_regs[_PC] = p->thread.eip;
>>+	gdb_regs[_ESP] = p->thread.esp;
>>
>>This should be gdb_regs[_ESP] = &p->thread.esp
> 
> 
> That's not correct it. It should be gdb_regs[_ESP] = p->thread.esp;
> Even with these changes I can't get thread listing correctly.
> 
> Here is the intrusive piece of code that helps get thread state correctly. Any 
> ideas on cleaning it?

I wonder what version of gdb you are using.  What is it that you see?

You really do need a gdb that handles the dwarft2 frames.  This is a rather new 
gdb (I use the CVS version).

-g
~

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

