Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVFUNTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVFUNTs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVFUNSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:18:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:1452 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261315AbVFUNPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:15:17 -0400
Date: Tue, 21 Jun 2005 15:12:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050621131249.GB22691@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@sysex.net> wrote:

> I also regularly see high (>200us) wakeup latencies on the Xeon/HT, 
> which I don't see on the Athlon or non-HT Xeon systems.  Disabling IRQ 
> balancing doesn't seem to help.  It's been a while since the Xeon/HT 
> box has seen a non-debug kernel, but in the past, that hasn't helped 
> latencies by more than a few usec.

>   <idle>-0     0Dnh2    4us : find_next_bit (__schedule)
>   <idle>-0     0Dnh2    4us : _raw_spin_lock (__schedule)
>   <idle>-0     0Dnh3    4us!: find_next_bit (__schedule)
>   <idle>-0     0Dnh3  244us : find_next_bit (__schedule)
>   <idle>-0     0Dnh3  245us : _raw_spin_unlock (__schedule)

this does seem to be similar to other reports where the cause of such 
latencies was some sort of hardware-level latency. (DMA related delays 
or other, bus-arbitration related delays)

another possibility is that something interesting happened on another 
CPU while this latency occured - to debug this please enable all-CPUs 
tracing:

	echo 1 > /proc/sys/kernel/trace_all_cpus

and send me a new trace.

	Ingo
