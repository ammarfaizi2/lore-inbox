Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267566AbSKQTsP>; Sun, 17 Nov 2002 14:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267568AbSKQTsP>; Sun, 17 Nov 2002 14:48:15 -0500
Received: from ppp-217-133-221-200.dialup.tiscali.it ([217.133.221.200]:47243
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S267566AbSKQTsO>; Sun, 17 Nov 2002 14:48:14 -0500
Subject: Re: [patch] threading fix, tid-2.5.47-A3
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211172132070.13235-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0211172132070.13235-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Sv1cP3XnblYwEofXh0Xq"
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Nov 2002 20:54:35 +0100
Message-Id: <1037562875.1597.107.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Sv1cP3XnblYwEofXh0Xq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The new definition of the clone flags is binary incompatible with older
2.5 kernels.
How about this instead:
#define CLONE_PARENT_SETTID  0x00100000
#define CLONE_CHILD_CLEARTID 0x00200000
#define CLONE_DETACHED	0x00400000
#define CLONE_UNTRACED       0x00800000
#define CLONE_CHILD_SETTID   0x01000000

> -#if CONFIG_SMP || CONFIG_PREEMPT
> +asmlinkage void FASTCALL(schedule_tail(task_t *prev));
>  asmlinkage void schedule_tail(task_t *prev)
>  {
>  	finish_arch_switch(this_rq(), prev);
Maybe finish_arch_switch should only be called if CONFIG_SMP ||
CONFIG_PREEMPT, like what happened without this patch?

> +	if (clone_flags & CLONE_PARENT_SETTID)
> +		put_user(p->pid, parent_tidptr);
How about failing if put_user fails?


--=-Sv1cP3XnblYwEofXh0Xq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA91/P7djkty3ft5+cRAvWUAJ9+807ZXlPswxPRwAacme15zzX4dgCdFjcP
yCck+bmT8VcTTN9BP0abkek=
=AV9T
-----END PGP SIGNATURE-----

--=-Sv1cP3XnblYwEofXh0Xq--
