Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVAHFiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVAHFiR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 00:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVAHFiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 00:38:17 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:61336 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261790AbVAHFiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:38:02 -0500
Message-ID: <41DF7179.20401@kolivas.org>
Date: Sat, 08 Jan 2005 16:36:57 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050107153328.GD28466@devserv.devel.redhat.com>	<200501071541.j07FfeQC018553@localhost.localdomain>	<20050107160350.GB29327@devserv.devel.redhat.com> <s5hbrc1w6rq.wl@alsa2.suse.de>
In-Reply-To: <s5hbrc1w6rq.wl@alsa2.suse.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7EA41A00C142D7F40711CFE2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7EA41A00C142D7F40711CFE2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Fri, 7 Jan 2005 17:03:51 +0100,
> Arjan van de Ven wrote:
>>something like a soft realtime flag that acts as if it's the hard realtime
>>one unless the app shows "misbehavior" (eg eats its timeslice for X times in
>>a row) might for example be such a solution. And with the anti abuse
>>protection it can run with far lighter privilegs.
> 
> 
> This reminds me about the soft-RT patch posted quite sometime ago.
> I feel such a handy psuedo-RT scheduler class would be useful for
> other systems than JACK, too...

You've already proven that soft RT does not suit your requirements. The 
current scheduler running a task at nice -20 has extremely long periods 
of cpu availability at the expense of lower priority tasks and is close 
to the behaviour you would get with a soft RT patch. Your concern is 
exactly the scenario where nice -20 fails, and would be the same 
scenario where a soft RT policy would fail. Doing this with a scheduling 
policy, you want cpu time long after there is any hope for fairness or 
safety of hanging. From experimentation with such soft RT policies, we 
find average latencies can be reduced but the maximum ones, which are 
the ones that concern professional audio, remain the same.

Cheers,
Con

--------------enig7EA41A00C142D7F40711CFE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB33F7ZUg7+tp6mRURAtuhAJ92OZB00mcbbiPGsZX/t2qaEm8aIwCglGAp
qoiw0x+0vUdbdIrEWu1+AEA=
=XDFH
-----END PGP SIGNATURE-----

--------------enig7EA41A00C142D7F40711CFE2--
