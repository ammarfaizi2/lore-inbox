Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268609AbUHNLwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268609AbUHNLwd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 07:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUHNLwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 07:52:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:65232 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268641AbUHNLvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 07:51:21 -0400
Date: Sat, 14 Aug 2004 13:51:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040814115139.GB9705@elte.hu>
References: <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <411DF776.6090102@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411DF776.6090102@superbug.demon.co.uk>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* James Courtier-Dutton <James@superbug.demon.co.uk> wrote:

> I have tested this for a day now, and I have noticed problems:
> 1)
> kernel syslog gets a record like this:
> >  (default.hotplug/1470): 121 us critical section violates 100 us 
> threshold.

> and the /proc/latency_trace gets:
> >   preemption latency trace v1.0
> >   -----------------------------
> >    latency: 121 us, entries: 1032 (1032)
> >    process: default.hotplug/1470, uid: 0
> >    nice: -10, policy: 0, rt_priority: 0
> >   =======>
> >    0.000ms (+0.000ms): page_address (kmap_high)
> >    0.000ms (+0.000ms): page_slot (page_address)
> >    0.000ms (+0.000ms): flush_all_zero_pkmaps (kmap_high)
> >    0.000ms (+0.000ms): set_page_address (flush_all_zero_pkmaps)

> Could the patch be adjusted to make the syslog and the
> /proc/latency_trace produce the same output?

We cannot include the full trace in the syslog - it's possibly thousands
of lines long.

> 2)
> I suspect that there is a problem with reiserfs, but when I detect a 
> momentary hang in the system(mouse stops moving), no latency_trace appears.

well, the mouse could stop moving for a number of reasons. It's handled
via the X server and if the X server is preempted (for whatever reason)
then the mouse pointer isnt updated.

you could try to change the mouse IRQ to be non-threaded. Also, do you
have kernel_preemption set to 1? It defaults to 0.

	Ingo
