Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbUBYWdD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbUBYWcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:32:46 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:28655 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261668AbUBYWbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:31:19 -0500
Message-ID: <403D2230.8070000@mvista.com>
Date: Wed, 25 Feb 2004 14:31:12 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Pavel Machek <pavel@suse.cz>, "Amit S. Kale" <amitkale@emsyssoft.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: kgdb: rename i386-stub.c to kgdb.c
References: <20040224130650.GA9012@elf.ucw.cz> <200402251303.50102.amitkale@emsyssoft.com> <20040225103703.GB6206@atrey.karlin.mff.cuni.cz> <403D10DB.8060506@mvista.com> <20040225212826.GE1052@smtp.west.cox.net>
In-Reply-To: <20040225212826.GE1052@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Wed, Feb 25, 2004 at 01:17:15PM -0800, George Anzinger wrote:
> 
>>Pavel Machek wrote:
>>
>>>Hi!
>>>
>>>
>>>
>>>>>kgdb uses really confusing names for arch-dependend parts. This fixes
>>>>>it. Okay to commit?
>>>>
>>>>Why is arch/$x/kernel/$x-stub.c confusing? The name $x-stub.c is 
>>>>indicative of architecture dependent code in it. Err, well so is the path.
>>>
>>>
>>>
>>>Well, looking at i386-stub.c, how do you know it is kgdb-related?
>>>
>>>
>>>
>>>>PPC and sparc stubs in present vanilla kernel use this naming convention. 
>>>>That's why I adopted it.
>>>>
>>>>I find kernel/kgdbstub.c, arch/$x/kernel/$x-stub.c more consistent 
>>>>compared to kernel/kgdbstub.c, arch/$x/kernel/kgdb.c
>>>
>>>
>>>I actually made it kernel/kgdb.c and arch/*/kernel/kgdb.c. I believe
>>>there's no point where one could be confused....
>>
>>gdb itself gets confused with this.  Try, for example, time.c which, on the 
>>x86, is in both arch and common code.  I use emacs with kgdb and it gets 
>>confused when I point at a location in the source and tell it to set a 
>>break point.
>>
>>Please, lets have only one of each name.
> 
> 
> We can't.  We've had various things (most notably MODVERSIONS prior to
> 2.6) which are unhappy with that, and in the end, the problem ends up
> being fixed elsewhere.  In fact, this should be able to as well.  Using
> your time.c example:
> (gdb) break arch/i386/kernel/time.c:set_rtc_mmss
> Breakpoint 3 at 0xc010ee90: file arch/i386/kernel/time.c, line 174.
> (gdb) break kernel/time.c:sys_time 
> Breakpoint 4 at 0xc011f0cc: file time.h, line 301.
> 
> So shouldn't it be a matter of somehow just not having a time.c
> reference as well in the debug data?

No it is related to the point and grunt option in emacs:

I would guess it is a problem in the emacs interface where one points at a 
location in the code window and enters a command to set a break point ( I think 
it is "^x " (control X space)).  It would appear that emacs then only sends the 
file name to gdb rather than the full path.

This is not a show stopping problem, only confusing.  Once gdb figures out the 
right source, all is well.  I usually do it by setting a break point at the 
function by name, thus avoiding the point and grunt thing.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

