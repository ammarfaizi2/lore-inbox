Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286248AbRLJM2v>; Mon, 10 Dec 2001 07:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286244AbRLJM2m>; Mon, 10 Dec 2001 07:28:42 -0500
Received: from hq.alert.sk ([147.175.66.131]:29931 "HELO hq.alert.sk")
	by vger.kernel.org with SMTP id <S286249AbRLJM2Z>;
	Mon, 10 Dec 2001 07:28:25 -0500
Date: Mon, 10 Dec 2001 13:25:42 +0100
From: Niteshadow <niteshadow@tulene.sk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Robert Love <rml@tech9.net>, Benjamin LaHaise <bcrl@redhat.com>,
        Anthony DeRobertis <asd@suespammers.org>, root <r6144@263.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make highly niced processes run only when idle
Message-ID: <20011210132542.B15152@hq.alert.sk>
In-Reply-To: <1007944229.878.21.camel@phantasy> <Pine.LNX.4.33L.0112100045460.4079-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0112100045460.4079-100000@imladris.surriel.com>; from riel@conectiva.com.br on Mon, Dec 10, 2001 at 12:46:23AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2001 at 12:46:23AM -0200, Rik van Riel wrote:
> On 9 Dec 2001, Robert Love wrote:
>=20
> > Hmm, what if we only boosted it based on something like this:
> >
> > 	if (p->policy =3D=3D SCHED_IDLE) {
> > 		weight =3D p->counter;
> > 		if (p->lock_depth >=3D 0 || signal_pending(p))
> > 			/* boost somehow ... */
> > 	}
>=20
> Now what if the process is holding an inode or superblock
> semaphore ?

Even better:

What if the SCHED_IDLE task holds a POSIX read lock on a file ?

Say we have three processes:
A is SCHED_IDLE holding read lock on /foo/bar
B is SCHED_OTHER wanting to acquire write lock /foo/bar
C is SCHED_OTHER computing fractals and eating up every cycle it can get

What we want is A to get B's priority until it releases the lock on
/foo/bar and then revert it to SCHED_IDLE policy. Otherwise B would get
deadlocked with A while C (or any other CPU hog) is running.

I know this is a userspace problem (similar to real-time processes vs.
normal processes), but I think it would be nice to make SCHED_IDLE
non-priviliged policy.

--=20
Kind regards,
Robert Varga
---------------------------------------------------------------------------=
---
n@hq.sk                                          http://hq.sk/~nite/gpgkey.=
txt
=20

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8FKnG9aKR2/T45h8RArjwAKC69pKJAwIOF/mH+ICbu+w1Mf3b1wCfaOmU
TVsF/EQcE445DPjUsDYQwMQ=
=vI1m
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
