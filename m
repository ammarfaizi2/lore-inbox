Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVAZH2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVAZH2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 02:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVAZH2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 02:28:19 -0500
Received: from mx1.elte.hu ([157.181.1.137]:49292 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262000AbVAZH2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 02:28:07 -0500
Date: Wed, 26 Jan 2005 08:27:12 +0100
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
Message-ID: <20050126072712.GA1821@elte.hu>
References: <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <87k6q2umla.fsf@sulphur.joq.us> <20050125083724.GA4812@elte.hu> <87oefdfaxp.fsf@sulphur.joq.us> <20050125214900.GA9421@elte.hu> <87sm4osrix.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sm4osrix.fsf@sulphur.joq.us>
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

> >> The equivalent rlimits experiment probably requires:
> >> 
> >>   (1) editing /etc/security/limits.conf
> >>   (2) shutting everything down
> >>   (3) logout
> >>   (4) login
> >>   (5) restarting the test
> >
> > well, there's setrlimit, so you could add a jackd client callback that
> > instructs all clients to change their RT_CPU_RATIO rlimit. In theory we
> > could try to add a new rlimit syscall that changes another task's rlimit
> > (right now the syscalls only allow the changing of the rlimit of the
> > current task) - that would enable utilities to change the rlimit of all
> > tasks in the system, achieving the equivalent of a global sysctl.
> 
> Sure, we could.  That does seem like an enormously complicated
> mechanism to accomplish something so simple.  We are taking a global
> per-CPU limit, treating it as if it were per-process, then invoking a
> complex callback scheme to propagate new values, [...]

this was just a suggestion. It seems a remote-rlimit syscall is
possible, so there's no need to change Jack if you dont want to - that
syscall enables a utility that will change the rlimit for all running
tasks, so you'll get the 'simplicity of experimentation' of a global
sysctl.

(what you wont get is the ultra-fast time-to-market property of sysctl
hacks. I know that you'd probably prefer a global sysctl that you could
start using tomorrow, and i also know that the global sysctl would
suffice current Jackd needs, but we cannot sacrifice flexibility and
future utility for the sake of a couple of weeks/months of time
advantage...)

	Ingo
