Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274433AbRITL7l>; Thu, 20 Sep 2001 07:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274434AbRITL7c>; Thu, 20 Sep 2001 07:59:32 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:27728 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S274433AbRITL7T>; Thu, 20 Sep 2001 07:59:19 -0400
Date: Thu, 20 Sep 2001 13:59:43 +0200
From: Kurt Garloff <garloff@suse.de>
To: John Clemens <john@deater.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [prelim-PATCH] Enable SSE on K7 without BIOS support.
Message-ID: <20010920135943.X9551@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	John Clemens <john@deater.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109192306150.371-100000@pianoman.cluster.toy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ywUhQCikZ2Y3PNw"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109192306150.371-100000@pianoman.cluster.toy>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0ywUhQCikZ2Y3PNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2001 at 11:30:41PM -0400, John Clemens wrote:
> diff -u --recursive linux-orig/arch/i386/kernel/setup.c linux/arch/i386/k=
ernel/setup.c
> --- linux-orig/arch/i386/kernel/setup.c	Wed Sep 19 22:49:11 2001
> +++ linux/arch/i386/kernel/setup.c	Wed Sep 19 22:51:34 2001
> @@ -1272,6 +1272,14 @@
>=20
>  		case 6:	/* An Athlon/Duron. We can trust the BIOS probably */
>  			mcheck_init(c);
> +			if (c->x86_model =3D=3D 6 || c->x86_model =3D=3D 7) {
> +			        rdmsr(MSR_K7_HWCR, l, h);
> +				if ( (h|l) !=3D 0 ) {
> +					printk(KERN_INFO "Palomino/Morgan: Enabling K7/SSE support (your BI=
OS didn't..)\n");
> +					wrmsr(MSR_K7_HWCR, 0, 0);
> +					set_bit(X86_FEATURE_XMM, &c->x86_capability);

After you enabled it via HWCR, cpuid should report the SSE capability, no?
You should check it and not unconditionally enable XMM/SSE support flag,
otherwise it may break on some CPU models.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--0ywUhQCikZ2Y3PNw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7qdouxmLh6hyYd04RAhiZAJsGELULkux4febmABi9GIkDjW/iPwCfZlgS
cK0P+vR9gjmjdQNSJTplVII=
=85VF
-----END PGP SIGNATURE-----

--0ywUhQCikZ2Y3PNw--
