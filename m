Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317537AbSFRSTk>; Tue, 18 Jun 2002 14:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317538AbSFRSTj>; Tue, 18 Jun 2002 14:19:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10881 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317537AbSFRSTg>; Tue, 18 Jun 2002 14:19:36 -0400
Date: Tue, 18 Jun 2002 14:21:52 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: mgix@mgix.com
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       David Schwartz <davids@webmaster.com>, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: RE: Question about sched_yield()
In-Reply-To: <AMEKICHCJFIFEDIBLGOBEEEHCBAA.mgix@mgix.com>
Message-ID: <Pine.LNX.3.95.1020618140651.8171A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002 mgix@mgix.com wrote:

> 
> > It's all in the accounting. Use usleep(0) if you want it to "look good".
> 
> 
> Two things:
> 
> 	1. First, I think there's a misunderstanding on what my
>          original issue was: I am not interested in any way by
>          CPU cycle accounting, and wether the yielding loop should
>          log any of it. All I want is: when I run a bunch of
>          yielders and a actual working process, I want the
>          working process to not be slown down (wall clock) in
>          anyway. That's all. What top shows is of little interest
>          (to me). What matters is how many real world seconds it takes
>          for the actually working process to complete its task.
>          And that should not be affected by the presence of running
>          yielders. And, David, no one is arguing the fact that a yielder
>          running all by itself should log 100% of the CPU.
> 

Well the problem seems to be an inconsistancy I reported to 'the list'
some time ago. As I recall, Ingo replied that I should use usleep(0) and
the problem I reported would "go away". It did go away. However, if
you run this on a single-processor machine, 'top' will show that
each task gets 99+ percent of the CPU, which of course can't be correct.


#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main(int c, char *argv[])
{
    if(!fork())
    {
        strcpy(argv[0], "Child");
        for(;;)
            ;
    } 
    strcpy(argv[0], "Parent");

    for(;;)
        sched_yield();

   return c;
}


So, it seems that the guy that's yielding the CPU gets 'charged' for
the CPU time he gave away. Fair enough, I guess. As I see it,
sched_yield() will give the CPU to any single computible task once.
After this, the caller gets the CPU back whether or not he wants it.


> 	2. I have a question about usleep(0). You seem to make the point
>          that usleep(0) is equivalent to sched_yield(). I can see how
>          intuitively this should be the case, but I am not sure if it
>          will always be true. It's certainly documented anywhere.
> 

No. I did not mention or imply "equivalent", only that you can use it
instead, in many, perhaps most, instances.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

