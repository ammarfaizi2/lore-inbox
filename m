Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273331AbRINHoR>; Fri, 14 Sep 2001 03:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273332AbRINHoG>; Fri, 14 Sep 2001 03:44:06 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54521 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S273331AbRINHn7>; Fri, 14 Sep 2001 03:43:59 -0400
Message-ID: <3BA1B542.A4BE2763@mvista.com>
Date: Fri, 14 Sep 2001 00:44:02 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: shreenivasa H V <shreenihv@usa.net>
CC: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [Re: scheduler policy]
In-Reply-To: <20010914044111.3882.qmail@nwcst281.netaddress.usa.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shreenivasa H V wrote:
> 
> thanks, and I have a related question. Consider we have only 2 processes with
> equal priority. Now one of them is switched out for an i/o operation. The
> second one gains the cpu and executes past its time quantum. Since the other
> process is not yet ready this process continues to enjoy the cpu. Now will
> this usage be accounted for a new time quantum for this second process or will
> it be unaccounted. According to what I understand, the second process will not
> start its new time quantum until the epoch has ended i.e., the first one also
> has finished its time quantum. So does this mean the epoch will never end
> until there is a process in the system who's time quantum is yet to be
> expired?
> 
Your question is a little confused so I will just say what happens.  The
epoch (as you call it) ends when all run able tasks in the run list have
zero quantum.  At this time the quanta of all tasks ON THE SYSTEM are
adjusted by keeping 1/2 of what they have and adding a new value that
depends on the NICE value of the task.  Thus the task waiting for I/O
will surly have a higher quantum than the running task and when it is
unblocked, will get the cpu at the first context switch opportunity (at
interrupt completion if the running task is in user land, at completion
of the system call if in the system).

(A task can be on the run list and not run able in and SMP system if it
is locked to another cpu.  Such a tasks quantum will not be examined to
determine the end of the epoch.)

George
