Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSIAO3V>; Sun, 1 Sep 2002 10:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSIAO3V>; Sun, 1 Sep 2002 10:29:21 -0400
Received: from ppp-217-133-221-133.dialup.tiscali.it ([217.133.221.133]:47069
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317072AbSIAO3T>; Sun, 1 Sep 2002 10:29:19 -0400
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
From: Luca Barbieri <ldb@ldb.ods.org>
To: trond.myklebust@fys.uio.no
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <15730.4100.308481.326297@charged.uio.no>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb> <15729.17279.474307.914587@charged.uio.no>
	<1030835635.1422.39.camel@ldb>  <15730.4100.308481.326297@charged.uio.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-vX+kF6rqr2P1Uzuqpigc"
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Sep 2002 16:33:41 +0200
Message-Id: <1030890821.2145.67.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vX+kF6rqr2P1Uzuqpigc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2002-09-01 at 15:03, Trond Myklebust wrote:
> >>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:
> 
>      > For example, rather than this;
> <snip>
> 
>      > you can just do this:
>      > - uid_t saved_fsuid = current->fsuid;
>      > +               uid_t saved_fsuid = current->fscred.uid;
>      >                 kernel_cap_t saved_cap =
>      >                 current->cap_effective;
>  
> But I don't want to have to do that at all. Why should I change the
> actual task's privileges in order to call down into a single VFS
> function?
> The point of VFS support for credentials is to eliminate these hacks,
> and cut down on all this gratuitous changing of privilege. That's what
> we want the API changes for.
That's what the code did, unless I misunderstood it.
Anyway if you want to give a different fsuid to a filesystem function,
you either pass credentials as a parameter (that means that you change
all the functions in the call chain to do that) or you modify a
structure present or referenced from the task_struct (or you disable
preemption and use a per-cpu variable, but this would be a very bad idea
here).

Furthermore if no one except the current task can access/modify the task
credentials the "gratuitous changing of privileges" is only seen by the
VFS function you call, so it is fine (it may not be conceptually
elegant, but that should not be preferred over being fast and minimally
intrusive).


--=-vX+kF6rqr2P1Uzuqpigc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9ciVFdjkty3ft5+cRAnQPAJsGoF7EN2YEulicz2nhQqQZdsPXNQCeIqec
6yVrYF3LyRAYMlXgQ9uxjtw=
=jf1s
-----END PGP SIGNATURE-----

--=-vX+kF6rqr2P1Uzuqpigc--
