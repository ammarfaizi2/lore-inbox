Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUFESPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUFESPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 14:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUFESPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 14:15:15 -0400
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:40368 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S261851AbUFESPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 14:15:06 -0400
Message-ID: <40C1DB59.7090507@sci.fi>
Date: Sat, 05 Jun 2004 17:40:25 +0300
From: =?UTF-8?B?TGFzc2UgS8Okcmtrw6RpbmVuIC8gVHJvbmlj?= <tronic2@sci.fi>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040314)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Some thoughts about cache and swap
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig01DE1F373C336BC6161B51B5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig01DE1F373C336BC6161B51B5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

One thing where most current cache/swap implementations seem to fail 
miserably is when user - for some reason - processes large amounts of 
data. This may be as simple as listening large MP3 collection for few 
hours (having very large working set, and pushing everything else out of 
RAM, replacing that with cached songs).

Incidentally, in such cases, swapping the content is usually complete 
waste, as it is unlikely that the same data is needed again, or if it 
actually is required, the speed may not be any kind of issue.

In order to make better use of the limited cache space, the following 
methods could be used:

1. highly preferable to cache small files only
  * big seek latency of disk/net access, small RAM usage of caching
  * applications with long loading times usually use big number of tiny
    files => caching those makes response times a lot better
  * higher probability of getting more hits (per consumed cache space)

1.1. if caching large files anyway
  * try to detect access type (sequential, highly spatial or random)
  * only cache the hottest parts of the file

2. only cache files where I/O is the bottle neck
  * if applications typically don't need the data faster, having it in
    cache isn't very useful either
  * detecting whether I/O is a limiting factor is difficult

Additionally, for machines with oversized RAM (like nearly all 
desktop/server computers):

3. never (or only rarely) swap out applications for more cache
  * eventually it will be restored to RAM and the user will notice
    major trashing with long delays, and blame the OS
  * applications only take small portion of the RAM and using that
    as extra cache makes only small difference in cache performance
  * if application or its data has been loaded to memory, there normally
    is a reason for that (i.e. the data needs to be accessed quickly)

3.1. memory leaks are exception (but maybe fixing the bug would be 
correct solution instead of obscuring the problem by swapping it out)

Definition of large file changes over time, as technology evolves
  * size of RAM (and thus the available cache space)
  * reading one megaoctet or doing single seek on modern HDD each consume
    roughly the same time - about 13 ms (notice how evil seeking is!)

- Tronic -


--------------enig01DE1F373C336BC6161B51B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAwdtZOBbAI1NE8/ERAv13AJ0RWLo1ZN2ybte26Q9FzamwDjwYcACdG07S
bCxOjfcMvo3d/Kyc7MBFCbI=
=7w13
-----END PGP SIGNATURE-----

--------------enig01DE1F373C336BC6161B51B5--
