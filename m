Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUAQTzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 14:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbUAQTzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 14:55:15 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:41463 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266204AbUAQTzG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 14:55:06 -0500
Message-ID: <40099301.6000202@mvista.com>
Date: Sat, 17 Jan 2004 11:54:41 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Pavel Machek <pavel@suse.cz>, Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Matt Mackall <mpm@selenic.com>, discuss@x86-64.org
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
References: <200401161759.59098.amitkale@emsyssoft.com> <20040116215144.GA208@elf.ucw.cz> <40088E9D.1010908@mvista.com> <200401171459.01794.amitkale@emsyssoft.com>
In-Reply-To: <200401171459.01794.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Saturday 17 Jan 2004 6:53 am, George Anzinger wrote:
> 
>>Pavel Machek wrote:
>>
>>>Hi!
>>>
>>>
>>>>KGDB 2.0.3 is available at
>>>>http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2
>>>>
>>>>Ethernet interface still doesn't work. It responds to gdb for a couple of
>>>>packets and then panics. gdb log for ethernet interface is pasted below.
>>>>
>>>>It panics and enter kgdb_handle_exception recursively and silently. To
>>>>see the panic on screen make kgdb_handle_exception return immediately if
>>>>kgdb_connected is non-zero.
>>>>
>>>>Panic trace is pasted below. It panics in skb_release_data. Looks like
>>>>skb handling will have to changed to be have kgdb specific buffers.
>>>
>>>This seems to be needed (if I unselect CONFIG_KGDB_THREAD, I get
>>>compile error on x86-64).
>>
>>Amit, could you explain why this is an option?  It seems very useful and
>>not really too much code...
> 
> 
> It saves all registers before switch_to. It does that two times at present. 
> Once (implicit) register save by gcc and an explicit register save in 
> arch/<proc>/kernel/entry.S Second register save in kern_schedule generates a 
> pt_regs structure which gdb can get all registers at once from. If it's 
> omited, gdb has to figure out where gcc has saved registers from the 
> non-standards code in switch_to, which it can't do correctly all the time.
> 
> We can have a check for (a new variable) debugger_enabled before calling 
> kern_schedule. That'll be add negligible overhead and will allow extra thread 
> info to be saved only when a debugger is enabled. There will not be any need 
> for CONFIG_KGDB_THREAD also.

I don't seem to have such a problem with the mm kgdb.  No kern_schedule there...

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

