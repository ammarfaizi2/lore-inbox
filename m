Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVBUInJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVBUInJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 03:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVBUInJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 03:43:09 -0500
Received: from dea.vocord.ru ([217.67.177.50]:29886 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261157AbVBUInA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 03:43:00 -0500
Subject: Re: [Elsa-devel] Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork
	connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Erich Focht <efocht@hpce.nec.com>
In-Reply-To: <1108973130.8418.76.camel@frecb000711.frec.bull.fr>
References: <1108652114.21392.144.camel@frecb000711.frec.bull.fr>
	 <1108655454.14089.105.camel@uganda>
	 <1108973130.8418.76.camel@frecb000711.frec.bull.fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bOrGoJMNrMI3gort7ap0"
Organization: MIPT
Date: Mon, 21 Feb 2005 11:48:42 +0300
Message-Id: <1108975722.6728.20.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 21 Feb 2005 11:42:37 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bOrGoJMNrMI3gort7ap0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-02-21 at 09:05 +0100, Guillaume Thouvenin wrote:
> On Thu, 2005-02-17 at 18:50 +0300, Evgeniy Polyakov wrote:
> > > =20
> > > +#if defined(CONFIG_CONNECTOR) && defined(CONFIG_FORK_CONNECTOR)
> >=20
> > I suspect CONFIG_FORK_CONNECTOR is enough.
>=20
> The problem here is that if connector is compiled as a module and
> fork_connector as builtin there will be undefined reference to symbol
> like 'cn_already_initialized' or 'cn_netlink_send'. That's why the
> fork_connector() must be enable if CONFIG_CONNECTOR and
> CONFIG_FORK_CONNECTOR are selected as builtin and not as a module. I
> agree that it's not very elegant...

Maybe "depends on CONNECTOR=3Dy" ?

> > > +			cn_netlink_send(msg, 1);
> >=20
> > "1" here means that this message will be delivered to any group
> > which has it's first bit set(1, 3, and so on) in given socket queue.
> > I suspect it is not what you want.
> > By design connector's users should send messages to the group it was
> > registered with
> > (which is obtained from idx field of the struct cb_id), in your case it
> > is CN_IDX_FORK,
> > and connector userspace consumers should bind to the same group (idx
> > value).
> > It is of course not requirement, but a fair path(hmm, I can add more
> > strict checks into connector).
> > By setting 0 as second parameter for cn_netlink_send() you will force
> > connector's core
> > to select proper group for you.
>=20
> Yes but cn_netlink_send() is looking for a callback with the same idx.
> As I don't use any callback, found =3D=3D 0 and I have an error "Failed t=
o
> find multicast netlink group for callback[0xfeed.0xbeef]". So the good
> call is: cn_netlink_send(msg, CN_IDX_FORK);

Uh-oh, I see...
I recall your previous patch with the fork_callback()...

Nevertheless "1" is a bad idea, CN_IDX_FORK is what is expected.

> Thanks for your help,
> Guillaume
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-bOrGoJMNrMI3gort7ap0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCGaBqIKTPhE+8wY0RAgiAAJ99HgZTs0E/+JOA4AUbLpMl1KUp7wCcCVW7
haEFS6DMyAGBEi61lzW6vAc=
=31SF
-----END PGP SIGNATURE-----

--=-bOrGoJMNrMI3gort7ap0--

