Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVFSTi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVFSTi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 15:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVFSTi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 15:38:59 -0400
Received: from mout1.freenet.de ([194.97.50.132]:13440 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261285AbVFSTij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 15:38:39 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH] Small kfree cleanup, save a local variable.
Date: Sun, 19 Jun 2005 21:37:59 +0200
User-Agent: KMail/1.8.1
References: <Pine.LNX.4.62.0506192129300.2832@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0506192129300.2832@dragon.hyggekrogen.localhost>
Cc: "Rickard E. (Rik) Faith" <faith@redhat.com>, Rik Faith <faith@cs.unc.edu>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1384936.RcNcu8b3Mk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506192137.59719.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1384936.RcNcu8b3Mk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Jesper Juhl <juhl-lkml@dif.dk>:
> Here's a patch with a small improvement to kernel/auditsc.c .
> There's no need for the local variable  struct audit_entry *e  ,=20
> we can just call kfree directly on container_of() .

Did you look at the assembly output? Does it change?
I think the compiler optimizes this variable away, anyway.
So, if there's no improvement, I would personally prefer the
original form as it's more readable.

>  kernel/auditsc.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>=20
> --- linux-2.6.12-orig/kernel/auditsc.c	2005-06-17 21:48:29.000000000 +0200
> +++ linux-2.6.12/kernel/auditsc.c	2005-06-19 21:21:37.000000000 +0200
> @@ -202,8 +202,7 @@ static inline int audit_add_rule(struct=20
> =20
>  static void audit_free_rule(struct rcu_head *head)
>  {
> -	struct audit_entry *e =3D container_of(head, struct audit_entry, rcu);
> -	kfree(e);
> +	kfree(container_of(head, struct audit_entry, rcu));
>  }

=2D-=20
Greetings, Michael



--nextPart1384936.RcNcu8b3Mk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCtcmXFGK1OIvVOP4RAkyMAKCvkYk0UoKKTZnEPhwNRmvn6hyDkwCfeCel
1199zFK/rZi/DbOpTJP8ulk=
=/dke
-----END PGP SIGNATURE-----

--nextPart1384936.RcNcu8b3Mk--
