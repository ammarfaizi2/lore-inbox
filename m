Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267513AbSLSBFV>; Wed, 18 Dec 2002 20:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267515AbSLSBFV>; Wed, 18 Dec 2002 20:05:21 -0500
Received: from holomorphy.com ([66.224.33.161]:4543 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267513AbSLSBFS>;
	Wed, 18 Dec 2002 20:05:18 -0500
Date: Wed, 18 Dec 2002 17:11:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Till Immanuel Patzschke <tip@inw.de>
Cc: lse-tech <lse-tech@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 15000+ processes -- poor performance ?!
Message-ID: <20021219011144.GH31800@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Till Immanuel Patzschke <tip@inw.de>,
	lse-tech <lse-tech@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <3E0116D6.35CA202A@inw.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E0116D6.35CA202A@inw.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 04:46:15PM -0800, Till Immanuel Patzschke wrote:
> as part of my project I need to run a very high number of
> processes/threads on a linux machine.  Right now I have a Dual-PIII
> 1.4G w/ 8GB RAM -- I am running 4000 processes w/ 2-3 threads each
> totaling in a process count of 15000+ processes (since Linux doesn't
> really distinguish between threads and processes...).

You're for the most part SOL unless you can either hack the support or
can wait for it to be finished. More details below.


On Wed, Dec 18, 2002 at 04:46:15PM -0800, Till Immanuel Patzschke wrote:
> Once I pass the 10000 (+/-) pocesses load increases drastically (on
> startup, although it returns to normal), however the system time (on
> one processor) reaches for 54% (12061 procs) while the only non
> sleeping process is top -- the system is basically doing nothing
> (except scheduling the "nothing" which
> consumes significant system time).
> Is there anything I can do to reduce that system load/time?  (I
> haven't been able to exactly define the "line" but it definitly gets
> worse the more processes need to be handled.)
> Does any of the patchsets address this particular problem?
> BTW: The processes are all alike...
> Thanks for you help!

Try 2.5.52-mm1 + 2.5.52-wli-1. The -wli bits are orthogonal but they do
a small bit to reduce the cpu inefficiencies of many task loads.
-wli is actually maintenance and follow-through on various early 2.5
promises.

proc_pid_readdir() is the cpu culprit, which I have not yet addressed.
You are also going to have severe memory management problems due to the
number of L2 and L3 pagetables created as well as kernel stacks.
2.5.52-mm1 will have 2 of 3 possible things that can be done about L3
pagetables. L2 pagetables limit you to 64K processes with more practical
limits around 16K. As 16K is feasible here, you are running the wrong
kernel version(s).


Bill
