Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268294AbUIWG7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbUIWG7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 02:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268301AbUIWG7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 02:59:20 -0400
Received: from reptilian.maxnet.nu ([212.209.142.131]:24083 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S268294AbUIWG7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 02:59:17 -0400
From: Thomas Habets <thomas@habets.pp.se>
To: Tonnerre <tonnerre@thundrix.ch>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Date: Thu, 23 Sep 2004 08:57:50 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200409230123.30858.thomas@habets.pp.se> <20040923044549.GE6889@thundrix.ch>
In-Reply-To: <20040923044549.GE6889@thundrix.ch>
MIME-Version: 1.0
Message-Id: <200409230857.57145.thomas@habets.pp.se>
Content-Type: multipart/signed;
  boundary="nextPart4690025.KYuJQ1Hisq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4690025.KYuJQ1Hisq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Once upon a midnight dreary, Tonnerre pondered, weak and weary:
> A sysctl is  a bad implementation since you can  only store one single
> string in it.

Yup. What would be a good interface for setting that flag per-process?=20
prctl()?
Personally, I'd prefer it without userspace having to write code for it.

Also, it should be able to protect against a DoS where a user launches N=20
un-OOM-killable processes.

> > +       static char buf[256];
> That 256 should be VM_OOM_PARDON_LEN ?

Nope, it's the binary path len, so PATH_MAX maybe.

> We're under  the task lock, and you  want us to sleep  here?

Oh.. right. Well I don't need that lock if it's just a per-process flag.

> What about programs with spaces in its names?

I thought "screw 'em". :-)

=2D--------
typedef struct me_s {
  char name[]      =3D { "Thomas Habets" };
  char email[]     =3D { "thomas@habets.pp.se" };
  char kernel[]    =3D { "Linux" };
  char *pgpKey[]   =3D { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] =3D { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   =3D { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;

--nextPart4690025.KYuJQ1Hisq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBUnP1KGrpCq1I6FQRAoVtAKDc/AIQ3qTznBXuImRYRptK7x8EuQCfX2oo
9Yu0O1YKh0Co5TAgRe8p8t0=
=7GZT
-----END PGP SIGNATURE-----

--nextPart4690025.KYuJQ1Hisq--
