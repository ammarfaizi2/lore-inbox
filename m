Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVBUTs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVBUTs2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 14:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVBUTrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 14:47:55 -0500
Received: from deventer.factotum.nl ([195.18.123.2]:23018 "EHLO
	kiev.dev.factotummedia.nl") by vger.kernel.org with ESMTP
	id S262082AbVBUTq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 14:46:56 -0500
Date: Mon, 21 Feb 2005 20:45:57 +0100
From: zander@kde.org
To: Andrea Arcangeli <andrea@suse.de>
Cc: darcs-users@darcs.net, lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
Message-ID: <20050221194557.GA23251@factotummedia.nl>
Mail-Followup-To: zander@kde.org, Andrea Arcangeli <andrea@suse.de>,
	darcs-users@darcs.net, lm@bitmover.com,
	linux-kernel@vger.kernel.org
References: <20050214020802.GA3047@bitmover.com> <200502172105.25677.pmcfarland@downeast.net> <421551F5.5090005@tupshin.com> <20050218090900.GA2071@opteron.random> <bc647aafb53842b58dd0279161fb48e0@spy.net> <buosm3q5v5y.fsf@mctpc71.ucom.lsi.nec.co.jp> <20050221155306.GU7247@opteron.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20050221155306.GU7247@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 21, 2005 at 04:53:06PM +0100, Andrea Arcangeli wrote:
> Hello Miles,
>=20
> On Mon, Feb 21, 2005 at 02:39:05PM +0900, Miles Bader wrote:
> > Yeah, the basic way arch organizes its repository seems _far_ more sane
> > than the crazy way CVS (or BK) does, for a variety of reasons[*].  No
> > doubt there are certain usage patterns which stress it, but I think it
> > makes a lot more sense to use a layer of caching to take care of those,
> > rather than screwing up the underlying organization.
> >=20
> > [*] (a) Immutability of repository files (_massively_ good idea)
>=20
> what is so important about never modifying the repo? Note that only the
> global changeset database and a few ,v files will be modified for each
> changeset, it's not like we're going to touch all the ,v files for each
> checkin. Touching the "modified" ,v files sounds a very minor overhead.
>=20
> And you can incremental backup the stuff with recursive diffing the
> repo too.
>=20
> AFIK all other SCM except arch and darcs always modify the repo, I never
> heard complains about it, as long as incremental backups are possible
> and they definitely are possible.

Well, as you seem to have never been bitten by that bug; let me assure you
the problem is very real.  Each file (,v file) can live in the repo for
many years and has to servive any spurious writes to be usable.  The
curruption of such files (in my experience) only shows itself if you try
to access its history; which may be weeks after the corruption started,
and you can't use a backup for that since you will overwrite new versions
added since.

Think about it this way;  nfs servers are known to corrupt things;
reboots can corrupt files, different clients will try to write to
the file at the same time quite often during the lifetime of the file, cvs
clients get killed during writes or network drops the connection during a
session.
Considering that the ,v files have a lifetime of years, with many
modifications during that time, I think its amazing corruption does not
happen more often.

CVS was pretty good at keeping files sane, but I'll go for a solution that
completely sidesteps said problem any day.

--=20
Thomas Zander

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCGjp1CojCW6H2z/QRAh/EAKCMSnWwbsy7dzLYsR/P7wOWgdx8VQCfbVIJ
6AQj3kuzArKklnYdX8q1vFs=
=Ti5S
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
