Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbTFSSRL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 14:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265881AbTFSSRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 14:17:11 -0400
Received: from fmr02.intel.com ([192.55.52.25]:43230 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S265878AbTFSSRK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 14:17:10 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780E04087F@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Robert Love'" <rml@tech9.net>
Cc: "'Ingo Molnar'" <mingo@elte.hu>, "'Andrew Morton'" <akpm@digeo.com>,
       "'george anzinger'" <george@mvista.com>,
       "'joe.korty@ccur.com'" <joe.korty@ccur.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Li, Adam" <adam.li@intel.com>
Subject: RE: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
	 sks
Date: Thu, 19 Jun 2003 11:31:03 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Robert Love [mailto:rml@tech9.net]
> On Wed, 2003-06-18 at 23:52, Perez-Gonzalez, Inaky wrote:
> 
> > Then some output would show on my serial console when events/0 is
> > reprioritized...
> >
> > OTOH, what do you think of Robert's idea of adding 20 levels of
> > priorities for the kernel's sole use?
> 
> That was your idea, I just said the infrastructure was in place and we
> could do it ;-)

I stand corrected (Man! I should really have my fingers typing 
after my brain thinks it).

> I am not so sure it is ideal. I hesitate to make kernel threads FIFO at
> a maximum priority, let alone an even greater one. I would really prefer
> to find a nicer solution. Anyhow, if we make events FIFO/99 that would
> also solve the problem, without dipping into extra high levels.

I don't think is ideal either, but it is the only way I see where we
can make sure that no user thread is going to stomp over the kernel
toes and cause a deadlock (this is a extreme, but it can happen). If
by default we ship all the kernel threads at higher priority than
anything that the user can do, we avoid this problem (of course, some
are going to be a no-no, so we default them to OTHER -20), but the 
most common ones to cause trouble, like the migration thread, keventd
and some else might benefit from this.

Then, being then the user/sysadmin/designer able to tweak them 
up or down at will could fix many potential issues with this.

(eg: customer who has decided his applications are real-time,
and thus have to be made SCHED_FIFO/50 and without any warning or 
possible cause, they are deadlocking while on some other systems
they work flawlessly ... )

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)

