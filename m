Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031382AbWK3Uag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031382AbWK3Uag (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031395AbWK3Uag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:30:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:60374 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1031382AbWK3Uaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:30:35 -0500
X-Authenticated: #815327
From: Malte =?iso-8859-1?q?Schr=F6der?= <MalteSch@gmx.de>
To: David Miller <davem@davemloft.net>
Subject: Re: Linux 2.6.19
Date: Thu, 30 Nov 2006 21:30:19 +0100
User-Agent: KMail/1.9.5
Cc: kernel@linuxace.com, linux-kernel@vger.kernel.org,
       linux-netdev@vger.kernel.org
References: <20061129151111.6bd440f9.rdunlap@xenotime.net> <20061130014904.GA1405@linuxace.com> <20061129.181537.38322733.davem@davemloft.net>
In-Reply-To: <20061129.181537.38322733.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1497331.gEmgpIVQIQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611302130.23556.MalteSch@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1497331.gEmgpIVQIQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 30 November 2006 03:15, David Miller wrote:
> From: Phil Oester <kernel@linuxace.com>
> Date: Wed, 29 Nov 2006 17:49:04 -0800
>
> > Getting an oops on boot here, caused by commit
> > e81c73596704793e73e6dbb478f41686f15a4b34 titled
> > "[NET]: Fix MAX_HEADER setting".
> >
> > Reverting that patch fixes things up for me.  Dave?
>
> I suspect that it might be because I removed the IPV6
> ifdef from the list,  but I can't imagine why that would
> matter other than due to a bug in the IPV6 stack....
>
> Indeed.
>
> Looking at ndisc_send_rs() I wonder if it miscalculates
> 'len' or similar and the old MAX_HEADER setting was
> merely papering around this bug....
>
> In fact it does, the NDISC code is using MAX_HEADER incorrectly.  It
> needs to explicitly allocate space for the struct ipv6hdr in 'len'.
> Luckily the TCP ipv6 code was doing it right.
>
> What a horrible bug, this patch should fix it.  Let me know
> if it doesn't, thanks:

I also encountered this bug (wasn't there in -rc6). The patch also fixes it=
=20
for me.

regards
=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--nextPart1497331.gEmgpIVQIQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFbz9f4q3E2oMjYtURAhlsAJ9IiTwLY3tAxDxjsG0AAn0KlK3XMACfYLSZ
MrrcMaZ5aEEEMTjqoL1z+GQ=
=Mc7J
-----END PGP SIGNATURE-----

--nextPart1497331.gEmgpIVQIQ--
