Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUBRD7p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUBRD7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:59:45 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:21205
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S262153AbUBRD7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:59:43 -0500
Message-ID: <4032DEEA.1060007@tmr.com>
Date: Tue, 17 Feb 2004 22:41:30 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Stueckjuergen <christoph.stueckjuergen@siemens.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 Scheduler Latency Measurements (Preemption diabled/enabled)
References: <200402031724.17994.christoph.stueckjuergen@siemens.com>
In-Reply-To: <200402031724.17994.christoph.stueckjuergen@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Stueckjuergen wrote:
> Hi,
> 
> I performed a series of measurements comparing scheduler latency of a 2.6.1 
> kernel with preemption enabled and disabled on an AMD Elan (i486 compatible) 
> with 133 Mhz clock frequency.
> 
> The measurements were performed with a kernel module and a user mode process 
> that communicate via a character device interface. The user mode process uses 
> a blocking read() call to obtain data from the kernel. The kernel module 
> reads the system time every 10 ms by calling do_gettimeofday(), wakes up the 
> sleeping user mode process and passes the system time to it. After having 
> received the system time from the kernel, the user mode process reads the 
> system time by calling gettimeofday() and is thus able to determine the 
> scheduler latency by subtracting the two times. The user mode process is run 
> with the SCHED_FIFO scheduling policy.
> 
> Measurements were carried out on a „loaded“ and an „unloaded“ system. The 
> „load“ was created by a process that continuously writes data to the serial 
> interface /dev/ttyS0.
> 
> The results are:
> "loaded" system, 10.000 samples
> average scheduler latency (preemption enabled / disabled): 170 us / 232 us
> minimum scheduler latency (preemption enabled / disabled): 49 us / 43 us
> maximum scheduler latency (preemption enabled / disabled): 840 us / 1063 us
> 
> "unloaded" system, 10.000 samples
> average scheduler latency (preemption enabled / disabled): 50 us / 44 us
> minimum scheduler latency (preemption enabled / disabled): 46 us / 41 us
> maximum scheduler latency (preemption enabled / disabled): 233 us / 215 us
> 
> Any help in interpreting the data would be highly appreciated. Especially:
> - Why does preemption lead to a higher minimum scheduler latency in the loaded 
> case?
> - Why does preemption worsen scheduler latency on the unloaded system?
> 
> Best regards,
> Christoph
> 
> PS: I am not subscribed, please CC me if you answer!

Have you considered repeating your test on 2.6.3-rc3-mm1 or similar with 
all of the most recent thinking on scheduling?

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
