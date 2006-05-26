Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWEZSaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWEZSaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWEZSaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:30:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59034 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751254AbWEZSaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:30:01 -0400
Message-ID: <447748E4.4050908@redhat.com>
Date: Fri, 26 May 2006 11:28:52 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       serue@us.ibm.com, sam@vilain.net, clg@fr.ibm.com, dev@sw.ru
Subject: Re: [PATCH] POSIX-hostname up to 255 characters
References: <20060525204534.4068e730.rdunlap@xenotime.net> <m1zmh5b129.fsf@ebiederm.dsl.xmission.com> <20060526144216.GZ13513@lug-owl.de> <Pine.LNX.4.58.0605261025230.9655@shark.he.net> <20060526180131.GA13513@lug-owl.de> <Pine.LNX.4.61.0605261409300.8002@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0605261409300.8002@chaos.analogic.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3B029F870E2729A703FA1320"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3B029F870E2729A703FA1320
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

linux-os (Dick Johnson) wrote:

> MAXHOSTNAMELEN, defined by POSIX, is 64 bytes.

Where do you think this is written?  The minimum maximum for the host
name length in POSIX is 255.  This is the whole motivation of the patch.
 Linux currently cannot conform because this is one of the things the
kernel gets wrong.


> You can't just
> change it to 255. If you did, all servers in the universe, all
> everything would have to be shutdown, recompiled, and rebooted
> simultaneously. You can't have a name-server returning a 255-byte
> string when a mail-server can only handle 64 bytes.

The hostname is a machine-local value.  How the machine is represented
to the outside world is governed by services like DNS.  DNS defines its
own limits on the length of the name and each component.  So, if a host
name (without domain) exceeds 64 bytes you need a different external
name for the machine.  But this doesn't stop anybody from locally using
a longer name.

Can there be programs which have problems?  Certainly.  But
gethostname() won't just overwrite memory.  It'll return an error and
the programs with the wrong assumptions can be fix.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig3B029F870E2729A703FA1320
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEd0jk2ijCOnn/RHQRAu7CAJ4rUPX6fKYFfdhyt05bDSPwvLBBywCfc5mM
/VQ9vIwzwXpRembFXcrn7+o=
=Imps
-----END PGP SIGNATURE-----

--------------enig3B029F870E2729A703FA1320--
