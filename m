Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbVFVIbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbVFVIbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbVFVI0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:26:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39130 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262934AbVFVIZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:25:55 -0400
Date: Wed, 22 Jun 2005 10:24:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050622082450.GA19957@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org> <20050621131249.GB22691@elte.hu> <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@sysex.net> wrote:

> Attached are two typical traces and the .config from my Xeon/HT box, 
> currently running -50-06 with a normal desktop workload (X, wmaker, 
> ten dockapps, several xterms, and firefox).

the second trace seems to be a cross-CPU wakeup bug. It's not completely 
clear from the trace what happened - but we measured the latency of a 
task (wmcube-3191), where the wakeup happened on CPU#0 and wmcube-3191 
was queued to CPU#1 which was idle at that time. The bug is that it 
wasnt until timestamp 306us that this actually happened - and CPU#1 was 
just idling around in default_idle() for no good reason. CPU#1 should 
have run wmcube-3191 at around timestamp 13us.

I've uploaded the -50-07 kernel which will put some more info into the 
traces - could you try to repeat the measurement and get similar 
latencies? As i guess you already found out that you can always reset 
the measurement to get a new set of traces, via:

	echo 0 > /proc/sys/kernel/preempt_max_latency

(it's not a problem if you send me multiple latency traces, i'll figure 
out which is the most useful one.)

	Ingo
