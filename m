Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbTFQUkE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTFQUjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:39:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26873 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264937AbTFQUjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:39:24 -0400
Message-ID: <3EEF7FA6.4010903@mvista.com>
Date: Tue, 17 Jun 2003 13:52:54 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Whitener <dwhitener@defeet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [sparc64] wrong uptime in 2.5.72
References: <3EEF36D9.40605@defeet.com>
In-Reply-To: <3EEF36D9.40605@defeet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Whitener wrote:
> 
> I'm getting a bad uptime with 2.5.72... It comes up with 497 as soon as 
> you boot (I've rebooted multiple times).  The problem wasn't there in 
> 2.5.70. This machine is a Sun Ultra 5.
> 
> I found this mail in the archives that might help some...
> http://www.ussg.iu.edu/hypermail/linux/kernel/0306.1/1698.html

The system now uses the posix clock_monotonic clock to compute uptime. 
  This clock requires that the arch code (do_settime) keep track of 
time settings and back them out of "wall_to_monotonic".

There was also a recent change to set wall_to_monotonic to -(xtime) so 
that this clock would be 0 at boot time.  This is usually done in the 
arch/kernel/time.c code where xtime (i.e. the system time) is set 
during boot up.  Prior code set it to the initial jiffies value.  I 
suspect that this change did not get into your kernel.

-g
> 
> sun root # uname -a
> Linux sun.nowhere.net 2.5.72 #1 Tue Jun 17 10:25:45 EST 2003 sparc64 
> sun4u TI UltraSparc IIi GNU/Linux
> sun root # uptime
>  10:46:35 up 497 days,  2:24,  1 user,  load average: 0.28, 0.17, 0.07
> sun root # cat /proc/uptime
> 42949481.55 77.26
> sun root # cat /proc/stat
> cpu  1382 0 1783 7626 466
> cpu0 1382 0 1783 7626 466
> intr 12650 11256 0 0 0 928 459 0 0 0 0 0 0 7 0 0 0
> ctxt 14048
> btime 1055864690
> processes 4217
> procs_running 2
> procs_blocked 0
> sun root # cat /proc/cpuinfo
> cpu             : TI UltraSparc IIi
> fpu             : UltraSparc IIi integrated FPU
> promlib         : Version 3 Revision 25
> prom            : 3.25.1
> type            : sun4u
> ncpus probed    : 1
> ncpus active    : 1
> Cpu0Bogo        : 719.25
> Cpu0ClkTck      : 0000000015752a00
> MMU Type        : Spitfire
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

