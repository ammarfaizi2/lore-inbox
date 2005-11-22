Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbVKVSXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbVKVSXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbVKVSXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:23:33 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:55727 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965083AbVKVSXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:23:32 -0500
Date: Tue, 22 Nov 2005 13:22:57 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Christopher Friesen <cfriesen@nortel.com>
cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: Re: test time-warps [was: Re: 2.6.14-rt13]
In-Reply-To: <43835D01.3020304@nortel.com>
Message-ID: <Pine.LNX.4.58.0511221319560.16745@gandalf.stny.rr.com>
References: <20051115090827.GA20411@elte.hu>  <1132608728.4805.20.camel@cmn3.stanford.edu>
  <20051121221511.GA7255@elte.hu> <20051121221941.GA11102@elte.hu> 
 <Pine.LNX.4.58.0511212012020.5461@gandalf.stny.rr.com>  <20051122111623.GA948@elte.hu>
 <1132681766.21797.10.camel@cmn3.stanford.edu> <43835D01.3020304@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Nov 2005, Christopher Friesen wrote:

> Fernando Lopez-Lezcano wrote:
>
> >>Basically if there is an observable and provable warp in the TSC output
> >>then it must not be used for any purpose that is not strictly
> >>per-CPU-ified (such as userspace threads bound to a single CPU, and the
> >>TSC never used between threads).
>
> > Apparently that's the case.
>
> What about periodically re-syncing the TSCs on the cpus?  Are they
> writeable?
>

I believe you can reset them to zero, but I don't think you can set them
to anything else.  I had to do something similar a few years ago, and I
don't have the specs in front of me, so this is coming straight from
memory.

Even if you could reset them, it would be very difficult to make all CPUs
have the same counter. Not to mention that this would also screw up all
timings elsewhere when the sync happens. Remember, this would have to work
not just on 2 cpus, but 4, 8 and beyond.

-- Steve

