Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbUCDAXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbUCDAXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:23:04 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:49393 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261312AbUCDAVA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:21:00 -0500
Message-ID: <40467662.4050309@mvista.com>
Date: Wed, 03 Mar 2004 16:20:50 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Tom Rini <trini@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][2/3] Update CVS KGDB's have kgdb_{schedule,process}_breakpoint
References: <20040225213626.GF1052@smtp.west.cox.net> <200403011402.29642.amitkale@emsyssoft.com> <4044FA72.1030005@mvista.com> <200403031043.59092.amitkale@emsyssoft.com>
In-Reply-To: <200403031043.59092.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Wednesday 03 Mar 2004 2:49 am, George Anzinger wrote:
> 
>>Amit S. Kale wrote:
>>
>>>On Friday 27 Feb 2004 4:49 am, George Anzinger wrote:
>>>
>>>>Amit S. Kale wrote:
>>>>
>>>>>On Thursday 26 Feb 2004 3:13 am, Tom Rini wrote:
>>>>>
>>>>>>The following adds, and then makes use of kgdb_process_breakpoint /
>>>>>>kgdb_schedule_breakpoint.  Using it i kgdb_8250.c isn't strictly
>>>>>>needed, but it isn't wrong either.
>>>>>
>>>>>That makes 8250 response it a _bit_ slower. A user will notice when kgdb
>>>>>doesn't respond within a millisecond of pressing Ctrl+C :-)
>>>>
>>>>Hm...  I have been wondering if it might not be a good idea to put some
>>>>comments to the user at or around the breakpoint.  Possibly we might want
>>>>to tell the user about where the info files are or some such.  This would
>>>>then come up on his screen when the source code at the breakpoint is
>>>>displayed.
>>>
>>>Err, well, I don't seem to understand this.
>>>
>>>Do you mean we print a (gdb) console message that indicates something
>>>about a breakpoint? If we do that, there has to be a way to turn it off.
>>>I have a (rather bad) habit of stepping through kernel code :-)
>>
>>No that is not what I mean.  I don't want to try to send messages to the
>>gdb console (it is not supported by gdb at this time).  Rather, the hard
>>coded breakpoint instruction that we use to get to the the stub when the
>>user enters a ^C is in a particular bit of source code.  Most gdb front
>>ends display this bit of source centered on the breakpoint instruction. 
>>What I am asking about is puting something useful here from the user point
>>of view.  For example we might have this:
>>
>>/*
>>  * This is the KGDB control C break point.  For additional info on KGDB
>>options * and suggested macros see .../Documentation/kgdb/* in your kernel
>>tree. * KGDB version XX.YY
>>  */
>>	BREAKPOINT;
>>
>>--------------------------------------
> 
> 
> This is definitely a good point.
> 
> We may also report the exact location where kernel was running when Ctrl+C 
> came in. We have pt_regs available in do_IRQ. We can pass that to process 
> breakpoint function. The process breakpoint function can then straight call 
> handle_exception passing it pt_regs instead of going through breakpoint. That 
> will save some stack also.

Uh, I would think that "bt" should cover this.  Why muddy the waters with other 
stuff.  I think the user should see exactly where he is going to go on the 
continue.  One really good reason for this is that this is the context any

p fun()

will run in.

~

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

