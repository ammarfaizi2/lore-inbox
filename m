Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbULLXgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbULLXgr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 18:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbULLXgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 18:36:47 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:13530 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262171AbULLXgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 18:36:44 -0500
Message-ID: <41BCD5F3.80401@kolivas.org>
Date: Mon, 13 Dec 2004 10:36:19 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random>
In-Reply-To: <20041212222312.GN16322@dualathlon.random>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3B520E8B71A19D632037A9A8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3B520E8B71A19D632037A9A8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrea Arcangeli wrote:
> On Sun, Dec 12, 2004 at 05:35:47PM +0100, Pavel Machek wrote:
> 
>>It certainly helps with singing capacitors... What is overhead of
> 
> 
> ;)
> 
> 
>>this?
> 
> 
> The overhead is a single l1 cacheline in the paths manipulating HZ
> (rather than having an immediate value hardcoded in the asm, it reads it
> from a memory location not in the icache). Plus there are some
> conversion routines in the USER_HZ usages. It's not a measurable
> difference.

Just being devils advocate here...

I had variable Hz in my tree for a while and found there was one 
solitary purpose to setting Hz to 100; to silence cheap capacitors.

The rest of my users that were setting Hz to 100 for so-called 
performance gains were doing so under the false impression that cpu 
usage was lower simply because of the woefully inaccurate cpu usage 
calcuation at 100Hz.

The performance benefit, if any, is often lost in noise during 
benchmarks and when there, is less than 1%. So I was wondering if you 
had some specific advantage in mind for this patch? Is there some 
arch-specific advantage? I can certainly envision disadvantages to lower Hz.

Cheers,
Con

--------------enig3B520E8B71A19D632037A9A8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBvNX1ZUg7+tp6mRURAswIAJ9Pxcax4DC99KHdcHezY1GnHQpQdACfQVJV
E5rNKgwUROBBhhRWYMaOQKU=
=Nri+
-----END PGP SIGNATURE-----

--------------enig3B520E8B71A19D632037A9A8--
