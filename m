Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWGRPOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWGRPOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWGRPOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:14:15 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:38042 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S932276AbWGRPON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:14:13 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: kernel/timer.c: next_timer_interrupt() strange/buggy(?) code (2.6.18-rc1-mm2)
Date: Tue, 18 Jul 2006 17:14:06 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, keir@xensource.com,
       Tony Lindgren <tony@atomide.com>, zach@vmware.com,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
References: <20060717185330.GA32264@rhlx01.fht-esslingen.de>
In-Reply-To: <20060717185330.GA32264@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1369703.b75ARQU8JA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607181714.10386.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1369703.b75ARQU8JA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag Juli 17 2006 20:53 schrieb Andreas Mohr:
>         for (i =3D 0; i < 4; i++) {
>                 j =3D INDEX(i);
>                 do {
>                         if (list_empty(varray[i]->vec + j)) {
>                                 j =3D (j + 1) & TVN_MASK;
>                                 continue;
>                         }
>                         list_for_each_entry(nte, varray[i]->vec + j, entr=
y)
>                                 if (time_before(nte->expires, expires))
>                                         expires =3D nte->expires;
>                         if (j < (INDEX(i)) && i < 3)
>                                 list =3D varray[i + 1]->vec + (INDEX(i + =
1));
>                         goto found;
>                 } while (j !=3D (INDEX(i)));
>         }
> found:

is equivalent to

  for (i =3D 0; i < 4; i++) {
      j =3D INDEX(i);
      do {
          if (!list_empty(varray[i]->vec + j)) {
              list_for_each_entry(nte, varray[i]->vec + j, entry)
                  if (time_before(nte->expires, expires))
                      expires =3D nte->expires;
              if (j < (INDEX(i)) && i < 3)
                  list =3D varray[i + 1]->vec + (INDEX(i + 1));
              goto found;
          }
          j =3D (j + 1) & TVN_MASK;
      } while (j !=3D (INDEX(i)));
  }
  found:


But probably the code in timer.c takes account of probabilities, thus it is=
 a=20
bit more obscure.

HTH,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1369703.b75ARQU8JA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQBEvPrCxU2n/+9+t5gRAnMSAJ4rvjuIyfYiuS0pVYbrYPj9k5ksiwCg2EZo
9/CV6iEZCJgunDKnrSLZSuY=
=f/dy
-----END PGP SIGNATURE-----

--nextPart1369703.b75ARQU8JA--
