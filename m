Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTL2RSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTL2RSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:18:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38098 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263726AbTL2RSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:18:02 -0500
Date: Mon, 29 Dec 2003 18:17:53 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Christophe Saout <christophe@saout.de>
Cc: Nicklas Bondesson <nicke@nicke.nu>, linux-kernel@vger.kernel.org
Subject: Re: ataraid in 2.6.?
Message-ID: <20031229171753.GA21479@devserv.devel.redhat.com>
References: <S262196AbTL2AJ1/20031229000927Z+17179@vger.kernel.org> <1072691350.5223.7.camel@laptop.fenrus.com> <1072717701.5152.123.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <1072717701.5152.123.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2003 at 06:08:21PM +0100, Christophe Saout wrote:
> Am Mo, den 29.12.2003 schrieb Arjan van de Ven um 10:49:
> >
> > the plan is to have a userspace device mapper app take it's place.
> > As for the timeframe; I'm looking at it but the userspace device mapper
> > code is still a bit of a mystory to me right now.
>=20
> It is? I think it's kind of simple (probably, if you know what's going
> on ;)). Which interface are you looking it?
>=20
> I'm just looking at the ataraid code. Is my assumption correct, that it
> simply interleaves sectors between two harddisks? Even sector number ->
> hd1, odd number -> hd2?

not always (one format has the hd2 offset by 10 sectors)

> Using the simple dmsetup tool one could try something like:
>=20
> echo 0 $(expr $(blockdev --getsize /dev/<HD1>) \* 2) stripe 2 1
> /dev/<HD1> 0 /dev/<HD2> 0 | dmsetup create ataraid
>=20
> Where <HD1> and <HD2> should of course be replaced by the raw disks.

> If everything is correct a device /dev/mapper/ataraid should be created.


> Using libdevmapper something like:
> dm_task_create(DM_DEVICE_CREATE)
> dm_task_task_set_name (required)
> dm_task_set_uuid (optional)
> dm_task_add_target (only once in this case, contains the stripe target)
> dm_task_set_ro (if readonly)
> dm_task_set_major / _minor (if you don't want a dynamically allocated)
> dm_task_run

thanks for the info! I'll look into what this means ;)

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/8GHAxULwo51rQBIRAvkWAJ4tASielhnh6ZAlDcWtgP3G7539LQCfWoSr
UUeiZoXeuWy9AUZzLixhITs=
=cpVY
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
