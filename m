Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbUL2U2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbUL2U2v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 15:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUL2U2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 15:28:51 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:55780 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261409AbUL2U2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 15:28:48 -0500
Message-ID: <41D31373.1090801@kolivas.org>
Date: Thu, 30 Dec 2004 07:28:35 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trying out SCHED_BATCH
References: <m3mzw262cu.fsf@rajsekar.pc> <41CD51E6.1070105@kolivas.org> <04ef01c4ede2$ff4a7cc0$0e25fe0a@pysiak>
In-Reply-To: <04ef01c4ede2$ff4a7cc0$0e25fe0a@pysiak>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig43FAB361B4D4546D6CD4C632"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig43FAB361B4D4546D6CD4C632
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Maciej Soltysiak wrote:
> Hi
> 
> Con wrote:
> 
>> Only the staircase scheduler currently has an implementation of
>> sched_batch and you need 2 more patches on top of the staircase patch
>> for it to work.
> 
> Hmm, Is it feasable to write a sched_batch policy for the current linux 
> schedulers?

Yes.

The proper way to make a sched_batch implementation is more 
comprehensive than what is made for staircase to prevent a deadlock 
based on a batch task getting an important lock in the kernel and not 
being able to release it due to a sched_normal task being higher 
priority than it that is actually trying to get the lock. There is code 
in the staircase version to prevent this from happening but probably not 
complete enough in design to prevent everything. However it works and I 
haven't had any reports of lockups since I implemented the extra checking.

Would you like me to create a version like that? I don't have the time 
to try and make a more comprehensive solution and follow the debugging 
of such a beast.

 > I mean, if there are people that want it bad, maybe it would be nice to
 > be able
 > to use a version of sched_batch that would work without the staircase
 > scheduler.
 > It is still experimental, right?

No it's not experimental. It is very stable and used in production systems.

Con

--------------enig43FAB361B4D4546D6CD4C632
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB0xNzZUg7+tp6mRURAmcOAJ96ayLjjDzP5dsebOICwD0T7hR/9QCbBPV4
g6Nq3sFjEbMLnNGWA7Eaoww=
=iqHQ
-----END PGP SIGNATURE-----

--------------enig43FAB361B4D4546D6CD4C632--
