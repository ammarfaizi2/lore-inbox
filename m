Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264348AbRFGHZn>; Thu, 7 Jun 2001 03:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264349AbRFGHZd>; Thu, 7 Jun 2001 03:25:33 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:43271 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264348AbRFGHZZ>; Thu, 7 Jun 2001 03:25:25 -0400
Message-ID: <3B1F2BFE.28E7CCF0@idb.hist.no>
Date: Thu, 07 Jun 2001 09:23:42 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Derek Glidden <dglidden@illusionary.com>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com> <Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com> <3B1D927E.1B2EBE76@uow.edu.au> <20010605231908.A10520@illusionary.com> <3B1DEAC7.43DEFA1C@idb.hist.no> <3B1E437C.D5D339EB@illusionary.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Glidden wrote:
> 
> Helge Hafting wrote:
> >
> > The drive is inactive because it isn't needed, the machine is
> > running loops on data in memory.  And it is unresponsive because
> > nothing else is scheduled, maybe "swapoff" is easier to implement
> 
> I don't quite get what you're saying.  If the system becomes
> unresponsive because  the VM swap recovery parts of the kernel are
> interfering with the kernel scheduler then that's also bad because there
> absolutely *are* other processes that should be getting time, like the
> console windows/shells at which I'm logged in.  If they aren't getting
> it specifically because the VM is preventing them from receiving
> execution time, then that's another bug.
> 
Sure.  The kernel doing a big job without scheduling anything 
is a problem.

> I'm not familiar enough with the swapping bits of the kernel code, so I
> could be totally wrong, but turning off a swap file/partition should
> just call the same parts of the VM subsystem that would normally try to
> recover swap space under memory pressure.  

A problem with this is that normal paging-in is allowed to page other
things out as well.  But you can't have that when swap is about to
be turned off.  My guess is that swapoff functionality was perceived to
be so seldom used that they didn't bother too much with scheduling 
or efficiency.

I don't have the same problem myself though.  Shutting down with
30M or so in swap never take unusual time on 2.4.x kernels here,
with a 300MHz processor.  I did a test while typing this letter,
almost filling the 96M swap partition with 88M.  swapoff
took 1 minute at 100% cpu.  This is long, but the machine was responsive
most of that time.  I.e. no worse than during a kernel compile.
The machine froze 10 seconds or so at the end of the minute, I can
imagine that biting with bigger swap.

Helge Hafting
