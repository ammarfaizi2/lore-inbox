Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVARPzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVARPzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVARPyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:54:38 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:55719 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261338AbVARPxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:53:36 -0500
Message-ID: <41ED30EB.4090904@kolivas.org>
Date: Wed, 19 Jan 2005 02:53:15 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hihone@bigpond.net.au
Cc: linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>,
       joq@io.com, rlrevell@joe-job.com, paul@linuxaudiosystems.com
Subject: Re: [ck] [PATCH][RFC] sched: Isochronous class for unprivileged soft
 rt	scheduling
References: <41ED08AB.5060308@kolivas.org> <41ED2F1F.1080905@bigpond.net.au>
In-Reply-To: <41ED2F1F.1080905@bigpond.net.au>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6B890D5DB94B39B404EFEA56"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B890D5DB94B39B404EFEA56
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Cal wrote:
> Con Kolivas wrote:
> 
>> Comments and testing welcome.
> 
> 
> There's a collection of test summaries from jack_test3.2 runs at
> <http://www.graggrag.com/ck-tests/ck-tests-0501182249.txt>
> 
> Tests were run with iso_cpu at 70, 90, 99, 100, each test was run twice. 
> The discrepancies between consecutive runs (with same parameters) is 
> puzzling.  Also recorded were tests with SCHED_FIFO and SCHED_RR.
> 
> Before drawing any hardball conclusions, verification of the results 
> would be nice. At first glance, it does seem that we still have that 
> fateful gap between "harm minimisation" (policy) and "zero tolerance" 
> (audio reality requirement).

Thanks.

SCHED_ISO
/proc/sys/kernel/iso_cpu . . .: 70
/proc/sys/kernel/iso_period . : 5
XRUN Count  . . . . . . . . . :   110

vs

SCHED_FIFO
XRUN Count  . . . . . . . . . :   114
XRUN Count  . . . . . . . . . :   187

vs

SCHED_RR
XRUN Count  . . . . . . . . . :     0
XRUN Count  . . . . . . . . . :     0

Something funny going on here... You had more xruns with SCHED_FIFO than 
the default SCHED_ISO settings, and had none with SCHED_RR. Even in the 
absence of the SCHED_ISO results, the other results dont make a lot of 
sense.

Con

P.S. If you're running on SMP it may be worth booting on UP or using cpu 
affinity (schedtool -a 0x1 will bind you to 1st cpu only) and see what 
effect that is having. There are some interesting things that can 
adversely affect latency on SMP.

--------------enig6B890D5DB94B39B404EFEA56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7TDrZUg7+tp6mRURAgefAJwN2iKVNMTzIPf39nroQV9Lh3tXiQCdE+kO
RgeSQRkEZzZdNYGhvA8QZg4=
=PbEl
-----END PGP SIGNATURE-----

--------------enig6B890D5DB94B39B404EFEA56--
