Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262892AbVAKVqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbVAKVqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVAKVpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:45:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:42398 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262892AbVAKVmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:42:55 -0500
Date: Tue, 11 Jan 2005 13:42:51 -0800
From: Chris Wright <chrisw@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Chris Wright <chrisw@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111134251.O10567@build.pdx.osdl.net>
References: <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us> <20050110212019.GG2995@waste.org> <87d5wc9gx1.fsf@sulphur.joq.us> <20050111195010.GU2940@waste.org> <871xcr3fjc.fsf@sulphur.joq.us> <20050111200549.GW2940@waste.org> <1105475349.4295.21.camel@krustophenia.net> <20050111124707.J10567@build.pdx.osdl.net> <20050111212823.GX2940@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050111212823.GX2940@waste.org>; from mpm@selenic.com on Tue, Jan 11, 2005 at 01:28:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Mackall (mpm@selenic.com) wrote:
> On Tue, Jan 11, 2005 at 12:47:07PM -0800, Chris Wright wrote:
> > Guys, could we please bring this back to a useful discussion.  None of
> > you have commented on whether the rlimits for priority are useful.  As I
> > said before, I've no real problem with the module as it stands since it's
> > tiny, quite contained, and does something people need.  But I agree it'd
> > be better to find something that's workable as long term solution.
> 
> I almost like it. I don't like that it exposes the internal scheduler
> priorities directly (-tiny in fact has options to change these!). So
> perhaps some thought could be given to either stratifying it a bit
> more (>2000 for SCHED_FIFO, >1000 for SCHED_RR, then SCHED_OTHER) or
> separate limits for the different scheduling disciplines. 

Yeah, I don't like that either (thought I mentioned it in earliest
patch).  I thought about the method you mentioned, but didn't like it
much better.  I also suggested using 0 == default, 1 == can nice down,
2 == can set RT prio.  Utz suggests just splitting nice limit from rt
limit.

> But I'm also still not convinced this policy can't be most flexibly
> handled by a setuid helper together with the mlock rlimit.

Wait, why can't it be done with (to date fictitious) pam_prio, which
simply calls sched_setscheduler?  It's already privileged while it's
doing these things...

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
