Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbULAO4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbULAO4x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 09:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbULAO4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 09:56:53 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:54681 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261268AbULAO4p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 09:56:45 -0500
Message-Id: <200412011456.iB1EubBI004051@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: Florian Schmidt <mista.tapas@gmx.net>, Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2 
In-reply-to: Your message of "Wed, 01 Dec 2004 15:37:38 +0100."
             <20041201143738.GA12563@elte.hu> 
Date: Wed, 01 Dec 2004 09:56:37 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [141.151.23.119] at Wed, 1 Dec 2004 08:56:39 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>in kernels -V0.7.30-9 or later they are RT-safe when PREEMPT_RT is
>enabled.

thats good to hear.

>also, the problem is that jackd uses _named_ fifos, which are tied to
>the raw FS and might trigger journalling activities. Normal pipes
>(unnamed fifos) would not cause such problems. Would it be possible to
>change jackd to use a pair of pipes, instead of a fifo?

i.e. pipe(2) rather than mkfifo(2) ?

it would be a complete pain because the pipes have to be
"discoverable" across processes. we would have to do fd passing, which
is still really quite ugly in linux (and other *nix systems). it
would quite difficult, though not impossible.

>> [...] i have outlined an idea to ingo that florian and i cooked up one
>> evening on IRC that would provide true RT-safe IPC mechanisms, but as
>> i recall, he didn't seem to think that much of it :)
>
>actually, my answer (sent on Nov 1) was:
>
>> futexes are nearly lock-free. [and even those locks are short-held so
>> combined with priority-inheritance they should be lockfree in
>> essence.] Would futexes suit your purposes?
>
>to which suggestion i got no reply yet :-)

i am still trying to find the time to investigate futexes. they seem
close to the desired object, but have a slightly more general semantic
than i can fit into my head right now;)

--p
