Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131018AbRCFQ6l>; Tue, 6 Mar 2001 11:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131019AbRCFQ6c>; Tue, 6 Mar 2001 11:58:32 -0500
Received: from [63.95.87.168] ([63.95.87.168]:36880 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S131018AbRCFQ6Y>;
	Tue, 6 Mar 2001 11:58:24 -0500
Date: Tue, 6 Mar 2001 11:58:23 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Jorge David Ortiz Fuentes <jorge_ortiz@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Process vs. Threads
Message-ID: <20010306115822.A2244@xi.linuxpower.cx>
In-Reply-To: <20010306172843.D1283@hpspss3g.spain.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010306172843.D1283@hpspss3g.spain.hp.com>; from jorge_ortiz@hp.com on Tue, Mar 06, 2001 at 05:28:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2001 at 05:28:43PM +0100, Jorge David Ortiz Fuentes wrote:
[snip]
> "task" that can be run.  Using this structure makes easier to identify
> which threads belong to the same process and tools such as ps or top
> show the TID as a field.
> 
>   I understand that changing this in the Linux kernel would mean that:
> * some tools will have to be modified.
> * the proc filesystem should create a directory using the TID instead
> of the PID.
> * some features as VM handling, signaling or exec()ing from a thread
> would be more difficult to implement.
> * compatibility will be broken.
> 
>   However, I miss some way to indicate that two processes are, in
> fact, threads of the same process.  Maybe there is something I'm
> missing.  Let me elaborate this.
[snip]
>   This information is missleading since there is no way to know that
> these 9 threads are sharing memory. If you run 'ps axl' you can see
> the hierarchy as if it was a multiprocess program, i.e. no difference
> to show you that they are threads.  Not even reading
> /proc/<pid>/status you get info about these being threads.
[snip]

There are no threads in Linux.
All tasks are processes. 
Processes can share any or none of a vast set of resources.

When processes share a certain set of resources, they have the same
characteristics as threads under other OSes (except the huge performance
improvements, Linux processes are already as fast as threads on other OSes).

Execution contexts which share resources do not have to share memory. If we
implemented top to aggregate such processes (as you suggest), the result
would also be potentially misleading. 

If we were to break compatibility it should be actually fix the situation,
not replace once misleading situation with another.

Sometimes it is handy to view a collection of execution contexts as a
singular object. However, such is also the case with a service implemented
as a collection of share-none standard unix processes (like postfix). A
better solution would be a more generalized system for service object
management. Such a solution could likely be implemented without kernel
intervention (though perhaps a general facility to determine what shares what
with who might be needed).  
