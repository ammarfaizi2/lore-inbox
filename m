Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269061AbUHMKdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269061AbUHMKdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUHMKdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:33:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8642 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269061AbUHMKbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:31:09 -0400
Date: Fri, 13 Aug 2004 12:31:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040813103151.GH8135@elte.hu>
References: <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092374851.3450.13.camel@mindpipe> <1092375673.3450.15.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092375673.3450.15.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> > >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O6
> 
> Ugh, this is a bad one:
> 
> preemption latency trace v1.0
> -----------------------------
>  latency: 506 us, entries: 157 (157)
>  process: evolution/3461, uid: 1000
>  nice: 0, policy: 0, rt_priority: 0
> =======>
>  0.000ms (+0.000ms): get_random_bytes (__check_and_rekey)
[...]
>  0.493ms (+0.001ms): local_bh_enable (__check_and_rekey)

indeed this is a new one. Entropy rekeying every 300 seconds. Most of
the overhead comes from the memcpy's - 10 usecs a pop!

this could possibly explain some earlier reports of RTC problems every
couple of minutes - on slower boxes it could easily be more than the 0.5
msec you got. (and with a 8192 Hz RTC the interrupt period is 122
usecs.)

such bhs-off spinlocked sections exclude all softirq traffic - and in
the redirected hardirqs case the hardirqs are excluded too.

	Ingo
