Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263548AbTCUHOl>; Fri, 21 Mar 2003 02:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263549AbTCUHOl>; Fri, 21 Mar 2003 02:14:41 -0500
Received: from marc2.theaimsgroup.com ([63.238.77.172]:57615 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id <S263548AbTCUHOi>; Fri, 21 Mar 2003 02:14:38 -0500
Date: Fri, 21 Mar 2003 02:26:53 -0500 (EST)
From: Hank Leininger <hlein@progressive-comp.com>
To: Ville Herva <vherva@niksula.hut.fi>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Deprecating .gz format on kernel.org
In-Reply-To: <20030321062635.GJ159052@niksula.cs.hut.fi>
Message-ID: <010303210206190.23184-100000@timmy.spinoli.org>
X-Marks-The: Spot
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 21 Mar 2003, Ville Herva wrote:

> On Thu, Mar 20, 2003 at 06:14:53PM -0500, you [Hank Leininger] wrote:
> >
> > Right, but if the uncompressed file is what's signed, then you must
> > waste either CPU uncompressing twice (once to verify, once to untar) or
> > waste disk (to store the uncompressed file, then verify, then untar).
>
> bzip2 -d < foo.tar.bz2 | tee >(md5sum) | tar xf
> or
> bzip2 -d < foo.tar.bz2 | tee >(gpg --verify foo.tar.bz2.sig) | tar xf

Yup, but (besides the tar tpyo you corrected later) this still isn't
safe.

1) gpg --verify won't be able to complete until it's seen all the unpacked
   tar file.

2) During that time tar -xf - will be unpacking and writing.

3) If the signature is bad, too late you've already unpacked it:
   -At best you need to blow away what you just unpacked.
   -Worse, it may have just (over)written real files in pwd other than
     the ones you think it should have.
   -Worst, if the tarfile is maliciously crafted to exploit tar (..'ing
     archive, symlink-following archive, or bad data which overflows
     tar), who-knows-what damage is already done.  This might sound
     far-fetched, except that it already happens.

...But it sounds like the whole discussion is dead anyway.  It would be
at least slightly less off-topic on security-audit, perhaps we should
move it there (http://lsap.org/mail.html).  Or to alt.tinfoil.hat.

Hank Leininger <hlein@progressive-comp.com>
E407 AEF4 761E D39C D401  D4F4 22F8 EF11 861A A6F1
-----BEGIN PGP SIGNATURE-----

iD8DBQE+er6+IvjvEYYapvERAqVKAJ9Z2sJ6pcib2+la0NqKYCeanuZwHwCdHEwt
9dSMcChXaa2G9sihxav6t0M=
=aCPQ
-----END PGP SIGNATURE-----

