Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318833AbSIISuJ>; Mon, 9 Sep 2002 14:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318838AbSIISuJ>; Mon, 9 Sep 2002 14:50:09 -0400
Received: from borg.org ([208.218.135.231]:49788 "HELO borg.org")
	by vger.kernel.org with SMTP id <S318833AbSIISuH>;
	Mon, 9 Sep 2002 14:50:07 -0400
Date: Mon, 9 Sep 2002 14:54:51 -0400
From: Kent Borg <kentborg@borg.org>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020909145451.G14891@borg.org>
References: <1029760150.19376.14.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0209072328240.21724-100000@redshift.mimosa.com> <alg3ct$pru$1@abraham.cs.berkeley.edu> <20020909165303.GA31597@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020909165303.GA31597@waste.org>; from oxymoron@waste.org on Mon, Sep 09, 2002 at 11:53:03AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of this thread is about on-going sources of entropy, but what
about initial state?  Yes, distributions such as Red Hat save the pool
when shutting down and restore it on booting.  But what about initial
initial state?  What about those poor headless servers that get built
by Kickstart?  What about the individual blades in a server?  What
about poor embedded routers that are really impoverished: Nothing but
a CPU, timers, ethernet hardware, and ROM.  And DRAM!

Why not use the power-on state of DRAM as a source of initial pool
entropy?  

Sure, DRAM isn't very random in its power-up state, but say it is as
much as 5-nines predicatable (which I seriously doubt it is), that is
still over 300-bytes of valuable entropy for a box with a mere 4MB of
DRAM.  I could easily imagine the number to be 10-times that: If just
one in 8192 bits changed from one power up to the next that would
match the full 4096-bits currently kept in the Linux entropy pool.

Even if a given DRAM chip doesn't change very much from one boot to
the next, different DRAM chips (in different boxes), will vary from
each other by much more and that is useful.

And, even if a given DRAM chip doesn't vary much from one power-on to
another 10-minutes later, DRAM does vary over time: some paranoids
worry that keys stored in RAM might be recoverable because of long
term changes to the chips.  If this is a reasonable worry, then isn't
this kind of imprinting also another source of uniqueness for a given
box?  Yes, if you let the Bad Guy analyze your RAM you some much of
this benefit, but if you let the Bad Guy have your hardware to play
with you are in bigger trouble.

Anyone know of measurements of DRAM power-on variability?  

Wouldn't everyone benefit from initializing the pool with a hash of
(at least some of--don't want to be too slow) RAM?  Even big
installations that save state on disk shouldn't mind.  And make this a
configuration option for those embedded folks who have a slow CPU and
a need for fast booting (and a disinterest in entropy).


-kb
