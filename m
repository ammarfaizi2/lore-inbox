Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270625AbTGZXNg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 19:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270626AbTGZXNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 19:13:36 -0400
Received: from diale221.ppp.lrz-muenchen.de ([129.187.28.221]:26603 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id S270625AbTGZXNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 19:13:34 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Daniel Egger <degger@fhm.edu>
To: Yury Umanets <umka@namesys.com>
Cc: Nikita Danilov <Nikita@Namesys.COM>, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <1059231274.28094.40.camel@haron.namesys.com>
References: <3F1EF7DB.2010805@namesys.com>
	 <1059062380.29238.260.camel@sonja>
	 <16160.4704.102110.352311@laputa.namesys.com>
	 <1059093594.29239.314.camel@sonja>
	 <16161.10863.793737.229170@laputa.namesys.com>
	 <1059142851.6962.18.camel@sonja>
	 <1059143985.19594.3.camel@haron.namesys.com>
	 <1059181687.10059.5.camel@sonja>
	 <1059203990.21910.13.camel@haron.namesys.com>
	 <1059228808.10692.7.camel@sonja>
	 <1059231274.28094.40.camel@haron.namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4Llnxx98VMlh9NY1CLNH"
Message-Id: <1059232897.10692.37.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 26 Jul 2003 17:21:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4Llnxx98VMlh9NY1CLNH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sam, 2003-07-26 um 16.54 schrieb Yury Umanets:

Now we're talking. :)

> Reiserfs cannot be used efficiently with flash, as it uses block size 4K
> (by default) and usual flash block size is in range 64K - 256K.

Don't confuse block size with erase size. The former is the layout of
the fs' data on the medium while the latter is the granulariy of the
erase command which is important insofar that flash has to be erased (in
most cases) before one can write new data on it.

However since you said that one can plug in a different block allocation
scheme, I think it might be possible to work around that limitation by
writing a block allocator which works around the limitations of the
erase size.

> Also reiserfs does not use compression, that would be very nice of it
> :), because flash has limited number of erase cycles per block (in range
> 100.000)

I don't see what the compression has to do with the limited number of
erase/write cycles.

>  and it is about three times as expensive as SDRAM.

That's true but not important to us. The system right now fits nicely on
a 128MB CF card when using ext2 or on 64MB when using JFFS2. The latter
is far more stable and reliable but dogslow. Since the price difference
between 128MB and 64CF is rather small and the cost of the overall
system relatively high this is no argument for us.

> So, it is better to use something more convenient. For instance jffs2.

Convenient only insofar that it's more reliable. It's a pain in the neck
to setup for non hardwired flash chips and to boot, it also takes
forever to mount and to write on it.

> (1) Make the journal substantial smaller of size.
> (2) Don't turn tails off. This is useful to prolong flash live.

Thanks. But first I'll have a look at your plugin architecture to see
how feasible a different implementation of block allocation especially
for flash devices would be.

--=20
Servus,
       Daniel

--=-4Llnxx98VMlh9NY1CLNH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/IpyBchlzsq9KoIYRAlF+AKDUk/SLYoFmESbW9H9zLigW/Q5kigCfcqaF
uFAF6dMHjG79LYbl3CFk/Tg=
=GgTC
-----END PGP SIGNATURE-----

--=-4Llnxx98VMlh9NY1CLNH--

