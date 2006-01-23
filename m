Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWAWUbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWAWUbJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWAWUbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:31:08 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:423 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932383AbWAWUa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:30:58 -0500
Subject: Re: Rationale for RLIMIT_MEMLOCK?
From: Lee Revell <rlrevell@joe-job.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, arjan@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <43D530CC.nailC4Y11KE7A@burner>
References: <20060123105634.GA17439@merlin.emma.line.org>
	 <1138014312.2977.37.camel@laptopd505.fenrus.org>
	 <20060123165415.GA32178@merlin.emma.line.org>
	 <1138035602.2977.54.camel@laptopd505.fenrus.org>
	 <20060123180106.GA4879@merlin.emma.line.org>
	 <1138039993.2977.62.camel@laptopd505.fenrus.org>
	 <20060123185549.GA15985@merlin.emma.line.org>
	 <43D530CC.nailC4Y11KE7A@burner>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 15:30:54 -0500
Message-Id: <1138048255.21481.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 20:38 +0100, Joerg Schilling wrote:
> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > On Mon, 23 Jan 2006, Arjan van de Ven wrote:
> >
> > > hmm... curious that mlockall() succeeds with only a 32kb rlimit....
> >
> > It's quite obvious with the seteuid() shuffling behind the scenes of the
> > app, for the mlockall() runs with euid==0, and the later mmap() with euid!=0.
> >
> > Clearly the application should do both with the same privilege or raise
> > the RLIMIT_MEMLOCK while running with privileges.
> >
> > The question that's open is one for the libc guys: malloc(), valloc()
> > and others seem to use mmap() on some occasions (for some allocation
> > sizes) - at least malloc/malloc.c comments as of 2.3.4 suggest so -, and
> > if this isn't orthogonal to mlockall() and set[e]uid() calls, the glibc
> > is pretty deeply in trouble if the code calls mlockall(MLC_FUTURE) and
> > then drops privileges.
> 
> If the behavior described by Matthias is true for current Linuc kernels,
> then there is a clean bug that needs fixing.
> 
> If the Linux kernel is not willing to accept the contract by 
> mlockall(MLC_FUTURE), then it should now accept the call at all.
> 
> In our case, the kernel did accept the call to mlockall(MLC_FUTURE), but later 
> ignores this contract. This bug should be fixed.

Joerg,

You will be happy to know that in future Linux distros, cdrecord will
not require setuid to mlock() and get SCHED_FIFO - both are now
controlled by rlimits, so if the distro ships with a sane PAM/group
configuration, all you will need to do is add cdrecord users to the
"realtime" or "cdrecord" or "audio" group.

This will take a while to make it into distros as it requires changes to
PAM and glibc in addition to the kernel.

Lee

