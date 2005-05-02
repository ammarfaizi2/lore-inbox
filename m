Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVEBKiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVEBKiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 06:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVEBKiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 06:38:17 -0400
Received: from pop.gmx.net ([213.165.64.20]:2752 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261195AbVEBKiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 06:38:11 -0400
X-Authenticated: #4399952
Date: Mon, 2 May 2005 12:37:45 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: "Arun Srinivas" <getarunsri@hotmail.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: scheduler/SCHED_FIFO behaviour
Message-ID: <20050502123745.5db55752@mango.fruits.de>
In-Reply-To: <BAY10-F2709F2A16EEE74732F797FD9270@phx.gbl>
References: <1114962685.5081.5.camel@localhost.localdomain>
	<BAY10-F2709F2A16EEE74732F797FD9270@phx.gbl>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 May 2005 10:57:29 +0530
"Arun Srinivas" <getarunsri@hotmail.com> wrote:

> 1) From main(i.e., parent) create a shared memory seg. using shmget() and 
> shmat(). This is for communication between parent and child. I am trying to 
> use this as a locking mechanism to make them tightly coupled so that one 
> does not race before the other.
> 2) create child by fork() and call shmat() to attach this segment to child 
> too
> 3) In parent and child call ioctl() to pass their PID's from user space to 
> kernel space...so that I can measure when the particular PID's are scheduled 
> in the scheduler
> 
> I suppose shmget() dosent use a system call.So still confused about the 
> occasional resechedule behavior.

You might try the user triggered tracing which is available with Ingo's
realtime preemption patches.

Enable the latency tracing in the kernel confgig and 

echo 1 > /proc/sys/kernel/user_triggered_tracing

then in your code you want to be checked do this before the section:

gettimeofday (1, 1)

and

gettimeofday (1, 0)

after the section you want to be checked.. Every reschedule of the task
will result in a signal SIGUSR2 sent to your program and a latency trace
in the syslog..

..i think

Flo


-- 
Palimm Palimm!
http://affenbande.org/~tapas/
