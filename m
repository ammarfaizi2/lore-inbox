Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVANDOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVANDOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVANDOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:14:43 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:2710 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261878AbVANC5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:57:50 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: utz lehmann <lkml@s2y4n2c.de>, Lee Revell <rlrevell@joe-job.com>,
       Arjan van de Ven <arjanv@redhat.com>, "Jack O'Quin" <joq@io.com>,
       Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       LKML <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <200501140240.j0E2esKG026962@localhost.localdomain>
References: <200501140240.j0E2esKG026962@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 13:57:44 +1100
Message-Id: <1105671464.5402.49.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 21:40 -0500, Paul Davis wrote:
> >SCHED_FIFO and SCHED_RR are definitely privileged operations and you
> 
> this is the crux of what this whole debate is about. for all of you
> people who think about linux on multi-user systems with network
> connectivity, running servers and so forth, this is clearly a given.
> 
> but there is large and growing body of machines that run linux where
> the sole human user of the machine has a strong and overwhelming
> desire to have tasks run with the characteristics offered by
> SCHED_FIFO and/or SCHED_RR. are they still "privileged" operations on
> this class of linux system? what about linux installed on an embedded
> system, with a small LCD screen and the sole purpose of running audio
> apps live? are they still privileged then?
> 

I think yes, because their misuse can trivially take down the
machine by definition. So it is still privileged in the context
of that system.

> i think there is room for debate, but its clear that in general,
> SCHED_FIFO/SCHED_RR's "definite" status as privileged operations is
> not clear. we are trying to find ways to provide access to it in ways
> that don't conflict with the other categories of linux systems where
> it clearly needs to be off-limits to unprivileged users.
> 

In such a system, sure you could make allowances by elevating
privileges or what have you.

I guess the tricky part is exactly how to make these allowances. I've
joined the thread too late (and don't have the knowledge) to really get
into that... but I just wanted to be clear that watering down SCHED_RR
and SCHED_FIFO basically just makes them no good to anyone.

I personally can't see how a scheduling policy can allow deterministic
access to the CPU without being a privileged operation. If you don't
need deterministic access to the scheduler, then let's talk about why
SCHED_OTHER isn't good enough. If you do, then we're talking about
security access I think.

Nick


http://mobile.yahoo.com.au - Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
