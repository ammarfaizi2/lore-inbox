Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbUCDXPg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 18:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbUCDXPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 18:15:36 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:16118 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261960AbUCDXPd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 18:15:33 -0500
Message-ID: <4047B88C.9010805@mvista.com>
Date: Thu, 04 Mar 2004 15:15:24 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       piggy@timesys.com
Subject: Re: kgdb support in vanilla 2.6.2
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <200403041036.58827.amitkale@emsyssoft.com> <20040303211850.05d44b4a.akpm@osdl.org> <200403041059.43439.amitkale@emsyssoft.com> <40479774.9070308@mvista.com> <20040304210333.GG26065@smtp.west.cox.net>
In-Reply-To: <20040304210333.GG26065@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Thu, Mar 04, 2004 at 12:54:12PM -0800, George Anzinger wrote:
> 
>>Amit S. Kale wrote:
>>
>>>On Thursday 04 Mar 2004 10:48 am, Andrew Morton wrote:
>>>
>>>
>>>>"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>>>>
>>>>
>>>>>Flashing keyboard lights is easy on x86 and x86_64 platforms.
>>>>
>>>>Please, no keyboards.  Some people want to be able to use kgdboe
>>>>to find out why machine number 324 down the corridor just died.
>>>>
>>>>How about just doing
>>>>
>>>>
>>>>char *why_i_crashed;
>>>>
>>>>
>>>>{
>>>>	...
>>>>	if (expr1)
>>>>		why_i_crashed = "hit a BUG";
>>>>	else if (expr2)
>>>>		why_i_crashed = "divide by zero";
>>>>	else ...
>>>>}
>>>>
>>>>then provide a gdb macro which prints out the string at *why_i_crashed?
>>>
>>>
>>>If we can afford to do this (in terms of actions that can be done with the 
>>>machine being unstable) we can certainly print a console message through 
>>>gdb.
>>
>>Not once you are connected to gdb.  The "O" packet can only be sent if the 
>>program (i.e. kernel) is running as far as gdb knows.  So you could preceed 
>>a connection with this, but could not used it after gdb knows the kernel is 
>>stopped.
> 
> 
> If GDB is already connected and sitting by waiting, you can send the O
> packet.  If it is not, you could delay sending the O packet until you
> know that GDB has now connected.
> 
> This isn't an unworkable idea, but it's probably better to just set
> *why_i_crashed (think work work work, oh wait, what caused this again?)
> and provide some handy macros (which we should be in the docs anyhow).

Well, I did provide a "come_from" macro, but more definition could be had...

On the subject of macros, I am being convinced by the gdb folks that the way to 
do the info threads thing is with macros.  We get almost all we want this way 
without messing with gdb or lying to it the way the -mm kgdb does.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

