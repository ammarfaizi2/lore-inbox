Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263234AbUKBNDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbUKBNDK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 08:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbUKBNDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:03:09 -0500
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:2969 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263618AbUKBNCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:02:30 -0500
Message-ID: <4187854C.6000803@kolivas.org>
Date: Wed, 03 Nov 2004 00:02:04 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] optional non-interactive mode for cpu scheduler
References: <41871BA7.6070300@kolivas.org> <20041102125218.GH15290@elte.hu>
In-Reply-To: <20041102125218.GH15290@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig938555BCFD0B673CC092E197"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig938555BCFD0B673CC092E197
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> 
>>optional non-interactive mode for cpu scheduler
> 
> 
> i think the following scheme would work better:
> 
>  - introduce a new SCHED_CPUBOUND policy
>  - return ->static_prio + 5 for such tasks
>  - keep their timeslice based off ->static_prio
> 
> the point is this: such tasks would thus be automatically and
> perpetually considered 'CPU hogs'. Applications cannot abuse this
> mechanism because they get the maximum 'penalty'.
> 
> and as a bonus, no magic sysctl and inherently more flexibility.
> 
> (note that this scheme has advantages above nice +5 because nice +5
> still has the interactivity stuff on which can create priority
> fluctuations and may thus affect workloads.)
> 
> if you agree with this scheme, would you be interested in implementing
> this?

The better cpu proportion guarantee without low latency of such a policy 
would be desirable to video encoding in the background while capturing 
in the foreground as one immediately recognisable purpose, and there are 
likely numerous others, so I agree it's a good idea.

However the non-interactive mode addresses a number of different needs 
that seem to have come up. Specifically:
I have had users report great success with such a mode on my own 
scheduler in multiple X session setups where very choppy behaviour 
occurs in mainline.
Many high performance computing people do not wish interactivity code 
modifying their choice of latency/distribution - admittedly this is a 
soft one.

What are your thoughts on this?

Con

--------------enig938555BCFD0B673CC092E197
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBh4VMZUg7+tp6mRURAsw9AKCPj1uJs2swoHO/8e264ZqOMEjLuwCcCzok
Wmy51ANe2qGFNbQPZofimww=
=x4a8
-----END PGP SIGNATURE-----

--------------enig938555BCFD0B673CC092E197--
