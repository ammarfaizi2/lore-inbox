Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129581AbQL0Rzs>; Wed, 27 Dec 2000 12:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130214AbQL0Rzj>; Wed, 27 Dec 2000 12:55:39 -0500
Received: from [63.95.87.168] ([63.95.87.168]:46859 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S129581AbQL0Rzf>;
	Wed, 27 Dec 2000 12:55:35 -0500
Date: Wed, 27 Dec 2000 12:25:09 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: high load & poor interactivity on fast thread creation
Message-ID: <20001227122508.A29579@xi.linuxpower.cx>
In-Reply-To: <3A266895.F522A0E2@austin.ibm.com> <20001130081443.A8118@bach.iverlek.kotnet.org> <3A266895.F522A0E2@austin.ibm.com> <4.3.2.7.2.20001227110018.00e5ba90@cam-pop.cambridge.arm.com> <3A4A22A8.D434B7F@holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <3A4A22A8.D434B7F@holly-springs.nc.us>; from rothwell@holly-springs.nc.us on Wed, Dec 27, 2000 at 12:11:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2000 at 12:11:04PM -0500, Michael Rothwell wrote:
[snip]
> One notable difference between Linux and NT threads and processes is
> that it is more expensive to create new processes on NT than on Linux,
> and on NT thread creation is cheaper than process creation. Typically
> Windows programs use multiple threads rather than multiple processes,
> whereas on Unix the reverse is true.

This is the meaty difference. Under Linux, full *process* operations 
are faster then NT *thread* operations. The Linux 'threads' (lightweight
processes) are somewhat faster then unlightweight processes, but nowhere
near the magnitude of difference that NT experiences.

Because of this, lightweight processes are used differently under Linux: They
are treated just like processes and can share variable amounts of state with
other processes.

In Linux, you use threads when it makes sense to code with threads. You can
share as little or as much makes sense with your design. You almost never use
threads for performance reasons, because regular processes are so fast that
it seldom makes sense to use threads for performance (they can be faster but
usually the additional development/debugging difficulty makes it a non-issue).

In Windows NT, you MUST use threads for decent performance in many places
where processes (or other different semi-lightweight structures) might make
more sense. Threads are the largest construction capable of really good
performance, so you don't have the flexibility to chose what you share:
What is shared is not a programming design decision but an OS performance
decision.
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
