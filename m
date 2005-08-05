Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVHESPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVHESPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbVHESNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:13:43 -0400
Received: from imap.gmx.net ([213.165.64.20]:62093 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262845AbVHESMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:12:00 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] preempt-trace-fixes.patch
Date: Fri, 5 Aug 2005 20:14:48 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050607042931.23f8f8e0.akpm@osdl.org> <200508051344.58848.dominik.karall@gmx.net> <20050805151312.GA3284@elte.hu>
In-Reply-To: <20050805151312.GA3284@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3726008.OLuaum78zj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508052014.50336.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3726008.OLuaum78zj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 05 August 2005 17:13, Ingo Molnar wrote:
> * Dominik Karall <dominik.karall@gmx.net> wrote:
> > > yeah. I've done this today and have split it out of the -RT tree, see
> > > the patch below. After some exposure in -mm i'd like this feature to =
go
> > > upstream too.
> > >
> > > the patch is against recent Linus trees, 2.6.13-rc4 or later should a=
ll
> > > work. Dominik, could you try it and send us the new kernel logs
> > > whenever you happen to hit that warning message again? (Please also
> > > enable CONFIG_KALLSYMS_ALL, so that we get as much symbolic data as
> > > possible.)
> >
> > I tried to compile the patch on top of 2.6.13-rc4-mm1, it applied with a
> > few offsets, but it looked ok.
> > Here is the error I get when I compiled it:
>
> ok, does the additional patch below fix things for you?

Yes, only out_count wasn't defined in softirq.c, here's the patch to fix it=
=2E=20
The first patch in traps.c failed on rc4-mm1, but it doesn't matter, as=20
sched.h seems to be already included there. I think it is even included in=
=20
=2Drc4 too.

dominik

=2D----

=2D-- linux/kernel/softirq.c.orig 2005-08-05 20:00:28.000000000 +0200
+++ linux/kernel/softirq.c      2005-08-05 20:02:40.000000000 +0200
@@ -93,7 +93,7 @@ restart:
        do {
                if (pending & 1) {
 #ifdef CONFIG_DEBUG_PREEMPT
=2D                       u32 in_count =3D preempt_count();
+                       u32 in_count =3D preempt_count(), out_count;
 #endif
                        h->action(h);
 #ifdef CONFIG_DEBUG_PREEMPT

--nextPart3726008.OLuaum78zj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQvOsmgvcoSHvsHMnAQJ0KAP9EMOTcyC/6MPfj5o3lSdEIHvqHaCQLaEH
6+gEG3fjKtiq6oeuMyeT92Nqi/67j1DS8dT1Ohuc6nDkeePJ11HFEW4SiKv5rn8U
MBjh72bsH5Yn2dJ0z81aXmiKkrEPer2f6SK4Z+bhEkNQ6i6cZs6Ejsc0DhH9U7PG
wxyZREFRpi8=
=N4AN
-----END PGP SIGNATURE-----

--nextPart3726008.OLuaum78zj--
