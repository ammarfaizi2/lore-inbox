Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbUCDUyc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 15:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbUCDUyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 15:54:32 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:47087 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262124AbUCDUyZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 15:54:25 -0500
Message-ID: <40479774.9070308@mvista.com>
Date: Thu, 04 Mar 2004 12:54:12 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Andrew Morton <akpm@osdl.org>, ak@suse.de, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, piggy@timesys.com,
       trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <200403041036.58827.amitkale@emsyssoft.com> <20040303211850.05d44b4a.akpm@osdl.org> <200403041059.43439.amitkale@emsyssoft.com>
In-Reply-To: <200403041059.43439.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Thursday 04 Mar 2004 10:48 am, Andrew Morton wrote:
> 
>>"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>>
>>>Flashing keyboard lights is easy on x86 and x86_64 platforms.
>>
>>Please, no keyboards.  Some people want to be able to use kgdboe
>>to find out why machine number 324 down the corridor just died.
>>
>>How about just doing
>>
>>
>>char *why_i_crashed;
>>
>>
>>{
>>	...
>>	if (expr1)
>>		why_i_crashed = "hit a BUG";
>>	else if (expr2)
>>		why_i_crashed = "divide by zero";
>>	else ...
>>}
>>
>>then provide a gdb macro which prints out the string at *why_i_crashed?
> 
> 
> If we can afford to do this (in terms of actions that can be done with the 
> machine being unstable) we can certainly print a console message through gdb.

Not once you are connected to gdb.  The "O" packet can only be sent if the 
program (i.e. kernel) is running as far as gdb knows.  So you could preceed a 
connection with this, but could not used it after gdb knows the kernel is stopped.
> 
> A stub is free to send console messages to gdb at any time. We can send a 
> "'O'hex(Page fault at 0x1234)" packet to gdb regardless of whether 
> CONFIG_KGDB_CONSOLE is configured in. This way kgdb will send this packet to 
> gdb and then immediately report a segfault/trap. To a user it'll appear as a 
> message printed from gdb "Page fault at 0x1234" followed by gdb showing a 
> SIGSEGV etc. The gdb console message should print information other than a 
> signal number.
> 
> -Amit
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

