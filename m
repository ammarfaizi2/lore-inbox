Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135226AbRDLQt7>; Thu, 12 Apr 2001 12:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135224AbRDLQtt>; Thu, 12 Apr 2001 12:49:49 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:37945 "EHLO
	macallan.engr.valinux.com") by vger.kernel.org with ESMTP
	id <S135225AbRDLQtc>; Thu, 12 Apr 2001 12:49:32 -0400
From: Walt Drummond <drummond@engr.valinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15061.56474.247739.99673@macallan.engr.valinux.com>
Date: Thu, 12 Apr 2001 09:49:30 -0700
To: george anzinger <george@mvista.com>
Cc: Hubertus Franke <frankeh@us.ibm.com>, mingo@elte.hu,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Bug in sys_sched_yield
In-Reply-To: <3AD5D311.5BFE39A6@mvista.com>
In-Reply-To: <OFC3243AAE.31877E4B-ON85256A2B.006AE9C3@pok.ibm.com>
	<3AD5D311.5BFE39A6@mvista.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Reply-To: drummond@engr.valinux.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger writes:
> Uh...  I do know about this map, but I wonder if it is at all needed. 
> What is the real difference between a logical cpu and the physical one. 
> Or is this only interesting if the machine is not Smp, i.e. all the cpus
> are not the same?  It just seems to me that introducing an additional
> mapping just slows things down and, if all the cpus are the same, does
> not really do anything.  Of course, I am assuming that ALL usage would
> be to the logical :)

Right.  That is not always the case.  IA32 is somewhat special. ;) The
logical mapping allows you to, among other things, easily enumerate
over the set of active processors without having to check if a
processor exists at the current processor address.

The difference is apparent when the physical CPU ID is, say, an
address on a processor bus, or worse, an address on a set of processor
busses.  Take a look at the IA-64's smp.h.  The IA64 physical
processor ID is a 64-bit structure that has to 8-bit ID's; an EID for
what amounts to a "processor bus" ID and an ID that corresponds to a
specific processor on a processor bus.  Together, they're a system
global ID for a specific processor.  But there is no guarantee that
the set of global ID's will be contiguous.

It's possible to have disjoint (non-contiguous) physical processor
ID's if a processor bus is not completely populated, or there is an
empty processor slot or odd processor numbering in firmware, or
whatever.

--Walt

