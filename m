Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVA0ChB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVA0ChB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVA0Cd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 21:33:58 -0500
Received: from mail.joq.us ([67.65.12.105]:4060 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261981AbVA0C37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 21:29:59 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	<20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
	<87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu>
	<87fz0neshg.fsf@sulphur.joq.us>
	<1106782165.5158.15.camel@npiggin-nld.site>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 26 Jan 2005 20:31:25 -0600
In-Reply-To: <1106782165.5158.15.camel@npiggin-nld.site> (Nick Piggin's
 message of "Thu, 27 Jan 2005 10:29:25 +1100")
Message-ID: <874qh3bo1u.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:

> I'm a bit concerned about this kind of policy and breakage of
> userspace APIs going into the kernel. I mean, if an app is
> succeeds in gaining SCHED_FIFO / SCHED_RR scheduling, and the
> scheduler does something else, that could be undesirable in some
> situations.

True.  It's similar to running out of CPU bandwidth, but not quite.

AFAICT, the new behavior still meets the letter of the standard[1].
Whether it meets the spirit of the standard is debatable.  My own
feeling is that it probably does, and that making SCHED_FIFO somewhat
less powerful but much easier to access is a reasonable tradeoff.

 [1] http://www.opengroup.org/onlinepubs/007908799/xsh/realtime.html

If I understand Ingo's proposal correctly, setting RLIMIT_RT_CPU to
zero and then requesting SCHED_FIFO (with CAP_SYS_NICE) yields exactly
the former behavior.  This will probably be the default setting.

> Secondly, I think we should agree upon and get the basic rlimit
> support in ASAP, so the userspace aspect can be firmed up a bit
> for people like Paul and Jack (this wouldn't preclude further
> work from happening in the scheduler afterwards).

I don't sense much opposition to adding rlimit support for realtime
scheduling.  I personally don't think it a very good way to manage
this problem.  But, it certainly can be made to work.

The main point of discussion is: exactly what resource should it
limit?  Arjan and Chris proposed to limit priority.  Ingo proposed to
limit the percentage of each CPU available for realtime threads
(collectively).  Either would meet our minimum needs (AFAICT).

But, they are not identical, and the best choice depends at least
partly on the outcome of Ingo's scheduler experiments.  I doubt that
anyone wants to add both (though it could come down to that, I
suppose).

> And finally, with rlimit support, is there any reason why lockup
> detection and correction can't go into userspace? Even RT
> throttling could probably be done in a userspace daemon.

It can.  But, doing it in the kernel is more efficient, and probably
more reliable.
-- 
  joq
