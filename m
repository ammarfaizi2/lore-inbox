Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316127AbSGOCn0>; Sun, 14 Jul 2002 22:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316571AbSGOCnZ>; Sun, 14 Jul 2002 22:43:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27711 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S316127AbSGOCnZ>; Sun, 14 Jul 2002 22:43:25 -0400
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Paul McKenney <Paul.McKenney@us.ibm.com>
Subject: Re: [patch[ Simple Topology API
References: <p73ofdbv1a4.fsf@oldwotan.suse.de>
	<Pine.LNX.4.44.0207141156540.19060-100000@home.transmeta.com>
	<20020714214334.A16892@wotan.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Jul 2002 20:34:51 -0600
In-Reply-To: <20020714214334.A16892@wotan.suse.de>
Message-ID: <m1k7nxpvlg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:
> 
> At least on Hammer the latency difference is small enough that 
> caring about the overall bandwidth makes more sense.

I agree.  I will have to look closer but unless there is more
juice than I have seen in Hyper-Transport it is going to become
one of the architectural bottlenecks of the Hammer.

Currently you get 1600MB/s in a single direction.  Not to bad.
But when the memory controllers get out to dual channel DDR-II 400,
the local bandwidth to that memory is 6400MB/s, and the bandwidth to
remote memory 1600MB/s, or 3200MB/s (if reads are as common as
writes).  

So I suspect bandwidth intensive applications will really benefit
from local memory optimization on the Hammer.  I can buy that the
latency is negligible, the fact the links don't appear to scale
in bandwidth as well as the connection to memory may be a bigger
issue.

> > And then you associate that zone-list with the process, and use that
> > zone-list for all process allocations.
> 
> That's the basic idea sure for normal allocations from applications
> that do not care much about NUMA.
> 
> But "numa aware" applications want to do other things like: 
> - put some memory area into every node (e.g. for the numa equivalent of
> per CPU data in the kernel)
> - "stripe" a shared memory segment over all available memory subsystems
> (e.g. to use memory bandwidth fully if you know your interconnect can
> take it; that's e.g. the case on the Hammer)

The latter I really quite believe.  Even dual channel PC2100 can
exceed your interprocessor bandwidth.

And yes I have measured 2000MB/s memory copy with an Athlon MP and
PC2100 memory.

Eric
