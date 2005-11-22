Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbVKVUwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbVKVUwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 15:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVKVUwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 15:52:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:48104 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965181AbVKVUwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 15:52:43 -0500
Date: Tue, 22 Nov 2005 21:52:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christopher Friesen <cfriesen@nortel.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "K.R. Foley" <kr@cybsft.com>, Thomas Gleixner <tglx@linutronix.de>,
       pluto@agmk.net, john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>
Subject: Re: test time-warps [was: Re: 2.6.14-rt13]
Message-ID: <20051122205200.GA17151@elte.hu>
References: <20051115090827.GA20411@elte.hu> <1132608728.4805.20.camel@cmn3.stanford.edu> <20051121221511.GA7255@elte.hu> <20051121221941.GA11102@elte.hu> <Pine.LNX.4.58.0511212012020.5461@gandalf.stny.rr.com> <20051122111623.GA948@elte.hu> <1132681766.21797.10.camel@cmn3.stanford.edu> <43835D01.3020304@nortel.com> <Pine.LNX.4.58.0511221319560.16745@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511221319560.16745@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > > Apparently that's the case.
> >
> > What about periodically re-syncing the TSCs on the cpus?  Are they
> > writeable?
> 
> I believe you can reset them to zero, but I don't think you can set 
> them to anything else.  I had to do something similar a few years ago, 
> and I don't have the specs in front of me, so this is coming straight 
> from memory.

on a reasonably new CPU you ought to be able to set the 64-bit value - 
but that doesnt change the fundamental fact: we have no idea how much 
time has passed while we were in HLT. Especially with things like 
dyntick/noidle we could spend _alot_ of time in HLT, and the TSC could 
drift significantly. How do we know how much that is?

	Ingo
