Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSGPKje>; Tue, 16 Jul 2002 06:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSGPKjd>; Tue, 16 Jul 2002 06:39:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26689 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313867AbSGPKjb>; Tue, 16 Jul 2002 06:39:31 -0400
To: Sandy Harris <pashley@storm.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch[ Simple Topology API
References: <p73ofdbv1a4.fsf@oldwotan.suse.de>
	<Pine.LNX.4.44.0207141156540.19060-100000@home.transmeta.com>
	<20020714214334.A16892@wotan.suse.de>
	<m1k7nxpvlg.fsf@frodo.biederman.org> <3D32E97A.AD808E43@storm.ca>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Jul 2002 04:30:59 -0600
In-Reply-To: <3D32E97A.AD808E43@storm.ca>
Message-ID: <m1sn2knevw.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sandy Harris <pashley@storm.ca> writes:

> "Eric W. Biederman" wrote:
> > 
> > Andi Kleen <ak@suse.de> writes:
> > >
> > > At least on Hammer the latency difference is small enough that
> > > caring about the overall bandwidth makes more sense.
> > 
> > I agree.  I will have to look closer but unless there is more
> > juice than I have seen in Hyper-Transport it is going to become
> > one of the architectural bottlenecks of the Hammer.
> > 
> > Currently you get 1600MB/s in a single direction.
> 
> That's on an 8-bit channel, as used on Clawhammer (AMD's lower cost
> CPU for desktop market). The spec allows 2, 4, 6, 16 or 32-bit
> channels. If I recall correctly, the AMD presentation at OLS said
> Sledgehammer (server market) uses 16-bit.

Thanks, my confusion.  The danger is of having more bandwidth to memory
than to other processors is still present, but it may be one of those
places where the cpu designers are able to stay one step ahead of
the problem.  I will definitely agree the problem goes away for the
short term with a 32bit link.

 
> > Not to bad.
> > But when the memory controllers get out to dual channel DDR-II 400,
> > the local bandwidth to that memory is 6400MB/s, and the bandwidth to
> > remote memory 1600MB/s, or 3200MB/s (if reads are as common as
> > writes).
> > 
> > So I suspect bandwidth intensive applications will really benefit
> > from local memory optimization on the Hammer.  I can buy that the
> > latency is negligible,
> 
> I'm not so sure. Clawhammer has two links, can do dual-CPU. One link
> to the other CPU, one for I/O. Latency may well be negligible there.
> 
> Sledgehammer has three links, can do no-glue 4-way with each CPU
> using two links to talk to others, one for I/O.
> 
>     I/O -- A ------ B -- I/O
>            |        |
>            |        |
>     I/O -- C ------ D -- I/O
> 
> They can also go to no-glue 8-way:
> 
>     I/O -- A ------ B ------ E ------ G -- I/O
>            |        |        |        |
>            |        |        |        |
>     I/O -- C ------ D ------ F ------ H -- I/O

> I suspect latency may become an issue when more than one link is
> involved and there can be contention.

I think the 8-way topology is a little more interesting than
presented.  But if not it does look like you can run into issues.
The more I look at it there appears to be a strong dynamic balance
in the architecture between having just enough bandwidth, and low
enough latency not to become a bottleneck, and having a low hardware
cost. 

> Beyond 8-way, you need glue logic (hypertransport switches?) and
> latency seems bound to become an issue.

Beyond 8-way you get into another system architecture entirely, which
should be considered on it's own merits.  In large part cache
directories and other very sophisticated techniques are needed when
you scale a system beyond the SMP point.  As long as the inter-cpu
bandwidth is >= the memory bandwidth on a single memory controller
Hammer can probably get away with being just a better SMP, and not
really a NUMA design.

Eric
