Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVAYIiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVAYIiR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 03:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVAYIiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 03:38:17 -0500
Received: from mx1.elte.hu ([157.181.1.137]:44248 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261617AbVAYIiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 03:38:08 -0500
Date: Tue, 25 Jan 2005 09:37:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: /proc/sys/kernel/rt_cpu_limit tunable
Message-ID: <20050125083724.GA4812@elte.hu>
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <87k6q2umla.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k6q2umla.fsf@sulphur.joq.us>
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


* Jack O'Quin <joq@io.com> wrote:

> > It would be very interesting to see how jackd/jack_test performs with
> > this patch applied, and rt_cpu_limit is set to different percentages,
> > compared against unpatched SCHED_FIFO performance.
> 
> It works great...
> 
>   http://www.joq.us/jack/benchmarks/rt_cpu_limit
>   http://www.joq.us/jack/benchmarks/rt_cpu_limit+compile
>   http://www.joq.us/jack/benchmarks/.SUMMARY
> 
> I'll experiment with it some more, but this seems to meet all my
> needs.  As one would expect, the results are indistinguishable from
> SCHED_FIFO...
> 
> # rt_cpu_limit
> Delay Maximum . . . . . . . . :   290   usecs
> Delay Maximum . . . . . . . . :   443   usecs
> Delay Maximum . . . . . . . . :   232   usecs
> 
> # rt_cpu_limit+compile
> Delay Maximum . . . . . . . . :   378   usecs
> Delay Maximum . . . . . . . . :   206   usecs
> Delay Maximum . . . . . . . . :   528   usecs

very good. Could you try another thing, and set the rt_cpu_limit to less
than the CPU utilization 'top' reports during the test (or to less than
the DSP CPU utilization in the stats), to deliberately trigger the
limiting code? This both tests the limit and shows the effects it has. 
(there should be xruns and a large Delay Maximum.)

	Ingo
