Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVANCoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVANCoh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 21:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVANCog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 21:44:36 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:15549 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261868AbVANCn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:43:26 -0500
Message-ID: <41E7319A.202@kolivas.org>
Date: Fri, 14 Jan 2005 13:42:34 +1100
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
References: <20050111214152.GA17943@devserv.devel.redhat.com>	 <200501112251.j0BMp9iZ006964@localhost.localdomain>	 <20050111150556.S10567@build.pdx.osdl.net> <87y8ezzake.fsf@sulphur.joq.us>	 <20050112074906.GB5735@devserv.devel.redhat.com>	 <87oefuma3c.fsf@sulphur.joq.us>	 <20050113072802.GB13195@devserv.devel.redhat.com>	 <878y6x9h2d.fsf@sulphur.joq.us>	 <20050113210750.GA22208@devserv.devel.redhat.com>	 <1105651508.3457.31.camel@krustophenia.net>	 <1105668319.15692.16.camel@segv.aura.of.mankind>	 <41E729A9.7060005@kolivas.org> <1105670137.15692.36.camel@segv.aura.of.mankind>
In-Reply-To: <1105670137.15692.36.camel@segv.aura.of.mankind>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2BFD32DE6B4184D4E8483B25"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2BFD32DE6B4184D4E8483B25
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

utz lehmann wrote:
> On Fri, 2005-01-14 at 13:08 +1100, Con Kolivas wrote:
> 
>>utz lehmann wrote:
>>>Just an idea. What about throttling runaway RT tasks?
>>>If the system spend more than 98% in RT tasks for 5s consider this as a
>>>_fatal error_. Print an error message and throttle RT tasks by inserting
>>>ticks where only SCHED_OTHER tasks allowed. For a limit of 98% this
>>>means one SCHED_OTHER only tick all 50 ticks.
>>>
>>>The limit and timeout should be configurable and of course it can be
>>>disabled.
>>>
>>>I know this is against RT task preempt all SCHED_OTHER but this is only
>>>for a fatal system state to be able to recover sanely. A locked up
>>>machine is is the worse alternative.
>>
>>There is a patch in -mm currently designed to use a sysrq key 
>>combination which converts all real time tasks to sched normal to save 
>>you if you desire in a lockup situation. We do want to preserve RT 
>>scheduling behaviour at all times without caveats for privileged users.
> 
> 
> The sysrq is already in 2.6.10. I had to use it the last days a few
> times. But it does help if you have no access to the console.
> 
> The RT throttling idea is not to change the behavior in normal
> conditions. It's only for a fatal system state. If you have a runaway RT
> task you can't guarantee the system is work properly anyway. It's
> blocking vital kernel threads, filesystems, swap, keyboard, ...

I understand fully your concern. If such a thing were to be introduced 
it would have to be disabled by default. Since I'm looking at 
implementing such throttling for user RT tasks, it should be trivial to 
add it to other RT tasks, and have 100% as the default cpu limit. How 
does that sound?

> It's a bit like out of memory. You can do nothing and panic. Or trying
> something bad (killing processes) which is hopefully better as the
> former.
> btw: Are RT tasks excluded by the oom killer?

I haven't looked. VM hackers?

Con

--------------enig2BFD32DE6B4184D4E8483B25
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5zGaZUg7+tp6mRURAmoQAJ0bW9hFeGMqwVo2ahY2SEOLjAIIygCfWjBu
/TctjdOsr/2RE8xoYPFTpoo=
=4v4v
-----END PGP SIGNATURE-----

--------------enig2BFD32DE6B4184D4E8483B25--
