Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135236AbRDLReI>; Thu, 12 Apr 2001 13:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135238AbRDLRd5>; Thu, 12 Apr 2001 13:33:57 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:27470 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S135236AbRDLRdr>; Thu, 12 Apr 2001 13:33:47 -0400
Message-ID: <3AD5E676.CF1C1684@mvista.com>
Date: Thu, 12 Apr 2001 10:31:34 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: drummond@engr.valinux.com
CC: Hubertus Franke <frankeh@us.ibm.com>, mingo@elte.hu,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Bug in sys_sched_yield
In-Reply-To: <OFC3243AAE.31877E4B-ON85256A2B.006AE9C3@pok.ibm.com>
		<3AD5D311.5BFE39A6@mvista.com> <15061.56474.247739.99673@macallan.engr.valinux.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Walt Drummond wrote:
> 
> george anzinger writes:
> > Uh...  I do know about this map, but I wonder if it is at all needed.
> > What is the real difference between a logical cpu and the physical one.
> > Or is this only interesting if the machine is not Smp, i.e. all the cpus
> > are not the same?  It just seems to me that introducing an additional
> > mapping just slows things down and, if all the cpus are the same, does
> > not really do anything.  Of course, I am assuming that ALL usage would
> > be to the logical :)
> 
> Right.  That is not always the case.  IA32 is somewhat special. ;) The
> logical mapping allows you to, among other things, easily enumerate
> over the set of active processors without having to check if a
> processor exists at the current processor address.
> 
> The difference is apparent when the physical CPU ID is, say, an
> address on a processor bus, or worse, an address on a set of processor
> busses.  Take a look at the IA-64's smp.h.  The IA64 physical
> processor ID is a 64-bit structure that has to 8-bit ID's; an EID for
> what amounts to a "processor bus" ID and an ID that corresponds to a
> specific processor on a processor bus.  Together, they're a system
> global ID for a specific processor.  But there is no guarantee that
> the set of global ID's will be contiguous.
> 
> It's possible to have disjoint (non-contiguous) physical processor
> ID's if a processor bus is not completely populated, or there is an
> empty processor slot or odd processor numbering in firmware, or
> whatever.
> 
All that is cool.  Still, most places we don't really address the
processor, so the logical cpu number is all we need.  Places like
sched_yield, for example, should be using this, not the actual number,
which IMO should only be used when, for some reason, we NEED the hard
address of the cpu.  I don't think this ever has to leak out to the
common kernel code, or am i missing something here.

George
