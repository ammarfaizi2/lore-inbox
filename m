Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVAUXxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVAUXxV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVAUXwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:52:07 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:15233 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262610AbVAUXta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:49:30 -0500
Message-ID: <41F194DC.40603@kolivas.org>
Date: Sat, 22 Jan 2005 10:48:44 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: utz lehmann <lkml@s2y4n2c.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com, joq@io.com,
       CK Kernel <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>,
       alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt	scheduling
References: <41EEE1B1.9080909@kolivas.org> <1106350245.4442.5.camel@segv.aura.of.mankind>
In-Reply-To: <1106350245.4442.5.camel@segv.aura.of.mankind>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7C154CC08E28BD249F40E7CF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7C154CC08E28BD249F40E7CF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

utz lehmann wrote:
> Hi
> 
> I dislike the behavior of the SCHED_ISO patch that iso tasks are
> degraded to SCHED_NORMAL if they exceed the limit.
> IMHO it's better to throttle them at the iso_cpu limit.
> 
> I have modified Con's iso2 patch to do this. If iso_cpu > 50 iso tasks
> only get stalled for 1 tick (1ms on x86).

Some tasks are so cache intensive they would make almost no forward 
progress running for only 1ms.

> Fortunately there is a currently unused task prio (MAX_RT_PRIO-1) [1]. I

Your implementation is not correct. The "prio" field of real time tasks 
is determined by MAX_RT_PRIO-1-rt_priority. Therefore you're limiting 
the best real time priority, not the other way around.

Throttling them for only 1ms will make it very easy to starve the system 
  with 1 or more short running (<1ms) SCHED_NORMAL tasks running. Lower 
priority tasks will never run.

Cheers,
Con

--------------enig7C154CC08E28BD249F40E7CF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8ZTcZUg7+tp6mRURAqpnAJ4u/FCN9JnNKJx8hAIhkMy5AxNFNQCfc6lL
a0h+KMjsCv4IdCWjC3usfFA=
=Mvz8
-----END PGP SIGNATURE-----

--------------enig7C154CC08E28BD249F40E7CF--
