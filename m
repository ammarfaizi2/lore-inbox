Return-Path: <linux-kernel-owner+w=401wt.eu-S1751078AbXACTSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbXACTSz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbXACTSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:18:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:40694 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751078AbXACTSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:18:53 -0500
X-Authenticated: #815327
From: Malte =?iso-8859-1?q?Schr=F6der?= <MalteSch@gmx.de>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Subject: Re: [BUG] panic 2.6.20-rc3 in nf_conntrack
Date: Wed, 3 Jan 2007 20:18:47 +0100
User-Agent: KMail/1.9.5
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
       Patrick McHardy <kaber@trash.net>, berni@birkenwald.de,
       netfilter-devel@lists.netfilter.org
References: <200701020228_MC3-1-D707-115D@compuserve.com> <Pine.LNX.4.58.0701030913470.8163@tux.rsn.bth.se>
In-Reply-To: <Pine.LNX.4.58.0701030913470.8163@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2684199.Im7JhXbk7i";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701032018.51184.MalteSch@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2684199.Im7JhXbk7i
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 03 January 2007 09:34, Martin Josefsson wrote:
> I saw your (correct) analysis after having made the patch below, it has
> been tested successfully by Bernhard Schmidt. (Netfilter bugzilla #528)
>
> Check the return value of nfct_nat() in device_cmp(), we might very well
> have non NAT conntrack entries as well.
>

I was not capable to reproduce the problem. Thanks :)

> Signed-off-by: Martin Josefsson <gandalf@wlug.westbo.se>
>
> --- linux-2.6.20-rc3/net/ipv4/netfilter/ipt_MASQUERADE.c.orig	2007-01-02
> 22:47:14.000000000 +0100 +++
> linux-2.6.20-rc3/net/ipv4/netfilter/ipt_MASQUERADE.c	2007-01-02
> 22:57:11.000000000 +0100 @@ -127,10 +127,13 @@
>  static inline int
>  device_cmp(struct ip_conntrack *i, void *ifindex)
>  {
> +	int ret;
>  #ifdef CONFIG_NF_NAT_NEEDED
>  	struct nf_conn_nat *nat =3D nfct_nat(i);
> +
> +	if (!nat)
> +		return 0;
>  #endif
> -	int ret;
>
>  	read_lock_bh(&masq_lock);
>  #ifdef CONFIG_NF_NAT_NEEDED

=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--nextPart2684199.Im7JhXbk7i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFnAGb4q3E2oMjYtURAqkpAJ9QhAejAG/O3pkP1pSwy9j6aAsNbQCfYokT
5/C4cjWTyICS2WUKBubm57U=
=jjFi
-----END PGP SIGNATURE-----

--nextPart2684199.Im7JhXbk7i--
