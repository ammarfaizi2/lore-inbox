Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264581AbSIQU3s>; Tue, 17 Sep 2002 16:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264596AbSIQU3s>; Tue, 17 Sep 2002 16:29:48 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:28091 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264581AbSIQU3p>; Tue, 17 Sep 2002 16:29:45 -0400
Subject: Re: Fwd: do_gettimeofday vs. rdtsc in the scheduler
From: john stultz <johnstul@us.ibm.com>
To: anton wilson <anton.wilson@camotion.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200209172020.g8HKKPF13227@eng2.beaverton.ibm.com>
References: <200209172020.g8HKKPF13227@eng2.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 13:29:18 -0700
Message-Id: <1032294559.22815.180.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I'm writing a patch for the scheduler that allows normal processes to run 
>  occasionally even though real-time processes completely dominate the CPU. 
> In 
>  order to do this the way I want to for a specific real-time application, I 
>  need to keep track of the times that the schedule(void) function gets 
> called. 
>  This time is then used to calculate the time difference between when a 
> normal 
>  process was run last and the current time. I was trying to avoid 
>  do_gettimeofday because of the overhead, but now I'm wondering if rdtsc on 
> an 
>  SMP machine may mess up my readings because the TSC from two different 
>  processors may be read. Am I right in assuming this? Secondly, any good 
>  suggestions on how to proceed with my patch? 

Tread with caution. Some NUMA boxes do not have synced TSC, so on those
systems your code won't work. Additionally, you code would need to take
other technologies like speedstep into account as well  Alternatively,
you might want to try using get_cycles, or some other semi-abstracted
interface, so alternative time sources could be used in the future
without having to re-write your code. I'm working on somewhat
abstracting out time sources with my timer-changes patch, so take a peek
at it and let me know if you have any suggestions. 

thanks
-john


