Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWAaXYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWAaXYy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWAaXYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:24:54 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:40627 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932106AbWAaXYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:24:53 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ 06/23] [Suspend2] Disable usermode helper invocations when the freezer is on.
Date: Wed, 1 Feb 2006 09:21:04 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601311324.38149.nigel@suspend2.net> <200601311158.16882.rjw@sisk.pl>
In-Reply-To: <200601311158.16882.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1146897.AhpdzAL4Fp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602010921.09750.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1146897.AhpdzAL4Fp
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 31 January 2006 20:58, Rafael J. Wysocki wrote:
> Hi,
> > > >
> > > > +	if (freezer_is_on())
> > > > +		return 0;
> > > > +
> > > >  	if (path[0] =3D=3D '\0')
> > > >  		return 0;
> > >
> > > Disabling the usermode helper while freeze_processes() is executed
> > > seems to be a good idea to me, but I think it should be done with a
> > > mutex or something like that.
> >
> > With the refrigerator code you guys are using at the moment, ouldn't th=
at
> > result in deadlocks when we later try to freeze the process in
> > preparation for the atomic restore? (Or perhaps you don't freeze
> > processes at that point?)
>
> I'm not sure what you mean.  I said "mutex" because you seem to have a ra=
ce
> here (the freezer may be started right after the freezer_is_on() check).=
=20
> IMO the freezer should disable the invocations of new usermode helpers and
> wait util all of the already running helpers are finished.  For this
> purpose two variables would be needed and a lock.

Sorry. Being a bit thick.

I wasn't worried about already-running usermode helpers (or about-to-run=20
helpers either) because the spawned processes would either complete or be=20
caught be the usual freezing code. My concern was more that new invocations=
=20
of this path don't leave us with unfrozen processes hanging around. That=20
said, I think you have a valid point about letting existing helpers run to=
=20
completion. It does make me concerned though about the possibility of a=20
long-lived helper (not that I know that there really are such things at the=
=20
moment). Do you think that needs to be taken as a genuine concern? If so, I=
=20
guess we then need to make freezing a four stage process:

1. Stop new usermodehelpers from starting & let existing ones run to=20
completion.
2. Freeze userspace.
3. Freezer bdevs.
4. Freezer kernel space.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1146897.AhpdzAL4Fp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD3/DlN0y+n1M3mo0RAmRYAKDmIP0oK/NEg4tWAwkLWrvFL5Vt3ACgsF/R
Re9PAOpwYbHwuXuJJyoM2ws=
=pvKk
-----END PGP SIGNATURE-----

--nextPart1146897.AhpdzAL4Fp--
