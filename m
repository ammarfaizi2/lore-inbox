Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132496AbRDDWSR>; Wed, 4 Apr 2001 18:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132500AbRDDWR6>; Wed, 4 Apr 2001 18:17:58 -0400
Received: from monza.monza.org ([209.102.105.34]:33809 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S132496AbRDDWRz>;
	Wed, 4 Apr 2001 18:17:55 -0400
Date: Wed, 4 Apr 2001 15:16:32 -0700
From: Tim Wright <timw@splhi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Hubertus Franke <frankeh@us.ibm.com>, Mike Kravetz <mkravetz@sequent.com>,
        Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: a quest for a better scheduler
Message-ID: <20010404151632.A2144@kochanski>
Reply-To: timw@splhi.com
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Hubertus Franke <frankeh@us.ibm.com>,
	Mike Kravetz <mkravetz@sequent.com>,
	Fabio Riccardi <fabio@chromium.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <OFB30A8B18.2E3AD16C-ON85256A24.004BD696@pok.ibm.com> <Pine.LNX.4.30.0104041518540.5382-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.30.0104041518540.5382-100000@elte.hu>; from mingo@elte.hu on Wed, Apr 04, 2001 at 03:23:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 03:23:34PM +0200, Ingo Molnar wrote:
> 
> On Wed, 4 Apr 2001, Hubertus Franke wrote:
> 
> > I understand the dilemma that the Linux scheduler is in, namely
> > satisfy the low end at all cost. [...]
> 
> nope. The goal is to satisfy runnable processes in the range of NR_CPUS.
> You are playing word games by suggesting that the current behavior prefers
> 'low end'. 'thousands of runnable processes' is not 'high end' at all,
> it's 'broken end'. Thousands of runnable processes are the sign of a
> broken application design, and 'fixing' the scheduler to perform better in
> that case is just fixing the symptom. [changing the scheduler to perform
> better in such situations is possible too, but all solutions proposed so
> far had strings attached.]
> 


Ingo, you continue to assert this without giving much evidence to back it up.
All the world is not a web server. If I'm running a large OLTP database with
thousands of clients, it's not at all unreasonable to expect periods where
several hundred (forget the thousands) want to be serviced by the database
engine. That sounds like hundreds of schedulable entities be they processes
or threads or whatever. This sort of load is regularly run on machine with
16-64 CPUs.

Now I will admit that it is conceivable that you can design an application that
finds out how many CPUs are available, creates threads to match that number
and tries to divvy up the work between them using some combination of polling
and asynchronous I/O etc. There are, however a number of problems with this
approach:
1) It assumes that this is the only workload on the machine. If not it quickly
becomes sub-optimal due to interactions between the workloads. This is a
problem that the kernel scheduler does not suffer from.
2) It requires *every* application designer to design an effective scheduler
into their application. I would submit that an effective scheduler is better
situated in the operating system.
3) It is not a familiar programming paradigm to many Unix/Linux/POSIX
programmers, so you have a sort of impedance mismatch going on.

Since the proposed scheduler changes being talked about here have been shown
to not hurt the "low end" and to dramatically improve the "high end", I fail
to understand the hostility to the changes. I can understand that you do not
feel that this is the correct way to architect an application, but if the
changes don't hurt you, why sabotage changes that also allow a different
method to work. There isn't one true way to do anything in computing.

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
