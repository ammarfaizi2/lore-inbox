Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVEXN7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVEXN7B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVEXN7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:59:01 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:48026 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261310AbVEXN65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:58:57 -0400
Date: Tue, 24 May 2005 15:58:22 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Karim Yaghmour <karim@opersys.com>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       sdietrich@mvista.com, Philippe Gerum <rpm@xenomai.org>
Subject: Re: RT patch acceptance
In-Reply-To: <42932C32.8040500@opersys.com>
Message-Id: <Pine.OSF.4.05.10505241532040.29908-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2005, Karim Yaghmour wrote:

> 
> Esben Nielsen wrote:
> > I find that a bad approach:
> > 1) You don't have RT in userspace.
> > 2) You can't use Linux drivers for standeard hardware when you want it to
> > be part of your deterministic RT application.
> 
> Please have a look at RTAI/fusion. For the record, RTAI has been providing
> hard-rt in standard Linux user-space for over 5 years now. With RTAI/Fusion
> this gets even better as there isn't even a special API ...
> 
The tests I have read (I can't remember the links, but it was on lwn.net)
states that the worst case latency is even worse than for a standeard 2.6
kernel! 

If you gonna make usefull deterministic real-time in userspace you got to
change stuff in kernel space and implement stuff like priority
inheritance, priority ceiling or similar.  It can only turn up to be an
ugly hack which will end up being as intruesive into the kernel as Ingo's
approach. If you don't do anything like that you can not use _any_ Linux
kernel resources from your RT processes even though you have reimplemented
the pthread library to know about the "super RT" priorities.

But I give you: You will gain better interrupt latencies because
interrupts are executed below the Linux proper. I.e. when the Linux
kernel runs with interrupt disabled, they are really enabled in the RTAI
subsystem.

My estimate is that RTAI is good when you have a very small subsystem you
need to run RT with very low latencies. Forinstance, controlling a fast
device with limiting hardware resources to buffer events. 
For large control systems I don't think it is the proper way to do it.
There it is much better to run the control tasks as normal Linux
user-space processes with RT-priority. I can see Ingo's kernel doing that,
I can't see RTAI doing it except for very special situations where you
don't make _any_ Linux system calls at all! You can't even use a
normal Linux network device or character device from your RT application!

> Here are a few links if you're interested:
> http://www.rtai.org/modules.php?name=Content&pa=showpage&pid=1
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111634653913840&w=2
> 
> Karim

Esben

