Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278332AbRJMQl5>; Sat, 13 Oct 2001 12:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278328AbRJMQlr>; Sat, 13 Oct 2001 12:41:47 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:8205 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S278334AbRJMQlf>;
	Sat, 13 Oct 2001 12:41:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
To: Robert Love <rml@tech9.net>
Subject: Re: cpus_allowed
Date: Sat, 13 Oct 2001 17:37:33 -0700
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01101316594000.02369@home01> <1002990137.868.59.camel@phantasy>
In-Reply-To: <1002990137.868.59.camel@phantasy>
MIME-Version: 1.0
Message-Id: <01101317373300.02554@home01>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 October 2001 09:22, Robert Love wrote:
> On Sat, 2001-10-13 at 19:59, Rolf Fokkens wrote:
> > I'm sure I'm overlooking something, but that doesn't help me finding the
> > answer. So would someone be so kind to enlighten me?
>
> It is initialized to -1 (0xffffffff) by struct definition at
> linux/kernel/sched.h.  Since it is a mask, this means all CPUs
> (obviously).

Silly me, I didn't check the header files.

> Most of the CPU affinity patches you see were written before
> cpus_allowed.  They go through all sorts of trouble to do what the OS
> now does on its own.  If you want to change CPU affinity then you just
> need a patch that adds a syscall or proc interface for setting the
> cpus_allowed mask.

Just read the "Linux Scalability Effort" (LSE) on Sourceforge. The concept of 
limitiming applications to certain resources is appealing to me. With the use 
of cpus_allowed it's not to hard to restrict CPU power for some applications. 
I'm thinking of the following: we're running about 12 (!) Oracle databases on 
1 Linux Server with 4 CPU's. One of the databases is a datawarehouse database 
which handles all kinds of heavy queries. Assuming that the machine has 
enough memory (which is the case) restricting this database to certain CPU's 
could be very useful.

I have no idea however what the right API would be. LSE suggests a ulimit 
like setting. In this Oracle example one listener handles connections to all 
databases on the machine, it does so by forking and executing the database 
binary with some specific environment settings per database. So ulimit won't 
handle it. The solution might be to run 2 listeners, one with 
restricted cpus_allowed and the other one with unrestricted cpus_allowed.
