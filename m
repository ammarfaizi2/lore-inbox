Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVAMBKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVAMBKJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVAMBH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 20:07:28 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1732 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261487AbVALVvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:51:54 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20050112190949.GH2940@waste.org>
References: <20050111230642.GD2940@waste.org>
	 <200501120213.j0C2DjGO008084@localhost.localdomain>
	 <20050112190949.GH2940@waste.org>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 16:25:58 -0500
Message-Id: <1105565159.3357.11.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-12 at 11:09 -0800, Matt Mackall wrote:
> On Tue, Jan 11, 2005 at 09:13:44PM -0500, Paul Davis wrote:
> > >A client starts at normal priority, asks jack nicely to promote it to
> > >RT, then jackd, if so configured/enabled, calls the wrapper with a PID
> > 
> > a PID? clients are multithreaded, and only specific threads run with
> > RT scheduling (normally just the one created for them by
> > libjack). So you presumably mean a TID, which in turn creates a
> > problem for any system (e.g. 2.4) where all threads share the PID, and
> > sched_setscheduler() really does use the PID as a PID, not a TID.
> 
> That actually sounds like an independent API problem.
> 

What's your point?  It has to work on 2.4, so this is not a feasible
solution.

> > but its gets worse. JACK clients need to drop RT scheduling under
> > certain, well-defined circumstances. how do they get it back under
> > this scheme?
> 
> Assuming a more thread-aware API, they just ask for privileges again.
> But with the non-thread-aware API, my first reaction would be the thread in
> question clones, and the clone drops privileges.
> 

Clones?  Seems pretty inefficient compared to having a simple mechanism
for root to grant users the ability to run RT tasks.  We have such a
system now, and it works perfectly, so any solution that makes people
jump through hoops will be rejected.

Lee

