Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266716AbTBLWUD>; Wed, 12 Feb 2003 17:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267881AbTBLWUD>; Wed, 12 Feb 2003 17:20:03 -0500
Received: from aramis.rutgers.edu ([128.6.4.2]:24455 "EHLO aramis.rutgers.edu")
	by vger.kernel.org with ESMTP id <S266716AbTBLWUC>;
	Wed, 12 Feb 2003 17:20:02 -0500
Subject: Re: O_DIRECT foolish question
From: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20030212140338.6027fd94.akpm@digeo.com>
References: <1045084764.4767.76.camel@urca.rutgers.edu>
	 <20030212140338.6027fd94.akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HdzYVgPx257YK3Q47eNX"
Organization: Rutgers University
Message-Id: <1045088991.4767.85.camel@urca.rutgers.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 12 Feb 2003 17:29:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HdzYVgPx257YK3Q47eNX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-02-12 at 17:03, Andrew Morton wrote:
> Bruno Diniz de Paula <diniz@cs.rutgers.edu> wrote:
> >
> > Hi,
> >=20
> > I am trying to use O_DIRECT to read ordinary files and read syscall
> > always returns 0, unless when the file size equals the fs block size.
>=20
> It should be returning -1, with errno set to EINVAL.

But I am using multiples of page size in both buffer alignment and
buffer size (2nd and 3rd parameters of read). The issue is that when I
try to read files with sizes that are NOT multiples of block size (and
therefore also not multiples of page size), the read syscall returns 0,
with no errors. With files of size 4096, 8192 etc, everything works
fine. The errors shouldn't occur indeed, as I am using the correct
alignment and size to read. So the question remains, am I able to read
just files whose size is a multiple of block size?

Thanks,

Bruno.

PS: I am running 2.4.20...

>=20
> > Is
> > it true that I can only use O_DIRECT when the size of the file written
> > in the inode is a multiple of block size?
> >=20
>=20
> The file can be of any size - the kernel will zero-fill any remaining byt=
es.
>=20
> The address and length which you pass into the read() or write() system c=
all
> must both be a multiple of the filesystem block size.
>=20
> It is always safe to just use the machine's page size for alignment
> calculations - no filesystem has a blocksize larger than the pagesize.
>=20
> A good way to do this is to run getpagesize(), and to then malloc a buffe=
r
> which is one page larger than you need.  Then round that address up to th=
e
> next page boundary.  And perform I/O into that memory with
> multiple-of-page-size requests.
>=20
>=20
>=20
> In the 2.5 kernel the "must be a multiple of blocksize" requirement was
> relaxed.  We now support alignments and lengths down to the minimum which=
 is
> supported by the underlying device.  Typically 512 bytes, but not always.
>=20
> Portable applications should not assume that 512-byte alignment is suppor=
ted.
> They should query the device's aligment requirements via the BLKSSZGET io=
ctl
> against (say) /dev/hda1.  Or they can simply try 512, 1024, 2048, ...  at
> initialisation time.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Rutgers University

--=-HdzYVgPx257YK3Q47eNX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+SsrfZGORSF4wrt8RAjjVAJ0YCWW1kPwSRC5TY/o23z5FcurxNQCfS2se
S7uBWUQkRfc82vIkyA9RJnY=
=KtF7
-----END PGP SIGNATURE-----

--=-HdzYVgPx257YK3Q47eNX--

