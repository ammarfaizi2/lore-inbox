Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbULAQRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbULAQRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 11:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbULAQRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 11:17:45 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:17121 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261302AbULAQRO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 11:17:14 -0500
Date: Wed, 1 Dec 2004 17:16:16 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
In-Reply-To: <20041201155353.GA30193@elte.hu>
Message-Id: <Pine.OSF.4.05.10412011708520.8736-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Dec 2004, Ingo Molnar wrote:

> 
> * Paul Davis <paul@linuxaudiosystems.com> wrote:
> 
> > >also, the problem is that jackd uses _named_ fifos, which are tied to
> > >the raw FS and might trigger journalling activities. Normal pipes
> > >(unnamed fifos) would not cause such problems. Would it be possible to
> > >change jackd to use a pair of pipes, instead of a fifo?
> > 
> > i.e. pipe(2) rather than mkfifo(2) ?
> > 
> > it would be a complete pain because the pipes have to be
> > "discoverable" across processes. we would have to do fd passing, which
> > is still really quite ugly in linux (and other *nix systems). it would
> > quite difficult, though not impossible.
> 
> yeah. And i think mkfifo(2) objects ought to behave atomically as well,
> it's an unfortunate side-effect of atime/mtime inode semantics that they
> can block.
> 
> your point is correct, the best way to have a system-wide namespace for
> synchronization objects is ... the filesystem hierarchy. If you create a
> unix domain socket then you can distribute your pipe fds, but that's
> indeed somewhat painful.
> 

Don't worry about setting up the stuff. Once you have the pipe it ought to
be RT in the usage of read/write,  but setting it up is something you is
something you do "under boot", just as allocating memory and other
non-real-time stuff. 


> 	Ingo
> 

Esben

