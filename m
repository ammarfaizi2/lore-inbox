Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264958AbTFQUzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbTFQUzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:55:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27376 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264958AbTFQUzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:55:46 -0400
Message-ID: <3EEF837A.8010806@mvista.com>
Date: Tue, 17 Jun 2003 14:09:14 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 819] New: uptime wrong on x86-64 (fwd)
References: <38850000.1055882259@[10.10.2.4]>
In-Reply-To: <38850000.1055882259@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>            Summary: uptime wrong on x86-64
>     Kernel Version: 2.5.72
>             Status: NEW
>           Severity: normal
>              Owner: johnstul@us.ibm.com
>          Submitter: johnstul@us.ibm.com
> 
> 
> Distribution: SLES8  
> Hardware Environment: AMD64 Melody box  
> Software Environment: 2.5.72  
> Problem Description:   
>   
> uptime reports wrong value after booting  
>   
> Steps to reproduce:  
> jstultz@elm3b31:~/linux-2.5> uptime  
>   
> Actual result:  
>   1:19pm  up 12220 days, 20:19,  1 user,  load average: 0.00, 0.00, 0.00  
>   
> Expected result:  
>   1:19pm  up 15 min,  1 user,  load average: 0.00, 0.01, 0.02  
>   
> Additional info:  
> jstultz@elm3b31:~/linux-2.5> date +%s  
> 1055881186  
> jstultz@elm3b31:~/linux-2.5> cat /proc/stat | grep btime  
> btime 1055880294  
>   
> I've been unable to reproduce the problem on i386, however this has also been  
> reported against sparc64 by Daniel Whitener.    
>   
> I suspect it might have something to do w/ do_posix_clock_monotonic_gettime() on  
> these arches.

Yes, most likely not setting wall_to_monotonic to -xtime at boot (see 
i386/kernel/time.c last few lines).
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

