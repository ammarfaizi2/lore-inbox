Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbUKBOC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbUKBOC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUKBOAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:00:36 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:60558 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261237AbUKBNkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:40:41 -0500
Message-ID: <41878E47.5090805@kolivas.org>
Date: Wed, 03 Nov 2004 00:40:23 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] optional non-interactive mode for cpu scheduler
References: <41871BA7.6070300@kolivas.org> <20041102125218.GH15290@elte.hu> <4187854C.6000803@kolivas.org> <20041102131105.GA17535@elte.hu>
In-Reply-To: <20041102131105.GA17535@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig876D3A8CC5895CEC0E591A27"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig876D3A8CC5895CEC0E591A27
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> 
>>However the non-interactive mode addresses a number of different needs 
>>that seem to have come up. Specifically:
>>I have had users report great success with such a mode on my own 
>>scheduler in multiple X session setups where very choppy behaviour 
>>occurs in mainline.
> 
> 
> since SCHED_CPUBOUND would be inherited across fork(), it should be
> rather easy to start an X session with all tasks as SCHED_CPUBOUND.
> 
> but i think the above rather points in the direction of some genuine
> weakness in the interactivity code (i know, for which the fix is
> staircase ;) which would be nice to debug.

Heh I wasnt implying we should move to staircase to fix our problems 
(then I'd have nothing special for -ck would I?). I was simply trying to 
reproduce that behaviour with a similar mode. As for the choppiness, the 
reports were that it would go away if X was run nice+19 which implies no 
dynamic priority adjustment was the answer.

>>Many high performance computing people do not wish interactivity code
>>modifying their choice of latency/distribution - admittedly this is a
>>soft one.
> 
> 
> well, SCHED_CPUBOUND would solve their needs too, right?

Assuming they wanted to run everything SCHED_CPUBOUND, yes.

Your solution has quite some merit to it :)

I'll look into coding it later this week (thanks for suggesting I do it 
btw). This ordeal has left me seriously sleep deprived :P

Since we're considering providing a special cpu policy for high latency 
high cpu usage, does that mean we can now talk about other policies like 
batch, isochronous etc? And in the medium to long term future, gang and 
group?

Regards,
Con

--------------enig876D3A8CC5895CEC0E591A27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBh45HZUg7+tp6mRURAglCAJ0WwOvo/uyzyvMB4N21Bu8hNsXZAQCeNuci
r60OevYKBL/IU9pyPPM9dOs=
=O46K
-----END PGP SIGNATURE-----

--------------enig876D3A8CC5895CEC0E591A27--
