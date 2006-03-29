Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWC2JNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWC2JNq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 04:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWC2JNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 04:13:46 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:29571 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750753AbWC2JNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 04:13:45 -0500
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
From: Laurent Vivier <Laurent.Vivier@bull.net>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Sato <sho@tnes.nec.co.jp>,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
Message-Id: <1143623605.5046.11.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-14) 
Date: Wed, 29 Mar 2006 11:13:26 +0200
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2006 11:15:45,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2006 11:15:47,
	Serialize complete at 29/03/2006 11:15:47
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-amFwSgLnS3BGhK7LJrwo"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-amFwSgLnS3BGhK7LJrwo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le mar 28/03/2006 =C3=A0 20:01, Mingming Cao a =C3=A9crit :
> On Tue, 2006-03-28 at 09:15 +0200, Laurent Vivier wrote:
> > Le mar 28/03/2006 =C3=A0 00:58, Ravikiran G Thirumalai a =C3=A9crit :
> > > On Mon, Mar 27, 2006 at 01:10:49PM -0800, Andrew Morton wrote:
> > > > Mingming Cao <cmm@us.ibm.com> wrote:
> > > > >
> > > > > I am wondering if we have (or plan to have) "long long " type of =
percpu
> > > > >  counters?  Andrew, Kiran, do you know? =20
> > > > >=20
> > > > >  It seems right now the percpu counters are used mostly by ext2/3=
 for
> > > > >  filesystem free blocks accounting. Right now the counter is "lon=
g" type,
> > > > >  which is not enough if we want to extend the filesystem limit fr=
om 2**31
> > > > >  to 2**32 on 32 bit machine.
> > > > >=20
> > > > >  The patch from Takashi copies the whole percpu_count.h  and crea=
te a new
> > > > >  percpu_llcounter.h to support longlong type percpu counters. I a=
m
> > > > >  wondering is there any better way for this?
> > > > >=20
> > > >=20
> > > > I can't immediately think of anything smarter.
> > > >=20
> > > > One could of course implement a 64-bit percpu counter by simply
> > > > concatenating two 32-bit counters.  That would be a little less eff=
icient,
> > > > but would introduce less source code and would mean that we don't n=
eed to
> > > > keep two different implemetations in sync.  But one would need to d=
o a bit
> > > > of implementation, see how bad it looks.
> > >=20
> > > Since long long is 64 bits on both 32bit and 64 bit arches, we can ju=
st
> > > change percpu_counter type to long long (or s64) and just have one
> > > implementation of percpu_counter? =20
> > > But reads and writes on 64 bit counters may not be atomic on all 32 b=
it arches.
> > > So the implementation might have to be reviewed for that.
> >=20
> > As 64bit per cpu counter is used only by ext3 and needed only on 64bit
> > architecture and when CONFIG_LBD is set, perhaps we can have only one
> > implementation, 32bit in the case of 32bit arch and 64bit in the case o=
f
> > 64bit arch + LBD, as I did in my 64bit patches for ext3 ?
> >=20
>=20
> The current percpu counter on 32 bit machine is "long", a signed value.
> It's a problem for ext3 on 32 bit arch also, as the total number of free
> blocks in ext3 is a type of u32. Isn't it? Did I miss something?

You're right, Mingming.

But I think instead of thinking to change "long" by "long long" we
should think about changing "long" by "unsigned long" in the per-cpu
counter structure.

Is there someone knowing why this counter is signed ?

Laurent
--=20
Laurent Vivier
Bull, Architect of an Open World (TM)
http://www.bullopensource.org/ext4

--=-amFwSgLnS3BGhK7LJrwo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBEKk+19Kffa9pFVzwRAqiGAJ9kPOXcDd3Q3k1/l+WDESp/NW6DBgCcDyQ3
2Hip7TbhcSvmWfHx7rswBa8=
=Y5PK
-----END PGP SIGNATURE-----

--=-amFwSgLnS3BGhK7LJrwo--

