Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317829AbSGVUxA>; Mon, 22 Jul 2002 16:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317830AbSGVUxA>; Mon, 22 Jul 2002 16:53:00 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:54658 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317829AbSGVUw7>; Mon, 22 Jul 2002 16:52:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: Gang Scheduling in linux
Date: Mon, 22 Jul 2002 15:52:45 -0400
User-Agent: KMail/1.4.1
Cc: Ingo Molnar <mingo@elte.hu>, shreenivasa H V <shreenihv@usa.net>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207201858180.17247-100000@localhost.localdomain> <200207191525.40633.frankeh@watson.ibm.com> <200207192205.g6JM5TR12776@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200207192205.g6JM5TR12776@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207221552.45522.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 July 2002 06:05 pm, Richard Gooch wrote:
> Hubertus Franke writes:
> > On a single SMP I could imagine for instance for parallel reendering
> > or similar tightly integrated parallel programs that need data
> > synchronization.  Most of these apps assume a tightly coupled
> > non-virtual resource, i.e., scheduling of tasks is aligned.
> >
> > SGI used to have that stuff in their base kernel. Read a paper about
> > this some years ago.  Again, at the beginning I'd go with a user
> > level scheduler approach that certainly would satisfy national labs
> > etc. Most of the cluster schedulers, like PBS and LoadLeveler etc.,
> > already provide that functionality.
>
> A completely user-level solution may have some disadvantages, though,
> such as delays in scheduling on/off (say if some daemon is used to
> scan the process list). Perhaps we could add a small hack to the
> scheduler such that when a task is about to be scheduled off, a signal
> can be sent to a designated pid? Similarly, when a task is scheduled
> on, another signal may be sent. An application that wanted to have
> gang scheduling could then make use of this to STOP/CONT threads.
>
> 				Regards,
>
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca

I am glad you brought this up. I'd love to have a generic callback for this.
AIX used/has a process change handler that is being called on start/exit.

In Linux, this idea could be done through a generic hook settable through a 
module... that should be sufficient and would allow for other stuff to 
be handled as well. For instance in the presence of fast user level
communication (e.g. user mapped windows to myrinet the current
process could be marked in the communication adapter).

Just thinking loud.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
