Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbUAFTga (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 14:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264963AbUAFTga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 14:36:30 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:53215 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S264943AbUAFTg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 14:36:27 -0500
Date: Tue, 6 Jan 2004 13:35:17 -0600
From: Robin Holt <holt@sgi.com>
To: sena <auntvini@sedal.usyd.edu.au>
Cc: Robin Holt <holt@sgi.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uids in task_struct-Further Explaining the Problem
Message-ID: <20040106193517.GA15766@lnx-holt>
References: <3FF980C7.3060301@sedal.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF980C7.3060301@sedal.usyd.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 02:20:39AM +1100, sena wrote:
Again, you have described what the problem is with your code and not
the problem you are trying to solve.

There are a couple solutions to the "Who has used what resource?"
question.  The most prominent in my mind is a system accounting.
This could be used to say which user consumed how much cpu/IO, etc.
If that is the sort of information your are looking for (after the
fact summary), then I would look to that direction.

If, on the other hand, you are trying to see which users are consuming
cpu resources, you might want to look at some of the top sorting
information.

I personally don't see the benefit to calculating a per-user load
average, but maybe there is.

As to euid and uid.  If ps -ef or ps -ale shows the correct uids, you
should have no problem calculating on a per-user basis.  I would
happily look at your source and try to give you pointers if that is
what you ask for.  I won't be able to touch anything until tonight
at the earliest.

Thanks,
Robin

> Hi Robin,
> 
> Thank you very much for the previous advice and for your valuable time.
> 
> I thought of further explaining the problem to you.
> 
> 
> At this stage linux kernel is calculating Load Averages. The major input 
> of the calculation is number of running exe and  Runnables in the 
> runnable Queue.
> 
> This is happening In timer.c
> static unsigned long count_active_tasks(void) and
> 
> static inline void calc_load(unsigned long ticks)
> 
> What I am Trying:
> 
> What I am tryiing to do is to seperate the running exe and  Runnables 
> according to the owner of those processes (Say 5 people have login and 
> they run diffrent processes)
> 
> And then seperately calculate the Load Averages for those respective 
> login users.
> 
> 
> The Problems:
> 
> The task_struct has a uid field. I have used that field to seperate 
> them. But the problem is when a child process is created by its parent 
> then the child inherits  the uid of the parents. As a result the correct 
> uid which is related to the username does not contain in that uid.
> 
> Example:
> 
> Say a computer has 5 user logins name1(500), name2(501), 
> name3(502).........name5(504) apart from root. If these 5 people 
> remotely login and runs there jobs, then the user name of those jobs are 
> name1,name2 and name3.
> 
> Say if they use telnet to remotely login then those Tasks will be 
> started under telnet server as children.
> 
> As the children inherits uid, euid etc of the parents. That means telnet 
> is run as root and it inherits uid<500.
> 
> task_struct has uid and it is updated accordingly.
> 
> 
> I have built the kernel 2.4.19sena1 successfully but this is my problem. 
> The problem because child process inherits uid etc if I start any 
> process through telnet
> 
> 
> Thanks
> Sena Seneviratne
> Computer Engineering Lab
> Sydney University
