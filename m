Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130196AbQL0SDT>; Wed, 27 Dec 2000 13:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130214AbQL0SDK>; Wed, 27 Dec 2000 13:03:10 -0500
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:54285
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S130196AbQL0SDD>; Wed, 27 Dec 2000 13:03:03 -0500
Date: Wed, 27 Dec 2000 09:32:36 -0800
From: Larry McVoy <lm@bitmover.com>
To: Gregory Maxwell <greg@linuxpower.cx>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: high load & poor interactivity on fast thread creation
Message-ID: <20001227093236.A1409@work.bitmover.com>
Mail-Followup-To: Gregory Maxwell <greg@linuxpower.cx>,
	Michael Rothwell <rothwell@holly-springs.nc.us>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A266895.F522A0E2@austin.ibm.com> <20001130081443.A8118@bach.iverlek.kotnet.org> <3A266895.F522A0E2@austin.ibm.com> <4.3.2.7.2.20001227110018.00e5ba90@cam-pop.cambridge.arm.com> <3A4A22A8.D434B7F@holly-springs.nc.us> <20001227122508.A29579@xi.linuxpower.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <20001227122508.A29579@xi.linuxpower.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great post.  Rob Pike said it best, if you are trying to distill it down
to one sentence, when he said

    "If you think you need threads, you processes are too fat"

Stevel Kleiman had a somewhat more cryptic comment (somewhat is an
understatement, it took me years to let it sink in) in reference to
a popular DB technology from a west coast University:

    "They didn't use mmap"

I don't have anything as catchy, but for years I've felt that plain old 
processes combined with mmap give you all the sharing you need.  You do
pay a price for not sharing TLB entries if the OS is stupid (Linux' is
not).

On Wed, Dec 27, 2000 at 12:25:09PM -0500, Gregory Maxwell wrote:
> On Wed, Dec 27, 2000 at 12:11:04PM -0500, Michael Rothwell wrote:
> [snip]
> > One notable difference between Linux and NT threads and processes is
> > that it is more expensive to create new processes on NT than on Linux,
> > and on NT thread creation is cheaper than process creation. Typically
> > Windows programs use multiple threads rather than multiple processes,
> > whereas on Unix the reverse is true.
> 
> This is the meaty difference. Under Linux, full *process* operations 
> are faster then NT *thread* operations. The Linux 'threads' (lightweight
> processes) are somewhat faster then unlightweight processes, but nowhere
> near the magnitude of difference that NT experiences.
> 
> Because of this, lightweight processes are used differently under Linux: They
> are treated just like processes and can share variable amounts of state with
> other processes.
> 
> In Linux, you use threads when it makes sense to code with threads. You can
> share as little or as much makes sense with your design. You almost never use
> threads for performance reasons, because regular processes are so fast that
> it seldom makes sense to use threads for performance (they can be faster but
> usually the additional development/debugging difficulty makes it a non-issue).
> 
> In Windows NT, you MUST use threads for decent performance in many places
> where processes (or other different semi-lightweight structures) might make
> more sense. Threads are the largest construction capable of really good
> performance, so you don't have the flexibility to chose what you share:
> What is shared is not a programming design decision but an OS performance
> decision.
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
