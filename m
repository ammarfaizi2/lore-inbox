Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVANCJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVANCJx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 21:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVANCJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 21:09:53 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:20642 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261496AbVANCJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:09:49 -0500
Message-ID: <41E729A9.7060005@kolivas.org>
Date: Fri, 14 Jan 2005 13:08:41 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: utz lehmann <lkml@s2y4n2c.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Arjan van de Ven <arjanv@redhat.com>,
       "Jack O'Quin" <joq@io.com>, Chris Wright <chrisw@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050111214152.GA17943@devserv.devel.redhat.com>	 <200501112251.j0BMp9iZ006964@localhost.localdomain>	 <20050111150556.S10567@build.pdx.osdl.net> <87y8ezzake.fsf@sulphur.joq.us>	 <20050112074906.GB5735@devserv.devel.redhat.com>	 <87oefuma3c.fsf@sulphur.joq.us>	 <20050113072802.GB13195@devserv.devel.redhat.com>	 <878y6x9h2d.fsf@sulphur.joq.us>	 <20050113210750.GA22208@devserv.devel.redhat.com>	 <1105651508.3457.31.camel@krustophenia.net> <1105668319.15692.16.camel@segv.aura.of.mankind>
In-Reply-To: <1105668319.15692.16.camel@segv.aura.of.mankind>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig94FB90EAA6D93E44AA697A81"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig94FB90EAA6D93E44AA697A81
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

utz lehmann wrote:
> On Thu, 2005-01-13 at 16:25 -0500, Lee Revell wrote:
> 
>>On Thu, 2005-01-13 at 22:07 +0100, Arjan van de Ven wrote:
>>
>>>On Thu, Jan 13, 2005 at 03:04:26PM -0600, Jack O'Quin wrote:
>>>
>>>>(Probably, this simplistic analysis misses some other, more subtle,
>>>>factors.)
>>>
>>>I think you can do nasty things to the locks held by those threads too
>>>
>>>
>>>>RT threads should not do FS writes of their own.  But, a badly broken
>>>>or malicious one could, I suppose.  So, that might provide a mechanism
>>>>for losing more data than usual.  Is that what you had in mind?
>>>
>>>basically yes.
>>>note that "FS writes" can come from various things, including library calls
>>>made and such. But I think you got my point; even though it might seem a bit
>>>theoretical it sure is unpleasant.
>>>
>>
>>I added Con to the cc: because this thread is starting to converge with
>>an email discussion we've been having.
>>
>>The basic issue is that the current semantics of SCHED_FIFO seem make
>>the deadlock/data corruption due to runaway RT thread issue difficult.
>>The obvious solution is a new scheduling class equivalent to SCHED_FIFO
>>but with a mechanism for the kernel to demote the offending thread to
>>SCHED_OTHER in an emergency.  The problem can be solved in userspace
>>with a SCHED_FIFO watchdog thread that runs at a higher RT priority than
>>all other RT processes.
>>
>>This all seems to imply that introducing an rlimit for MAX_RT_PRIO is an
>>excellent solution.  The RT watchdog thread could run as root, and the
>>rlimit would be used to ensure than even nonroot users in the RT group
>>could never preempt the watchdog thread.
> 
> 
> Just an idea. What about throttling runaway RT tasks?
> If the system spend more than 98% in RT tasks for 5s consider this as a
> _fatal error_. Print an error message and throttle RT tasks by inserting
> ticks where only SCHED_OTHER tasks allowed. For a limit of 98% this
> means one SCHED_OTHER only tick all 50 ticks.
> 
> The limit and timeout should be configurable and of course it can be
> disabled.
> 
> I know this is against RT task preempt all SCHED_OTHER but this is only
> for a fatal system state to be able to recover sanely. A locked up
> machine is is the worse alternative.

There is a patch in -mm currently designed to use a sysrq key 
combination which converts all real time tasks to sched normal to save 
you if you desire in a lockup situation. We do want to preserve RT 
scheduling behaviour at all times without caveats for privileged users.

Cheers,
Con

--------------enig94FB90EAA6D93E44AA697A81
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5ympZUg7+tp6mRURAs76AJ0Xm4RfCdZvc67RJaC9foze9+JkMACeJoQl
zj5uuMuypVwZVZhwa0XoSDM=
=GELB
-----END PGP SIGNATURE-----

--------------enig94FB90EAA6D93E44AA697A81--
