Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262853AbVAKTYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbVAKTYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbVAKTXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:23:32 -0500
Received: from waste.org ([216.27.176.166]:12434 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262853AbVAKTRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:17:33 -0500
Date: Tue, 11 Jan 2005 11:17:02 -0800
From: Matt Mackall <mpm@selenic.com>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "Jack O'Quin" <joq@io.com>, Chris Wright <chrisw@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111191701.GT2940@waste.org>
References: <20050110212019.GG2995@waste.org> <200501111305.j0BD58U2000483@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501111305.j0BD58U2000483@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 08:05:08AM -0500, Paul Davis wrote:
> >> Running `nice --20' is still significantly worse than SCHED_FIFO, but
> >> not the unmitigated disaster shown in the middle column.  But, this
> >> improved performance is still not adequate for audio work.  The worst
> >> delay was absurdly long (~1/2 sec).
> >
> >Let's work on that. It'd be _far_ better to have unprivileged near-RT
> >capability everywhere without potential scheduling DoS.
> 
> I am not sure what you mean here. I think we've established that
> SCHED_OTHER cannot be made adequate for realtime audio work. Its
> intended purpose (timesharing the machine in ways that should
> generally benefit tasks that don't do a lot and/or are dominated by
> user interaction, thus rendering the machine apparently responsive) is
> really at odds with what we need.

We have not established that at all. In principle, because SCHED_OTHER
tasks running at full priority lie on the boundary between SCHED_OTHER
and SCHED_FIFO, they can be made to run arbitrarily close to the
performance of tasks in SCHED_FIFO. With the upside that they won't be
able to deadlock the machine.

And I mean arbitrarily close in the strict delta-epsilon sense.
It's not perfect, but neither is SCHED_FIFO, in principle or in
practice. 

-- 
Mathematics is the supreme nostalgia of our time.
