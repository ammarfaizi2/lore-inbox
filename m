Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266235AbUBDAUo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266247AbUBDAUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:20:44 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:22495 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266235AbUBDATg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:19:36 -0500
Message-ID: <40203A93.8050600@cyberone.com.au>
Date: Wed, 04 Feb 2004 11:19:31 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
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

>Hi,
>
>I performed a series of measurements comparing scheduler latency of a 2.6.1 
>kernel with preemption enabled and disabled on an AMD Elan (i486 compatible) 
>with 133 Mhz clock frequency.
>
>The measurements were performed with a kernel module and a user mode process 
>that communicate via a character device interface. The user mode process uses 
>a blocking read() call to obtain data from the kernel. The kernel module 
>reads the system time every 10 ms by calling do_gettimeofday(), wakes up the 
>sleeping user mode process and passes the system time to it. After having 
>received the system time from the kernel, the user mode process reads the 
>system time by calling gettimeofday() and is thus able to determine the 
>scheduler latency by subtracting the two times. The user mode process is run 
>with the SCHED_FIFO scheduling policy.
>
>Measurements were carried out on a „loaded“ and an „unloaded“ system. The 
>„load“ was created by a process that continuously writes data to the serial 
>interface /dev/ttyS0.
>
>The results are:
>"loaded" system, 10.000 samples
>average scheduler latency (preemption enabled / disabled): 170 us / 232 us
>minimum scheduler latency (preemption enabled / disabled): 49 us / 43 us
>maximum scheduler latency (preemption enabled / disabled): 840 us / 1063 us
>
>"unloaded" system, 10.000 samples
>average scheduler latency (preemption enabled / disabled): 50 us / 44 us
>minimum scheduler latency (preemption enabled / disabled): 46 us / 41 us
>maximum scheduler latency (preemption enabled / disabled): 233 us / 215 us
>
>Any help in interpreting the data would be highly appreciated. Especially:
>- Why does preemption lead to a higher minimum scheduler latency in the loaded 
>case?
>- Why does preemption worsen scheduler latency on the unloaded system?
>
>

Because it adds a small amount of overhead. What you are paying for
is the improvement in worst case latencies. Looks like it is exactly
what you would expect.

