Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVA0JAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVA0JAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 04:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbVA0JAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 04:00:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56772 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262510AbVA0JAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 04:00:30 -0500
Date: Thu, 27 Jan 2005 09:59:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050127085947.GA24801@elte.hu>
References: <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us> <1106805249.5158.77.camel@npiggin-nld.site> <20050127083506.GD22482@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127083506.GD22482@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> negative nice levels are a guaranteed way to monopolize the CPU. 
> SCHED_FIFO with throttling could at most be used to 'steal' CPU time
> up to the threshold. Also, if a task 'runs away' in SCHED_FIFO mode it
> will be efficiently throttled. While if it 'runs away' in nice--20
> mode, it will take away 95+% of the CPU time quite agressively.
> Furthermore, more nice--20 tasks will do much more damage (try thunk.c
> at nice--20!), while more throttled SCHED_FIFO tasks only do damage to
> their own class - the guaranteed share of SCHED_OTHER tasks (and
> privileged RT tasks) is not affected.

furthermore, the current way of throttling SCHED_FIFO tasks that violate
the limit makes it less likely that application writers would abuse the
feature with CPU-intensive apps, because _if_ you violate the limit then
the penalty is high. E.g. a blatant violation of the limit via a pure
CPU loop ends up getting much less CPU time than even the limit would
allow for. For audio/RT apps this is fine, because they must plan their
CPU overhead anyway so they are a much more controlled environment and
just do things properly to avoid the penalty.

	Ingo
