Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262578AbTCUR5S>; Fri, 21 Mar 2003 12:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262595AbTCUR5S>; Fri, 21 Mar 2003 12:57:18 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:30851 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262578AbTCUR5Q>; Fri, 21 Mar 2003 12:57:16 -0500
Date: Fri, 21 Mar 2003 10:17:27 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: lse-tech@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: Minutes from March 21 LSE Call
Message-ID: <58730000.1048270647@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


LSE Tech Call Minutes March 21, 2003

Minutes Compiled by Hanna Linder. Please send corrections or additions to 
lse-tech@lists.sourceforge.net


I. Matthew Fanto: The Cello Disk Scheduling Framework

If you have seen on the lkml the schedulers being worked on, like:
 cfq, deadline, and anticipatory io schedulers. Cello is another one. 
It is a two level disk scheduler. 

The two levels are a request is made and is put into a class specific 
queue. Currently there are three different applications classes:
	 real time, 
	 interactive best effort,
	 throughput intensive. 
Different algorithms and insertion methods work better for each type 
so it maintains different queues for each class type.

After assigning to queue it assigns weights. there is a 4th queue which 
is class unaware and it chooses which tasks to take based on weights 
and queue.

There are two ways to assign weights:
	 proportionate time allocation.
		doesnt take into account amount of data being transfered.
	 proportionate byte allocation. 
		takes into account the amount of data going to transfer. 
there are advantages to each method.

Most of the code is done. Bill Irwin saw the code last night.  No one 
else has yet. Hanna encouraged him to send it out anyway.

Matt said he has a paper he will put on line.  Jens Axboe read the 
paper a while ago and wanted to see it actually work.

Cliff offered to help Matt run it under the STP so they can help test 
it. Sometimes STP isnt happy so make sure to cc cliff white to get help 
getting it working.

Gerrit reiterated the importance of sending out the code.

Originally got the project from mjc (Michael Cohen) and found lots of 
performance increases based on his implementation in the user space. 
He asked Matt to work on it in the kernel.

Matt is going to send out a patch today to lse-tech.

II. Cliff White - Scheduling benchmarks

Has been redoing the AIM stuff. Should have an early alpha release next 
week. Should work with both aim7 and aim9. He is switching some of the 
static stuff to dynamic to make it easier to work with. He hopes to have 
something runnable next week.

What it does is take a list of microbenchmarks, decides on a num of tasks 
for each user, forks a certain number of children. each child runs a number 
of tasks in a random order. 

Currently looking at a problem where if 20-30 children forking seeing 3-4 
seconds delta between children starting and stopping even though they are 
all doing the same thing. The lifetime of the parent is about 50 seconds. 
There is a lot of contention between the children so it may or may not be 
a problem.  At the very least this looks like a good way to stress the scheduler.



