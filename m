Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317305AbSIASih>; Sun, 1 Sep 2002 14:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSIASih>; Sun, 1 Sep 2002 14:38:37 -0400
Received: from ppp-217-133-221-133.dialup.tiscali.it ([217.133.221.133]:49378
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S316677AbSIASif>; Sun, 1 Sep 2002 14:38:35 -0400
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
From: Luca Barbieri <ldb@ldb.ods.org>
To: trond.myklebust@fys.uio.no
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <15730.17012.61365.788871@charged.uio.no>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb> <15729.17279.474307.914587@charged.uio.no>
	<1030835635.1422.39.camel@ldb> <15730.4100.308481.326297@charged.uio.no>
	<1030890821.2145.67.camel@ldb>  <15730.17012.61365.788871@charged.uio.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-60rKL5e8aQpiXyI0kGCd"
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Sep 2002 20:42:57 +0200
Message-Id: <1030905777.2145.91.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-60rKL5e8aQpiXyI0kGCd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2002-09-01 at 18:38, Trond Myklebust wrote:
> >>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:
> 
>      > That's what the code did, unless I misunderstood it.  Anyway if
>      > you want to give a different fsuid to a filesystem function,
>      > you either pass credentials as a parameter (that means that you
>      > change all the functions in the call chain to do that) or you
> 
> If you read through the beginning of the thread, you will see that
> this is *exactly* what I'm proposing to do. Just not in this one
> already very large patch.
But you'll need to modify the declaration of the various function
pointers whose implementations might need credentials and modify all
functions that call them and deal with permissions.
Instead with my proposal the credentials are automatically immutable
across the syscall without needing to worry at all about locks, counts
and sharing.

And remember that passing parameters has a cost since you need to push
them and the stack will be larger, occupy more cachelines, and thus
cause more cache misses.
All this without any particular reason to do since normally the
credentials are always the same.

Of course, if you have reason to think that we'll need to call VFS
functions with a lot of differential credential then you are right, but
otherwise you would add just a lot of useless overhead and code
modifications.


--=-60rKL5e8aQpiXyI0kGCd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9cl+xdjkty3ft5+cRAkytAJ9dev8aCxyOweTOxI9rnINqhHxFMwCeLorO
LpAQpSsR/69eIHDzyGUBai0=
=ENs+
-----END PGP SIGNATURE-----

--=-60rKL5e8aQpiXyI0kGCd--
