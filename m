Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbTDSJxU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 05:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263374AbTDSJxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 05:53:19 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:24014 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263373AbTDSJxS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 05:53:18 -0400
Date: Sat, 19 Apr 2003 13:02:08 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: Re: [CHECKER] 6 memory leaks
Message-ID: <20030419100208.GA7625@actcom.co.il>
References: <20030419025025.GA32656@Xenon.Stanford.EDU> <20030419094445.GA7283@actcom.co.il> <20030419095526.GE12469@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20030419095526.GE12469@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2003 at 02:55:26AM -0700, William Lee Irwin III wrote:
> On Sat, Apr 19, 2003 at 12:44:45PM +0300, Muli Ben-Yehuda wrote:
> > Index: net/irda/irttp.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > RCS file: /home/cvs/linux-2.5/net/irda/irttp.c,v
> > retrieving revision 1.12
> > diff -u -r1.12 irttp.c
> > --- net/irda/irttp.c	25 Feb 2003 05:02:46 -0000	1.12
> > +++ net/irda/irttp.c	19 Apr 2003 08:50:00 -0000
> > @@ -263,7 +263,7 @@
> > =20
> >  	IRDA_DEBUG(2, "%s(), rx_sdu_size=3D%d\n",  __FUNCTION__,
> >  		   self->rx_sdu_size);
> > -	ASSERT(n <=3D self->rx_sdu_size, return NULL;);
> > +	ASSERT(n <=3D self->rx_sdu_size, {dev_kfree_skb(skb); return NULL;});
> > =20
> >  	/* Set the new length */
> >  	skb_trim(skb, n);
>=20
> I'm in terror. ASSERT()? return NULL in a macro argument?
> Any chance of cleaning that up a bit while you're at it?

I'm afraid it's rather wide-spread...=20

mulix@granada:~/kernel/cvs/linux-2.5$ grep ASSERT net/irda/*.c | grep retur=
n | wc -l
    511

I'm willing to do the grunt work of converting it, if it's ok with the
IRDA maintainers.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+oR6gKRs727/VN8sRAkzGAJ9eA4E/BJIToSc5QlIx/RHaGMsBHwCgtqPL
b9cndYuLeIfdRHIGjQmJPS0=
=olAq
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
