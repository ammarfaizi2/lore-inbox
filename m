Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWANOhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWANOhI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWANOhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:37:08 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:8606 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932131AbWANOhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:37:02 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: [PATCH] sched - fix interactive typo
Date: Sun, 15 Jan 2006 01:36:35 +1100
User-Agent: KMail/1.9
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
References: <5.2.1.1.2.20060114134639.00c453d0@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20060114134639.00c453d0@pop.gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3369888.LTQhgQEFAO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601150136.38176.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3369888.LTQhgQEFAO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 14 January 2006 23:56, Mike Galbraith wrote:
> Greetings,
>
> At 09:23 PM 1/13/2006 +1100, Con Kolivas wrote:
> >Index: linux-2.6.15/kernel/sched.c
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >--- linux-2.6.15.orig/kernel/sched.c
> >+++ linux-2.6.15/kernel/sched.c
> >@@ -756,26 +756,17 @@ static int recalc_task_prio(task_t *p, u
>
> <snip>
>
> >+                       * If a task was sleeping with the noninteractive
> >+                       * label do not apply this non-linear boost
> >                         */
> >-                       if (p->sleep_type =3D=3D SLEEP_NONINTERACTIVE &&
> > p->mm) { -                               if (p->sleep_avg >=3D
> > INTERACTIVE_SLEEP(p)) -                                       sleep_time
> > =3D 0;
> >-                               else if (p->sleep_avg + sleep_time >=3D
> >-                                               INTERACTIVE_SLEEP(p)) {
> >-                                       p->sleep_avg =3D
> > INTERACTIVE_SLEEP(p); -                                       sleep_time
> > =3D 0;
> >-                               }
> >-                       }
> >+                       if (p->sleep_type !=3D SLEEP_NONINTERACTIVE ||
> > p->mm)
>
> Typo alert.  Looks like that should be ||
> !p->mm.                                     ^

Good catch!=20

That would have hurt like that too.

Andrew please apply to or rollup into interactivity series.

Cheers,
Con
=2D--
=46ix typo thanks Mike Galbraith for spotting.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 kernel/sched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15.orig/kernel/sched.c
+++ linux-2.6.15/kernel/sched.c
@@ -768,7 +768,7 @@ static int recalc_task_prio(task_t *p, u
 			 * If a task was sleeping with the noninteractive
 			 * label do not apply this non-linear boost
 			 */
=2D			if (p->sleep_type !=3D SLEEP_NONINTERACTIVE || p->mm)
+			if (p->sleep_type !=3D SLEEP_NONINTERACTIVE || !p->mm)
 				sleep_time *=3D
 					(MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
=20

--nextPart3369888.LTQhgQEFAO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDyQx2ZUg7+tp6mRURAnU/AJwJ6wifYrZSPotBFTMqxdcf6zOwPgCeJwGZ
JNqVYvye4bvW9CjJdnUfMAQ=
=0EJp
-----END PGP SIGNATURE-----

--nextPart3369888.LTQhgQEFAO--
