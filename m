Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVEaUyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVEaUyf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 16:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVEaUyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 16:54:35 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33386
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261456AbVEaUyc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 16:54:32 -0400
Date: Tue, 31 May 2005 22:54:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>
Subject: Re: RT patch acceptance
Message-ID: <20050531205424.GV5413@g5.random>
References: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk> <1117556283.2569.26.camel@localhost.localdomain> <20050531171143.GS5413@g5.random> <1117561379.2569.57.camel@localhost.localdomain> <20050531175152.GT5413@g5.random> <1117564192.2569.83.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117564192.2569.83.camel@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 02:29:52PM -0400, Steven Rostedt wrote:
> Probably, what I was talking about is diamond hard, and Ingo's RT patch
> is metal hard.  PREEMPT is just wood hard and !PREEMPT is plastic hard*.
> Leaving MS Windows as feather hard ;-)

Yes, this is a nice way to expose it ;)

> believe that what the -RT patch is giving us, is something that can give
> the Linux kernel more that it can guarantee, but not everything. Which I
> think is a good thing (and keeps me employed :-)

;)

One thing we should be careful: if syscalls aren't needed in the app and
all the MMIO space can be mmapped by the device driver and the app can
run fully in userland and be invoked from irqs, then going with the
"diamond hard" is not more complicated than going with the weak
solutions. The "diamond hard" will work in userland too, and it won't be
substantially different from a soft-RT "metal hard" approach like
preempt-RT. So it'd be very bad if people would choose preempt-RT if
they could equally easily go with RTAI or other "diamond hard" solutions
that are order of magnitude simpler and safer.

> more for telecommunication and as others said, music.  Before I left

Those are certainly areas where linux kernel has to be involved, and in
turn the "diamond hard" isn't feasible anyway without huge efforts. So
for them I definitely agree preempt-RT scheduling irqs in userland is
ok.

> * OK, maybe still not as hard as what is mentioned, but I couldn't think
> of better terminology. I do stand by what I called diamond and what I
> called feather. ;-)

;)

> the OS didn't need to be tested the same, and as mentioned, the lack of
> terminology for this is the source of most problems, as is demonstrated
> on this thread!

As you said what I've always meant with hard-RT is the "diamond hard"
thing. After all in linux everything that called hard-RT (RTAI, RTLinux,
nanokernel) was "diamond hard" so far, preempt-RT is the first time in
linux where I see the word "hard-RT" combined with something not
"diamond hard".

thanks.
