Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbUCHV35 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUCHV3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:29:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39298 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261269AbUCHV2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:28:46 -0500
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in
	<=16G machines)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040308202433.GA12612@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Pj23leZU4DDjLmrVNAij"
Organization: Red Hat, Inc.
Message-Id: <1078781318.4678.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 08 Mar 2004 22:28:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Pj23leZU4DDjLmrVNAij
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> . Basically without
> this fix it's like 2.6 is running w/o pte-highmem. 700 tasks with 2.7G
> of shm mapped each would run the box out of zone-normal even with 4:4.
> With 3:1 100 tasks would be enough. Math is easy:
>=20
> 	2.7*1024*1024*1024/4096*8*100/1024/1024/1024
> 	2.7*1024*1024*1024/4096*8*700/1024/1024/1024


not saying your patch is not useful or anything,but there is a less
invasive shortcut possible. Oracle wants to mlock() its shared area, and
for mlock()'d pages we don't need a pte chain *at all*. So we could get
rid of a lot of this overhead that way.

Now your patch might well be useful for a lot of other reasons too, but
if this is the only one there are potential less invasive solutions for
2.6.


--=-Pj23leZU4DDjLmrVNAij
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBATOWExULwo51rQBIRAgWgAJ9GXEQGXIGkhA84SwvOcIwb8FWcxQCdHHLA
chB2Qf+Vl221jniHNgkQT14=
=CPyD
-----END PGP SIGNATURE-----

--=-Pj23leZU4DDjLmrVNAij--

