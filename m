Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbRGIV3t>; Mon, 9 Jul 2001 17:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264964AbRGIV3k>; Mon, 9 Jul 2001 17:29:40 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:45455 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S264963AbRGIV3f>; Mon, 9 Jul 2001 17:29:35 -0400
Date: Mon, 9 Jul 2001 16:29:35 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200107092129.QAA13628@tomcat.admin.navo.hpc.mil>
To: larry@spack.org, <linux-kernel@vger.kernel.org>
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> 
> Where I just started work we run large processes for simulations and
> testing of semi-conductors.  Currently we use Solaris because of past
> limitations on the amount of RAM that a single process can address under
> Linux.  Recently we tried to run some tests on a Dell dual Xeon 1.7GHz
> with 4GB of RAM running Redhat 7.1 box (with the stock Redhat SMP kernel).
> Speedwise it kicked the crap out of our Sunblade (Dual 750MHz with 8GB of
> RAM)but we had problems with process dying right around 2.3GB (according
> to top).
> 
> So I started to investigate, and quickly discovered that there is no good
> source for finding this sort of information on line.  At least not that I
> could find.  Nearly every piece of information I found conflicted in at
> least some small way with another piece of information I found.
> So I ask here in the hopes of a definitive answer.
> 
>  * What is the maximum amount of RAM that a *single* process can address
>    under a 2.4 kernel, with PAE enabled?  Without?

3GB tops. PAE only allows more processes. A single process cannot under
any circumstances reach more than 4G, but due to other limits 3 is the max.

>  * And, what (if any) paramaters can effect this (recompiling the app
>    etc)?

You need a 64 bit CPU.

> What I think I know so far is listed below.  I welcome being flamed, told
> that I'm stupid and that I should have looked "here" so long as said
> messages also contain pointers to definitive information :-)
> 
> Linux 2.4 does support greater then 4GB of RAM with these caveats ...
> 
>  * It does this by supporting Intel's PAE (Physical Address Extension)
>    features which are in all Pentium Pro and newer CPU's.
>  * The PAE extensions allow up to a maximum of 64GB of RAM that the OS
>    (not a process) can address.
>  * It does this via indirect pointers to the higher memory locations, so
>    there is a CPU and RAM hit for using this.
>  * Benchmarks seem to indicated around 3-6% CPU hit just for using the PAE
>    extensions (ie. it applies regardless of whether you are actually
>    accessing memory locations greater then 4GB).
>  * If the kernel is compiled to use PAE, Linux will not boot on a computer
>    whose hardware doesn't support PAE.
>  * PAE does not increase Linux's ability for *single* processes to see
>    greater then 3GB of RAM (see below).
> 
> So what are the limits without using PAE? Here I'm still having a little
> problem finding definitive answers but ...

3 GB. Final answers are in the FAQ, and have been discussed before. You can
also look in the Intel 80x86 CPU specifications.

The only way to exceed current limits is via some form of segment register usage
which will require a different compiler and a replacement of the memory
architecture of x86 Linux implementation.

> 
>  * With PAE compiled into the kernel the OS can address a maximum of 4GB
>    of RAM.
>  * With 2.4 kernels (with a large memory configuration) a single process
>    can address up to the total amount of RAM in the machine minus 1GB
>    (reserved for the kernel), to a maximum 3GB.
>  * By default the kernel reserves 1GB for it's own use, however I think
>    that this is a tunable parameter so if we have 4GB of RAM in a box we
>    can tune it so that most of that should be available to the processes
>    (?).
> 
> I have documented the below information on my web site, and will post
> whatever answers I recieve there:
> 
> 	http://www.spack.org/index.cgi/LinuxRamLimits

And it isn't really a Linux limit. It is the hardware. If you need more
virtual space, get a 64 bit processor.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
