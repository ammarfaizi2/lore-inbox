Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWDRK5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWDRK5P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 06:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWDRK5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 06:57:15 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:52179 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932183AbWDRK5O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 06:57:14 -0400
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit
	from 8TB to 16TB
From: Laurent Vivier <Laurent.Vivier@bull.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       Mingming Cao <cmm@us.ibm.com>, Takashi Sato <sho@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1145345407.2976.13.camel@laptopd505.fenrus.org>
References: <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060329175446.67149f32.akpm@osdl.org>
	 <1144660270.5816.3.camel@openx2.frec.bull.fr>
	 <20060410012431.716d1000.akpm@osdl.org>
	 <1144941999.2914.1.camel@openx2.frec.bull.fr>
	 <20060417210746.GB3945@localhost.localdomain>
	 <1145308176.2847.90.camel@laptopd505.fenrus.org>
	 <20060417213201.GC3945@localhost.localdomain>
	 <1145344481.17767.1.camel@openx2.frec.bull.fr>
	 <1145345407.2976.13.camel@laptopd505.fenrus.org>
Message-Id: <1145357820.17767.11.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-14) 
Date: Tue, 18 Apr 2006 12:57:00 +0200
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/04/2006 12:59:41,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/04/2006 12:59:43,
	Serialize complete at 18/04/2006 12:59:43
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SFdryBRJ3B9U2nFBIpUu"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SFdryBRJ3B9U2nFBIpUu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le mar 18/04/2006 =C3=A0 09:30, Arjan van de Ven a =C3=A9crit :
> On Tue, 2006-04-18 at 09:14 +0200, Laurent Vivier wrote:
> > Le lun 17/04/2006 =C3=A0 23:32, Ravikiran G Thirumalai a =C3=A9crit :
> > > On Mon, Apr 17, 2006 at 11:09:36PM +0200, Arjan van de Ven wrote:
> > > > On Mon, 2006-04-17 at 14:07 -0700, Ravikiran G Thirumalai wrote:
> > > > >=20
> > > > >=20
> > > > > I ran the same tests on a 16 core EM64T box very similar to the o=
ne
> > > > > you ran
> > > > > dbench on :). Dbench results on ext3 varies quite a bit.  I could=
n't
> > > > > get=20
> > > > > to a statistically significant conclusion  For eg,
> > > >=20
> > > >=20
> > > > dbench is not a good performance benchmark. At all. Don't use it fo=
r
> > > > that ;)
> > >=20
> > > Agreed. (I did not mean to use it in the first place :).  I was just =
trying=20
> > > to verify the benchmark results posted earlier)
> > >=20
> > > Thanks,
> > > Kiran
> >=20
> > What is the good performance benchmark to know if we should use atomic_=
t
> > instead of percpu_counter ?
>=20
> you probably want something like postal/postmark instead or so (although
> that's not ideal either), at least that's reproducable

I made tests on same system (x440) with postmark-1.51 :

pm> set numbers 100000
pm> set transactions 250000
pm> run

With atomic_t:

Time:
        3761 seconds total
        2414 seconds of transactions (103 per second)

Files:
        225064 created (59 per second)
                Creation alone: 100000 files (87 per second)
                Mixed with transactions: 125064 files (51 per second)
        124961 read (51 per second)
        124895 appended (51 per second)
        225064 deleted (59 per second)
                Deletion alone: 100128 files (503 per second)
                Mixed with transactions: 124936 files (51 per second)

Data:
        731.14 megabytes read (199.07 kilobytes per second)
        1359.02 megabytes written (370.02 kilobytes per second)

With percpu_counter:

Time:
        3787 seconds total
        2422 seconds of transactions (103 per second)

Files:
        225064 created (59 per second)
                Creation alone: 100000 files (85 per second)
                Mixed with transactions: 125064 files (51 per second)
        124961 read (51 per second)
        124895 appended (51 per second)
        225064 deleted (59 per second)
                Deletion alone: 100128 files (503 per second)
                Mixed with transactions: 124936 files (51 per second)

Data:
        731.14 megabytes read (197.70 kilobytes per second)
        1359.02 megabytes written (367.48 kilobytes per second)

--=20
Laurent Vivier
Bull, Architect of an Open World (TM)
http://www.bullopensource.org/ext4

--=-SFdryBRJ3B9U2nFBIpUu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBERMX89Kffa9pFVzwRAnpLAKCEQs7zALASlcq7XQe/JXZprnFdxQCfZXe7
sDDZ2terhzndDU1vov5fnlw=
=XE7i
-----END PGP SIGNATURE-----

--=-SFdryBRJ3B9U2nFBIpUu--

