Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVA1IIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVA1IIW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 03:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVA1IIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 03:08:22 -0500
Received: from mx2.elte.hu ([157.181.151.9]:65182 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261505AbVA1IIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 03:08:20 -0500
Date: Fri, 28 Jan 2005 09:08:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050128080802.GA2860@elte.hu>
References: <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106782165.5158.15.camel@npiggin-nld.site>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> And finally, with rlimit support, is there any reason why lockup
> detection and correction can't go into userspace? Even RT throttling
> could probably be done in a userspace daemon.

that is correct. Jackd already has a watchdog thread, against lockups.

i'm wondering, couldnt Jackd solve this whole issue completely in
user-space, via a simple setuid-root wrapper app that does nothing else
but validates whether the user is in the 'jackd' group and then keeps a
pipe open to to the real jackd process which it forks off, deprivileges
and exec()s? Then unprivileged jackd could request RT-priority changes
via that pipe in a straightforward way. Jack normally gets installed as
root/admin anyway, so it's not like this couldnt be done.

	Ingo
