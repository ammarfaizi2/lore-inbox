Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265659AbVBDQkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbVBDQkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 11:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265485AbVBDQkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 11:40:47 -0500
Received: from mail.joq.us ([67.65.12.105]:38632 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S266024AbVBDQkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 11:40:31 -0500
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <200502031420.j13EKwFx005545@localhost.localdomain>
	<42029C23.1000300@bigpond.net.au>
From: "Jack O'Quin" <joq@io.com>
Date: Fri, 04 Feb 2005 10:41:15 -0600
In-Reply-To: <42029C23.1000300@bigpond.net.au> (Peter Williams's message of
 "Fri, 04 Feb 2005 08:48:19 +1100")
Message-ID: <87u0oscm6s.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> writes:

> Paul Davis wrote:
>> There are several kernel-side attributes that would make JACK better
>> from my perspective:
>> 	* better ways to acquire and release RT scheduling
>
> I'm no expert on the topic but it would seem to me that the mechanisms
> associated with the capable() function are intended to provide a
> consistent and extensible interface to the control of privileged
> operations with possible finer grained control than "root 'yes' and
> everybody else 'no'".  Maybe the way to solve this problem is to
> modify the interpretation of capable(CAP_SYS_NICE) so that it returns
> true when invoked by a task setuid to a nominated uid in addition to
> zero?

That is essentially what the RT-LSM does.  At exec() time RT-LSM turns
on CAP_SYS_NICE for appropriate process images.

In the current implementation this is only done per-group not
per-user.  Adding UID as well as GID granularity should be easy.  We
didn't do it because we didn't really need it.  If there's a use for
it, I have no objection to adding it.  It could even compatibly be
added later.

Many distributions require users to join group `audio' anyway to gain
access to the sound card.  We found it convenient to piggy-back on
that mechanism.

I believe Paul considers this adequate for his requirements.  :-)
-- 
  joq
