Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbTLWLNx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 06:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbTLWLNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 06:13:52 -0500
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:32640
	"EHLO ghanima.endorphin.org") by vger.kernel.org with ESMTP
	id S265102AbTLWLNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 06:13:50 -0500
Date: Tue, 23 Dec 2003 12:14:12 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Christophe Saout <christophe@saout.de>, linux-kernel@vger.kernel.org,
       thornber@sistina.com
Subject: Re: loop driver, device-mapper and crypto
Message-ID: <20031223111412.GA4593@ghanima.endorphin.org>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net>
	<20031222140305.61823850.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20031222140305.61823850.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: Fruhwirth Clemens <clemens-dated-1073042053.4811@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2003 at 02:03:05PM -0800, Andrew Morton wrote:
> Christophe Saout <christophe@saout.de> wrote:
> >
> > In 2.6 we have a device-mapper which does such things in a much more
> > generic way. I've already talked to a bunch of people working on loop
> > and cryptoloop (also with Clemens Fruhwirth, the cryptoloop maintainer)
> > and they all agreed that device-mapper is probably the most correct way
> > to go, and would be happier if the loop driver was used for files only.
>=20
> I'm not a crypto-loop user, so I am not in a position to judge whether
> using dm for crypto-on-disk is feature-sufficient and adequate from an
> operational point of view.

First of all, eventhou I'm the maintainer of cryptoloop, when Christophe
posted the first time I immediately recognized that dm-crypt is vastly
superior to cryptoloop for a number of reasons:

=2E) It does not suffer from loop.c bugs (There are a lot, no maintainer)
=2E) dm-crypt does not depend on special user space tool (util-linux)
=2E) dm-crypt uses mempool, which makes it rock stable compared to cryptolo=
op.=20

=46rom an operational point of view, patching util-linux has been the most
troublesome point. Lot's of incompatible inofficial patches floating around
in the net, while the last release of util-linux provides a broken and IMHO
insecure why of setting up cryptokeys. Further: To fix the design flaw of
unencrypted/unhashed IV vectors one has to add another setup parameter.
That's where I really do like the flexible interface dm has.

> However I suspect that there will be a migration issue, and that we should
> continue to work to get crypto-loop functioning well, plan to remove it
> from 2.8, yes?

We should support cryptoloop. No new features, but working well. At the same
time we should declare it 'deprecated' and provide dm-crypt as alternative.
I'm happy to provide documentation on how to migrate.

I will review Christophe's patch as well as test compatiblity with
cryptoloop. Expect my results in a few days.

Regards, Clemens

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/6COEW7sr9DEJLk4RAs2nAJ4qVWgq+551H5fNDR++sBWTOCU2nQCfYce8
jhOL2rZSLIila/eWqVrdT/U=
=fc94
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
