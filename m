Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVA1IlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVA1IlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 03:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVA1IlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 03:41:06 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5540 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261200AbVA1IlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 03:41:01 -0500
Date: Fri, 28 Jan 2005 09:40:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050128084049.GA5004@elte.hu>
References: <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <20050128080802.GA2860@elte.hu> <871xc62bot.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871xc62bot.fsf@sulphur.joq.us>
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


* Jack O'Quin <joq@io.com> wrote:

> > i'm wondering, couldnt Jackd solve this whole issue completely in
> > user-space, via a simple setuid-root wrapper app that does nothing else
> > but validates whether the user is in the 'jackd' group and then keeps a
> > pipe open to to the real jackd process which it forks off, deprivileges
> > and exec()s? Then unprivileged jackd could request RT-priority changes
> > via that pipe in a straightforward way. Jack normally gets installed as
> > root/admin anyway, so it's not like this couldnt be done.
> 
> Perhaps.
> 
> Until recently, that didn't work because of the longstanding rlimits
> bug in mlockall().  For scheduling only, it might be possible.
> 
> Of course, this violates your requirement that the user not be able to
> lock up the CPU for DoS.  The jackd watchdog is not perfect.

there is a legitimate fear that if it's made "too easy" to acquire some
sort of SCHED_FIFO priority, that an "arm's race" would begin between
desktop apps, each trying to set themselves to SCHED_FIFO (or SCHED_ISO)
and advising users to 'raise the limit if they see delays' - just to get
snappier than the rest.

thus after a couple of years we'd end up with lots of desktop apps
running as SCHED_FIFO, and latency would go down the drain again.

(yeah, this feels like going back to the drawing board.)

	Ingo
