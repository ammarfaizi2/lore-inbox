Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVANVLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVANVLk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVANVJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:09:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48603 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262169AbVANVHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:07:44 -0500
Message-ID: <41E833F4.8090800@redhat.com>
Date: Fri, 14 Jan 2005 13:04:52 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: short read from /dev/urandom
References: <41E7509E.4030802@redhat.com> <20050114191056.GB17481@thunk.org>
In-Reply-To: <20050114191056.GB17481@thunk.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0B40E8DA58C5C1E721BBF375"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B40E8DA58C5C1E721BBF375
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Theodore Ts'o wrote:
> What do you think?  Does gcc -pg calls sigaction with SA_RESTART, to
> avoid changing the behaviour of the programs that it is profiling?

Profiling certainly uses SA_RESTART.  But this was just one possible 
problem case.

I'm concerned that there is isgnificant code out there relying on the 
no-short-read promise.  And perhaps more importantly, other 
implementations promise the same.

The code in question comes from a crypto library which is in wide use 
(http://www.cryptopp.com) and it is using urandom under this assumption. 
  I fear there is quite a bit more code like this out there.  Changing 
the ABI after the fact is no good and dangerous in this case.

I know this is making the device special, but I really think the 
no-short-reads property should be perserved for urandom.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖

--------------enig0B40E8DA58C5C1E721BBF375
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFB6DP12ijCOnn/RHQRArhGAKCntucrVd6mrfqVbZX7ERKHevasYQCgsZ3c
i7a3WS+dsthMNyZsCTm17sI=
=1Ofs
-----END PGP SIGNATURE-----

--------------enig0B40E8DA58C5C1E721BBF375--
