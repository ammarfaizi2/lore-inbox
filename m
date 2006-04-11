Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWDKHHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWDKHHy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 03:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWDKHHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 03:07:53 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:64391 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932286AbWDKHHw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 03:07:52 -0400
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit
	from 8TB to 16TB
From: Laurent Vivier <Laurent.Vivier@bull.net>
To: Mingming Cao <cmm@us.ibm.com>
Cc: kiran@scalex86.org, Andrew Morton <akpm@osdl.org>,
       Takashi Sato <sho@tnes.nec.co.jp>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1144696012.3964.76.camel@dyn9047017067.beaverton.ibm.com>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060329175446.67149f32.akpm@osdl.org>
	 <1144660270.5816.3.camel@openx2.frec.bull.fr>
	 <1144688279.3964.7.camel@dyn9047017067.beaverton.ibm.com>
	 <1144696012.3964.76.camel@dyn9047017067.beaverton.ibm.com>
Message-Id: <1144739259.9786.5.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-14) 
Date: Tue, 11 Apr 2006 09:07:39 +0200
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/04/2006 09:10:09,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/04/2006 09:10:12,
	Serialize complete at 11/04/2006 09:10:12
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SVlWzbZRpk5G4VFumb2x"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SVlWzbZRpk5G4VFumb2x
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le lun 10/04/2006 =C3=A0 21:06, Mingming Cao a =C3=A9crit :
> On Mon, 2006-04-10 at 09:57 -0700, Mingming Cao wrote:
> > On Mon, 2006-04-10 at 11:11 +0200, Laurent Vivier wrote:
[...]
> Hi Laurent,
>=20
> Just looked at your patch, shouldn't we use atomic_long_add() instead of
> atomic_long_set() to replace percpu_counter_mod()?

Yes, thank you.

> > I tried the other way -- I am trying to keep the percpu counter in use
> > in ext2/3 as much as possible.  I proposed a fix for percpu counter to
> > deal with the possible "overflow" (i.e, a counter really has a value of
> > 0xfff_feee and after updating one local counter it truens 0x00000123).
> > Will send the proposed patch out for review and comments soon.
> >=20
>=20
> Anyway, I am not against the atomic way. Just thought there must be
> reasons where we use percpu counters -- the cache pollution on smp
> machine is certainly a concern if we use atomic instead, so I  tried to
> fix percpu counter first.
>=20
> I think my fix for percpu counter should work, and the changes doesn't
> affect other users of current percpu counters(vfs and network).  Kiran,
> Andrew, please review it (posted in another seperate thread). If not,
> then I guess we have to use atomic counter -- this is performance vs
> capacity kind of trade off.

I made some tests with iozone on 2 CPU hyperthreaded computer (=3D 4 CPUs,
Bull Express 5800 120 Lh), and it seems atomic_t is faster than
"percpu_counter". I'll try to make some tests on IBM x440 (8 CPUs, 16 if
hyperthreaded) with iozone and sysbench.
Moreover, I think percpu_counter uses a lot of memory...

> But both methods don't support 64 bit ext3 block number on 32 bit
> machine...I am not happy with this but can't think of a way to fix this
> without taking a global lock:(

Anyway, wa can't have a 64bit addressing space on a 32bit machine, so I
think, for the moment, it's not a problem.

Regards,
Laurent
--=20
Laurent Vivier
Bull, Architect of an Open World (TM)
http://www.bullopensource.org/ext4

--=-SVlWzbZRpk5G4VFumb2x
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBEO1W79Kffa9pFVzwRAlh/AJ0Qw4D6O3E86K1PmP6Do6uBJAea3QCgwoPU
5eBAYjl6sRJvnMUSajbQBNw=
=aqzM
-----END PGP SIGNATURE-----

--=-SVlWzbZRpk5G4VFumb2x--

