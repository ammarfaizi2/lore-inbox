Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVHWU5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVHWU5p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVHWU5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:57:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17866 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750729AbVHWU5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:57:44 -0400
Message-ID: <430B8D96.5080002@redhat.com>
Date: Tue, 23 Aug 2005 13:56:54 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird 1.0.6-3 (X11/20050806)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: mremap() use is racy
References: <430B7EAE.6020001@redhat.com> <Pine.LNX.4.61.0508232135480.12189@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508232135480.12189@goblin.wat.veritas.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig27BFFC33DBE8839915DF4FB1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig27BFFC33DBE8839915DF4FB1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hugh Dickins wrote:
> If the app can plan ahead as you're proposing, why doesn't it just
> mmap the maximum it might need, mprotect PROT_NONE the end it doesn't
> need yet, then progressively re-mprotect parts to make them accessible
> as needed?

Because the underlying file isn't larger than the initial mapping.  In
the one case I'm working on now the file can grow over time.  More data
is added at the end but the mapping cannot move in the address space.

Using mmap with a too-large size for the underlying file and then hoping
that future file growth is magically handled when those pages are
accessed is not valid.


> I'm missing what mremap gives you here that mprotect doesn't.  Though
> I do see that it would be nice not to be forced into mremap moving
> all the time, because of other maps blocking you off: nice perhaps
> to know what region of the layout is least likely to be so affected.

Just accept here that moving is not an option.  If remap cannot be used
then a complete new mmap() with adjusted length is needed.  That is
unnecessarily expensive.  It is the reason why there is mremap().  But
mremap() with MREMAP_MAYMOVE is unreliable as it is implemented today.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig27BFFC33DBE8839915DF4FB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDC42W2ijCOnn/RHQRAsPhAJkB41ChL+7z7Sdldw1sWiIngQcofACeNiLV
hmXeTHLiOizJYGtgu7yCBGo=
=NJSI
-----END PGP SIGNATURE-----

--------------enig27BFFC33DBE8839915DF4FB1--
