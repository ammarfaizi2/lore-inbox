Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUCDAoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbUCDAoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:44:12 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:58359 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261377AbUCDAm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:42:28 -0500
Message-ID: <40467B69.3020109@mvista.com>
Date: Wed, 03 Mar 2004 16:42:17 -0800
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
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <20040302132751.255b9807.akpm@osdl.org> <40451E50.4080806@mvista.com> <200403031038.39339.amitkale@emsyssoft.com>
In-Reply-To: <200403031038.39339.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Wednesday 03 Mar 2004 5:22 am, George Anzinger wrote:
> 
>>Andrew Morton wrote:
>>
>>>George Anzinger <george@mvista.com> wrote:
>>>
>>>>Often it is not clear just why we are in the stub, given that
>>>>we trap such things as kernel page faults, NMI watchdog, BUG macros and
>>>>such.
>>>
>>>Yes, that can be confusing.  A little printk on the console prior to
>>>entering the debugger would be nice.
>>
>>That assumes that one can do a printk and not run into a lock.  Far better
>>IMNSHO is to provide a simple way to get it from gdb.  One can then even
>>provide a gdb macro to print the relevant source line and its surrounds.  I
>>my lighter moments I call this the comefrom macro :)  In my kgdb it would
>>look like:
>>
>>l * kgdb_info.called_from
> 
> 
> How about echoing "Waiting for gdb connection" stright into the serial line 
> without any encoding? Since gdb won't be connected to the other end, and many 
> a times a minicom could be running at the other end, it'll give a user an 
> indication of kgdb being ready.

Uh, different solution for a different problem.  The above command to gdb causes 
the source code around the location "kgdb_info.called_from" to be displayed.  In 
the -mm version, this is location is filled in by kgdb with the return address 
for the "kgdb_handle_exception()".  This allows you to see just why you are in kgdb.



-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

