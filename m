Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbULBJNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbULBJNe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 04:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbULBJNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 04:13:34 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:29213 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261571AbULBJNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 04:13:23 -0500
Message-ID: <47441.195.245.190.94.1101978748.squirrel@195.245.190.94>
In-Reply-To: <32786.192.168.1.5.1101940309.squirrel@192.168.1.5>
References: <17532.195.245.190.94.1101829198.squirrel@195.245.190.94>   
    <20041201103251.GA18838@elte.hu>   
    <32831.192.168.1.5.1101905229.squirrel@192.168.1.5>   
    <20041201154046.GA15244@elte.hu> <20041201160632.GA3018@elte.hu>   
    <20041201162034.GA8098@elte.hu>   
    <33059.192.168.1.5.1101927565.squirrel@192.168.1.5>   
    <20041201212925.GA23410@elte.hu> <20041201213023.GA23470@elte.hu>   
    <32788.192.168.1.8.1101938057.squirrel@192.168.1.8>   
    <20041201220916.GA24992@elte.hu>
    <32786.192.168.1.5.1101940309.squirrel@192.168.1.5>
Date: Thu, 2 Dec 2004 09:12:28 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>, "Andrew Morton" <akpm@osdl.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 02 Dec 2004 09:13:22.0366 (UTC) FILETIME=[2BE4FDE0:01C4D84F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> ... I'll have to rebuild a new RT-V0.7.31-19 kernel without latency
> timing stuff, just to make sure we'll compare apples to apples ;)
>

Oh, and running also an jackd 0.99.17cvs _without_ the xrun trace
auto-trigger patch, so to end up with a production-like system.

And that was it. After a total of 4 hours running free, the jack_test3
suite spitted out these results, which speak from themselves:

    *********** CONSOLIDATED RESULTS ************
    Total seconds ran . . . . . . : 14400
    Number of clients . . . . . . :    16
    Ports per client  . . . . . . :     4
    *********************************************
    Summary Result Count  . . . . :     4 /     4
    *********************************************
    Timeout Rate  . . . . . . . . :(    0.0)/hour
    XRUN Rate . . . . . . . . . . :     0.0 /hour
    Delay Rate (>spare time)  . . :     0.0 /hour
    Delay Rate (>1000 usecs)  . . :     0.0 /hour
    Delay Maximum . . . . . . . . :    77   usecs
    Cycle Maximum . . . . . . . . :  1029   usecs
    Average DSP Load. . . . . . . :    60.0 %
    Average CPU System Load . . . :    19.6 %
    Average CPU User Load . . . . :    47.7 %
    Average CPU Nice Load . . . . :     0.0 %
    Average CPU I/O Wait Load . . :     0.0 %
    Average CPU IRQ Load  . . . . :     0.0 %
    Average CPU Soft-IRQ Load . . :     0.0 %
    Average Interrupt Rate  . . . :  1689.1 /sec
    Average Context-Switch Rate . : 19781.4 /sec
    *********************************************

This is frankly the best performance EVER on this laptop machine, given
these jackd parameters (-R -P60 -dalsa -dhw:0 -r44100 -p64 -n2 -S -P).

Next step is really trying to increase the stress and look after when it
will break apart. It will not take too long...

First attempts, by just increasing the client count from 16 to 20, are
leading to what will be the next "horror show" :) CPU tops above 90%, and
after a couple of minutes running steadly it enters into some kind of
turbulence and hangs. Yeah, it just freezes completely.

So I guess we're having a lot more food to mangle ;)

Stay tuned.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

