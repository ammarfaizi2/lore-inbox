Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUIFXN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUIFXN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 19:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUIFXNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 19:13:25 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:53169 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267464AbUIFXNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 19:13:10 -0400
Message-ID: <413CEEF6.6080501@yahoo.com.au>
Date: Tue, 07 Sep 2004 09:12:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: don fisher <dfisher@as.arizona.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: sched_setaffinity(), RT priorities and migration thread usage
 at 30%
References: <413CE863.3050400@as.arizona.edu>
In-Reply-To: <413CE863.3050400@as.arizona.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

don fisher wrote:
> Hello,
> 
> Apologies in advance if this is a newbie question. I am attempting to 
> write a real-time simulation of an application we have in house. I have 
> a dual processor SMP system, hyperthreading enabled, running kernel 2.6.7.
> 
> The first thread begins at priority 1 (SCHED_RR) and subsequently spawns 
> another time critical task running at priority 2. The initial thread 
> uses setaffinity to set the desired cpu to 2. When the second task 
> begins, the migration thread becomes 30% active (as reported by top) for 
> the duration of its execution. When the priority 2 thread terminates the 
> first thread continues with the migration task consuming only 2% of the 
> CPU.
> 
> If there was any change, I was expecting that the higher priority of the 
> second thread would cause it to execute closer to 100% CPU. I built a 
> test code where each thread computes an identical dumb timing loop. The 
> priority 2 thread ends up executing 30% slower than the priority 1 
> thread due to contention with the migration thread.
> 
> Is this the expected behavior, and if so could you please inform me why? 
> I had not anticipated the any attempt by the kernel to shift the process 
> to another CPU, since sched_setafinity had been applied.
> 

OK I'll have to put something in that doesn't class the balancing
attempt as a failure if it encounters tasks that aren't allowed to
be moved.
