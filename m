Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTEBBfk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 21:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTEBBfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 21:35:40 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:42674 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262861AbTEBBfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 21:35:33 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: dphillips@sistina.com, Willy Tarreau <willy@w.ods.org>,
       hugang <hugang@soulinfo.com>
Subject: Re: [RFC][PATCH] Faster generic_fls
Date: Fri, 2 May 2003 03:47:37 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200304300446.24330.dphillips@sistina.com> <20030502001050.GA25789@alpha.home.local> <200305020243.15248.dphillips@sistina.com>
In-Reply-To: <200305020243.15248.dphillips@sistina.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_+4cs+TlGQCe6jly";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305020347.42682.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_+4cs+TlGQCe6jly
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On May 2, Daniel Phillips wrote:
> On Friday 02 May 2003 02:10, Willy Tarreau wrote:
> > At first, I thought you had coded an FFS instead of an FLS. But I
> > realized it's valid, and is fast because one half of the numbers tested
> > will not even take one iteration.
>
> Aha, and duh.  At 1 million iterations, my binary search clobbers the shi=
ft
> version by a factor of four.  At 2**31 iterations, my version also wins, =
by
> 20%.
>
> I should note that the iterations parameter to my benchmark program is
> deeply flawed, since it changes the nature of the input set, not just the
> number of iterations.  Fortunately, all tests I've done have been with
> 2**32 iterations, giving a perfectly uniform distribution of input values.

That is what I posted in my first message in this thread... The shift=20
algorithm only works fine for uniform distributed input values... But here =
is=20
a version that behaves better for small values, too. I don't think it will=
=20
reach the tree version but it should be much better that the old version!

int fls_shift(int x)
{
	int bit;

	if(x & 0xFFFF0000) {
		bit =3D 32;
=20
		while(x > 0) {
			--bit;
			x <<=3D 1;
		}
	} else {
		bit =3D 0;
=20
		while(x) {
			++bit;
			x >>=3D 1;
		}
	}

	return bit;
}

=46or me this version even speeds up the uniform distributed benchmark...

> For uniformly distributed inputs the simple shift loop does well, but for
> calculating floor(log2(x)) it's much worse than the fancier alternatives.=
=20
> I suspect typical usage leans more to the latter than the former.

If this is the case the tree version will surely be the best!

But I think this topic is not worth any further work as this is not used ve=
ry=20
often... So this version will be my last one!

But this was a good example how suited algorithms can speed up benchmarks ;=
=2D)

> Regards,
>
> Daniel

Best regards
  Thomas
--Boundary-02=_+4cs+TlGQCe6jly
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+sc4+YAiN+WRIZzQRAhmhAJ9Hgyeyud639a9ePxGInIN8/1GYiACfb2XE
6dk+DgB1lt9SWR2xPYNPURw=
=iuxC
-----END PGP SIGNATURE-----

--Boundary-02=_+4cs+TlGQCe6jly--

