Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVA1Ief@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVA1Ief (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 03:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVA1Ief
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 03:34:35 -0500
Received: from mail.joq.us ([67.65.12.105]:58036 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261199AbVA1Ied (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 03:34:33 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	<20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
	<87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu>
	<87fz0neshg.fsf@sulphur.joq.us>
	<1106782165.5158.15.camel@npiggin-nld.site>
	<20050128080802.GA2860@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Fri, 28 Jan 2005 02:35:30 -0600
In-Reply-To: <20050128080802.GA2860@elte.hu> (Ingo Molnar's message of "Fri,
 28 Jan 2005 09:08:02 +0100")
Message-ID: <871xc62bot.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>> And finally, with rlimit support, is there any reason why lockup
>> detection and correction can't go into userspace? Even RT throttling
>> could probably be done in a userspace daemon.
>
> that is correct. Jackd already has a watchdog thread, against lockups.
>
> i'm wondering, couldnt Jackd solve this whole issue completely in
> user-space, via a simple setuid-root wrapper app that does nothing else
> but validates whether the user is in the 'jackd' group and then keeps a
> pipe open to to the real jackd process which it forks off, deprivileges
> and exec()s? Then unprivileged jackd could request RT-priority changes
> via that pipe in a straightforward way. Jack normally gets installed as
> root/admin anyway, so it's not like this couldnt be done.

Perhaps.

Until recently, that didn't work because of the longstanding rlimits
bug in mlockall().  For scheduling only, it might be possible.

Of course, this violates your requirement that the user not be able to
lock up the CPU for DoS.  The jackd watchdog is not perfect.
-- 
  joq
