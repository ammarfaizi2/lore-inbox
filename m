Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVANDc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVANDc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVAND3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:29:40 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:63458 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261889AbVAND04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:26:56 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: utz lehmann <lkml@s2y4n2c.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Arjan van de Ven <arjanv@redhat.com>,
       "Jack O'Quin" <joq@io.com>, Chris Wright <chrisw@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <41E7319A.202@kolivas.org>
References: <20050111214152.GA17943@devserv.devel.redhat.com>
	 <200501112251.j0BMp9iZ006964@localhost.localdomain>
	 <20050111150556.S10567@build.pdx.osdl.net> <87y8ezzake.fsf@sulphur.joq.us>
	 <20050112074906.GB5735@devserv.devel.redhat.com>
	 <87oefuma3c.fsf@sulphur.joq.us>
	 <20050113072802.GB13195@devserv.devel.redhat.com>
	 <878y6x9h2d.fsf@sulphur.joq.us>
	 <20050113210750.GA22208@devserv.devel.redhat.com>
	 <1105651508.3457.31.camel@krustophenia.net>
	 <1105668319.15692.16.camel@segv.aura.of.mankind>
	 <41E729A9.7060005@kolivas.org>
	 <1105670137.15692.36.camel@segv.aura.of.mankind> <41E7319A.202@kolivas.org>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 04:26:35 +0100
Message-Id: <1105673195.15692.40.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 13:42 +1100, Con Kolivas wrote:
> utz lehmann wrote:
> > On Fri, 2005-01-14 at 13:08 +1100, Con Kolivas wrote:
> > 
> >>utz lehmann wrote:
> >>>Just an idea. What about throttling runaway RT tasks?
> >>>If the system spend more than 98% in RT tasks for 5s consider this as a
> >>>_fatal error_. Print an error message and throttle RT tasks by inserting
> >>>ticks where only SCHED_OTHER tasks allowed. For a limit of 98% this
> >>>means one SCHED_OTHER only tick all 50 ticks.
> >>>
> >>>The limit and timeout should be configurable and of course it can be
> >>>disabled.
> >>>
> >>>I know this is against RT task preempt all SCHED_OTHER but this is only
> >>>for a fatal system state to be able to recover sanely. A locked up
> >>>machine is is the worse alternative.
> >>
> >>There is a patch in -mm currently designed to use a sysrq key 
> >>combination which converts all real time tasks to sched normal to save 
> >>you if you desire in a lockup situation. We do want to preserve RT 
> >>scheduling behaviour at all times without caveats for privileged users.
> > 
> > 
> > The sysrq is already in 2.6.10. I had to use it the last days a few
> > times. But it does help if you have no access to the console.
> > 
> > The RT throttling idea is not to change the behavior in normal
> > conditions. It's only for a fatal system state. If you have a runaway RT
> > task you can't guarantee the system is work properly anyway. It's
> > blocking vital kernel threads, filesystems, swap, keyboard, ...
> 
> I understand fully your concern. If such a thing were to be introduced 
> it would have to be disabled by default. Since I'm looking at 
> implementing such throttling for user RT tasks, it should be trivial to 
> add it to other RT tasks, and have 100% as the default cpu limit. How 
> does that sound?

Sounds good.-)
The kernel should have 100% limit (disable) as default. Users and
distros can change it to a sane value for there needs.


