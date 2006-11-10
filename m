Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932837AbWKJKjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837AbWKJKjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932842AbWKJKjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:39:06 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20448 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932837AbWKJKjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:39:03 -0500
Date: Fri, 10 Nov 2006 11:38:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Chinner <dgc@sgi.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061110103835.GF3196@elf.ucw.cz>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611081310.19100.rjw@sisk.pl> <20061108180921.GA7708@ucw.cz> <200611091652.34649.rjw@sisk.pl> <20061109160003.GA24156@elf.ucw.cz> <20061110003332.GM8394166@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110003332.GM8394166@melbourne.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > OTOH I have no idea _how_ we can tell xfs that the processes have been
> > > frozen.  Should we introduce a global flag for that or something?
> > 
> > I guess XFS should just do all the writes from process context, and
> > refuse any writing when its threads are frozen... I actually still
> > believe it is doing the right thing, because you can't really write to
> > disk from timer.
> 
> As per the recent thread about this, XFS threads suspend correctly
> and XFS doesn't issue I/O from timers.
> 
> The problem appears to be per-cpu workqueues that don't get
> suspended because suspend does not shut down workqueue threads. You

Workqueues should be easy to handle. current->flags &= ~PF_NONFREEZE,
and problem should be solved.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
