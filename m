Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132130AbRC1AaE>; Tue, 27 Mar 2001 19:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132146AbRC1A3z>; Tue, 27 Mar 2001 19:29:55 -0500
Received: from mpdr0.milwaukee.wi.ameritech.net ([206.141.239.126]:30948 "EHLO mailhost.mil.ameritech.net") by vger.kernel.org with ESMTP id <S132130AbRC1A3l>; Tue, 27 Mar 2001 19:29:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: james <jdickens@ameritech.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Ideas for the oom problem
Date: Tue, 27 Mar 2001 18:53:18 -0600
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0103271815370.26154-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33.0103271815370.26154-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Message-Id: <01032718343500.32154@friz.themagicbus.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Kernel Guru's

Here are my ideas on how too deal with the oom situation, most of these 
should be thought of stuff to do in 2.5.x kernels, because it touches a lot 
of kernel path ways,  with possible back porting 
once it is tested. 

I propose a three prong approach too this problem

Prong 1: WHAT TOO KILL 

a. don't kill any task with a uid < 100 
    
b. if uid between 100 to 500 or CAP-SYS equivalent enabled 
	set it too a lower priority, so if it is at fault it will happen slower 		   
            giving more time before the system collapses

c.  if a task is nice'd then immediately put the task too sleep, and schedule 
all code / data too be swapped out, or thrown away as appropiate. do not 
reschedule the task too continue until memory is available 

d. kill any normal user interactive tasks that is started during a memory 
crisis. 

Prong 2 WHAT TOO DO ABOUT STABILIZING THE SYSTEM 

allocate a pool of memory at system start up that is too be released to the 
memory pool when the system is in a memory crisis. This will reduce system 
swapping, and allow the system too stablize slightly

report any task asking for large pool of memory while the system is in 
oom crisis. if uid > 500 and was started from an interactive shell it should 
be killed. 

when the crisis is ended, re-adquire the memory pool for later usage. 

Prong 3 providing  information about oom crisis too user land 

create /proc/vm/oom_crisis this would be readonly file owned by root it would 
report if the system is in crisis and the uid of any process that is asking 
for large amounts of ram while the system 
is in crisis. 

create a SIGDANGER handler that is sent out too all tasks that have 
registered a handler when the kernel enters oom_kill, give these tasks a high 
priority access too system resources. 

this would enable user land programs too deal with the situation with out 
continuous polling free ram/swap. They could email/page sysadmin and user 
about the crisis and add additional swap resources and kill any know  non 
essential tasks. and probe system for possible broken tasks, such as 
netscape-common tasks not connected too netscape client, at least i have been 
known too find these when netscape crashes. 



Okay that is my idea, i am putting on my flame proof suit and getting ready 
for the flames that are sure too come my way.....



James 
kernelnewbie in training 
