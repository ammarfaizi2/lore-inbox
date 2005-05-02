Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVEBF1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVEBF1q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 01:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVEBF1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 01:27:46 -0400
Received: from bay10-f27.bay10.hotmail.com ([64.4.37.27]:27901 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261662AbVEBF1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 01:27:31 -0400
Message-ID: <BAY10-F2709F2A16EEE74732F797FD9270@phx.gbl>
X-Originating-IP: [68.62.196.46]
X-Originating-Email: [getarunsri@hotmail.com]
In-Reply-To: <1114962685.5081.5.camel@localhost.localdomain>
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler/SCHED_FIFO behaviour
Date: Mon, 02 May 2005 10:57:29 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 02 May 2005 05:27:29.0413 (UTC) FILETIME=[A214BB50:01C54ED7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2 processes which I  am measuring  are parent and child processes.I want 
both of'em to be scheduled at the same time.My code simply does the 
following:

1) From main(i.e., parent) create a shared memory seg. using shmget() and 
shmat(). This is for communication between parent and child. I am trying to 
use this as a locking mechanism to make them tightly coupled so that one 
does not race before the other.
2) create child by fork() and call shmat() to attach this segment to child 
too
3) In parent and child call ioctl() to pass their PID's from user space to 
kernel space...so that I can measure when the particular PID's are scheduled 
in the scheduler

I suppose shmget() dosent use a system call.So still confused about the 
occasional resechedule behavior.



>From: Steven Rostedt <rostedt@goodmis.org>
>To: Arun Srinivas <getarunsri@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: scheduler/SCHED_FIFO behaviour
>Date: Sun, 01 May 2005 11:51:25 -0400
>
>On Sun, 2005-05-01 at 07:36 +0530, Arun Srinivas wrote:
> > hi
> >
> >   I spkoe to you some days ago regarding scheduling two processes 
>together
> > on a HT.As I told you before I run them as SCHED_FIFO processes.I 
>understood
> > the theory you told me in your previous reply as to why both of 
>SCHED_FIFO
> > processes get scheduled only once and then run till completion.
> >
> > But, sometimes a see a occasional reschedulei.e., the 2 processes get
> > scheduled one more time after they are scheduled for the 1st time. I ran 
>my
> > code 100 times and observed this behavior 8 out of  100 times. What 
>could be
> > the reason?
> > (As I said i want my 2 processes to run together without any reschedule
> > after they are scheduled for the first time).
>
>  The only way a real time priority process of SCHED_FIFO gets
>rescheduled, is if the process voluntarily calls schedule (you call a
>system call that calls schedule), or a higher priority process gets
>scheduled.  I don't know what your program is doing, or what priorities
>that they are running with to know if something like this has occurred.
>
>Also, if the programs you are running haven't been locked into memory
>(they exist partially on the hard drive still), then it will take time
>to map the code into memory when that code is called, and a schedule
>will occur then as well.
>
>-- Steve
>
>

_________________________________________________________________
Thinking of Marriage. 
http://www.bharatmatrimony.com/cgi-bin/bmclicks1.cgi?74 Think 
BharatMatrimony.com

