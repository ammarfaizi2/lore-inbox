Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318116AbSIAV37>; Sun, 1 Sep 2002 17:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318113AbSIAV37>; Sun, 1 Sep 2002 17:29:59 -0400
Received: from ppp-217-133-221-133.dialup.tiscali.it ([217.133.221.133]:22459
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318107AbSIAV34>; Sun, 1 Sep 2002 17:29:56 -0400
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
From: Luca Barbieri <ldb@ldb.ods.org>
To: trond.myklebust@fys.uio.no
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <15730.27952.29723.552617@charged.uio.no>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb> <15729.17279.474307.914587@charged.uio.no>
	<1030835635.1422.39.camel@ldb> <15730.4100.308481.326297@charged.uio.no>
	<15730.8121.554630.859558@charged.uio.no> <1030890022.2145.52.camel@ldb>
	<15730.17171.162970.367575@charged.uio.no> <1030906488.2145.104.camel@ldb> 
	<15730.27952.29723.552617@charged.uio.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Zslc083KF1mU9jlB8qO7"
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Sep 2002 23:34:21 +0200
Message-Id: <1030916061.2145.344.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Zslc083KF1mU9jlB8qO7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2002-09-01 at 21:40, Trond Myklebust wrote:
> >>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:
> 
>      > And, in the common case of open, why do you need to copy the
>      > structure to check permissions?  I think that open should just
>      > check the current values.  open might want to copy credentials
> 
> Because, as has been explained to you, we have things like Coda,
> Intermezzo, NFS, for which this is insufficient.
If they only need them at open, and the open is synchronous, you don't
need to copy them.

Otherwise, if you need them in other syscall, or in another context, you
probably need to copy them, that only costs an additional 2 long copies.

>      > in case you want to do the inode lookup asynchronously but then
>      > it doesn't make sense to optimize for this since you already
>      > have the huge disk read penalty.  BTW, the 2.5.32 open does the
>      > check in vfs_permission without copying anything.  Anyway it's
>      > just a 3 long copy plus an atomic inc vs. 1 long copy and
>      > atomic inc.  And if you don't need the groups array, it's just
>      > a 2 longs copy that on some architectures with very slow atomic
>      > operations (e.g. sparc) is much better.
> 
> But we we do need to check the groups array in the VFS. And as Linus
> pointed out, there is a good case for passing info from the
> user_struct too (crypto), etc...
There is copy-on-write for the groups array.
The idea is that anything that takes little time to use should be in the
copy-always structure, while things that need a long time to access
(e.g. groups, lsm data) and/or are big, stay in the copy-on-write
structure referenced from the copy-always one.


--=-Zslc083KF1mU9jlB8qO7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9cofcdjkty3ft5+cRAmGtAJ4jXL3B0EhIi7xd7h9e+5foo07cmACdEriG
ZY/sRvoeguorXtw/51fAEF4=
=ETvE
-----END PGP SIGNATURE-----

--=-Zslc083KF1mU9jlB8qO7--
