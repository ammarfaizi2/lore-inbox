Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbULAPyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbULAPyO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 10:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbULAPyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 10:54:14 -0500
Received: from mx2.elte.hu ([157.181.151.9]:21936 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261283AbULAPyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 10:54:10 -0500
Date: Wed, 1 Dec 2004 16:53:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Rui Nuno Capela <rncbc@rncbc.org>,
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
Message-ID: <20041201155353.GA30193@elte.hu>
References: <20041201143738.GA12563@elte.hu> <200412011456.iB1EubBI004051@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412011456.iB1EubBI004051@localhost.localdomain>
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


* Paul Davis <paul@linuxaudiosystems.com> wrote:

> >also, the problem is that jackd uses _named_ fifos, which are tied to
> >the raw FS and might trigger journalling activities. Normal pipes
> >(unnamed fifos) would not cause such problems. Would it be possible to
> >change jackd to use a pair of pipes, instead of a fifo?
> 
> i.e. pipe(2) rather than mkfifo(2) ?
> 
> it would be a complete pain because the pipes have to be
> "discoverable" across processes. we would have to do fd passing, which
> is still really quite ugly in linux (and other *nix systems). it would
> quite difficult, though not impossible.

yeah. And i think mkfifo(2) objects ought to behave atomically as well,
it's an unfortunate side-effect of atime/mtime inode semantics that they
can block.

your point is correct, the best way to have a system-wide namespace for
synchronization objects is ... the filesystem hierarchy. If you create a
unix domain socket then you can distribute your pipe fds, but that's
indeed somewhat painful.

	Ingo
