Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVAYOHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVAYOHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVAYOHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:07:24 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:53914 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261947AbVAYOHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:07:16 -0500
Message-ID: <41F6524F.3090004@kolivas.org>
Date: Wed, 26 Jan 2005 01:06:07 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
In-Reply-To: <20050125135613.GA18650@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig94AAB73C18EAE197C551ECE6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig94AAB73C18EAE197C551ECE6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> pretty much the only criticism of the RT-CPU patch was that the global
> sysctl is too rigid and that it doesnt allow privileged tasks to ignore
> the limit. I've uploaded a new RT-CPU-limit patch that solves this
> problem:
> 
>   http://redhat.com/~mingo/rt-limit-patches/
> 
> i've removed the global sysctl and implemented a new rlimit,
> RT_CPU_RATIO: the maximum amount of CPU time RT tasks may use, in
> percent. For testing purposes it defaults to 80%.
> 
> the RT-limit being an rlimit makes it much more configurable: root tasks
> can have unlimited CPU time limit, while users could have a more
> conservative setting of say 30%. This also makes it per-process and
> runtime configurable as well. The scheduler will instantly act upon any
> new RT_CPU_RATIO rlimit.
> 
> (this approach is fundamentally different from the previous patch that
> made the "maximum RT-priority available to an unprivileged task" value
> an rlimit - with priorities being an rlimit we still havent made RT
> priorities safe against deadlocks.)
> 
> multiple tasks can have different rlimits as well, and the scheduler
> interprets it the following way: it maintains a per-CPU "RT CPU use"
> load-average value and compares it against the per-task rlimit. If e.g. 
> the task says "i'm in the 60% range" and the current average is 70%,
> then the scheduler delays this RT task - if the next task has an 80%
> rlimit then it will be allowed to run. This logic is straightforward and
> can be used as a further control mechanism against runaway highprio RT
> tasks.

Very nice. I like the way this approach is evolving.

Cheers,
Con

--------------enig94AAB73C18EAE197C551ECE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9lJSZUg7+tp6mRURAmzDAJ0eGhgloTIsl4MlDStAoxAzR4NPhgCglLl9
t3vJdFbuFoFuHmny/a1W5T4=
=Pu0W
-----END PGP SIGNATURE-----

--------------enig94AAB73C18EAE197C551ECE6--
