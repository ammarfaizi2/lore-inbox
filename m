Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265299AbUAFDXm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 22:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbUAFDXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 22:23:42 -0500
Received: from brain.sedal.usyd.edu.au ([129.78.24.68]:61847 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S265299AbUAFDXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 22:23:40 -0500
Message-ID: <3FF980C7.3060301@sedal.usyd.edu.au>
Date: Tue, 06 Jan 2004 02:20:39 +1100
From: sena <auntvini@sedal.usyd.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: uids in task_struct-Further Explaining the Problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thank you very much for the previous advice and for your valuable time.

I thought of further explaining the problem to you.


At this stage linux kernel is calculating Load Averages. The major input 
of the calculation is number of running exe and  Runnables in the 
runnable Queue.

This is happening In timer.c
static unsigned long count_active_tasks(void) and

static inline void calc_load(unsigned long ticks)

What I am Trying:

What I am tryiing to do is to seperate the running exe and  Runnables 
according to the owner of those processes (Say 5 people have login and 
they run diffrent processes)

And then seperately calculate the Load Averages for those respective 
login users.


The Problems:

The task_struct has a uid field. I have used that field to seperate 
them. But the problem is when a child process is created by its parent 
then the child inherits  the uid of the parents. As a result the correct 
uid which is related to the username does not contain in that uid.

Example:

Say a computer has 5 user logins name1(500), name2(501), 
name3(502).........name5(504) apart from root. If these 5 people 
remotely login and runs there jobs, then the user name of those jobs are 
name1,name2 and name3.

Say if they use telnet to remotely login then those Tasks will be 
started under telnet server as children.

As the children inherits uid, euid etc of the parents. That means telnet 
is run as root and it inherits uid<500.

task_struct has uid and it is updated accordingly.


I have built the kernel 2.4.19sena1 successfully but this is my problem. 
The problem because child process inherits uid etc if I start any 
process through telnet


Thanks
Sena Seneviratne
Computer Engineering Lab
Sydney University

