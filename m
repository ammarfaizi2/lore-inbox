Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbTFBNc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 09:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTFBNc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 09:32:58 -0400
Received: from ik-dynamic-66-102-74-246.kingston.net ([66.102.74.246]:19975
	"EHLO linux.interlinx.bc.ca") by vger.kernel.org with ESMTP
	id S262320AbTFBNc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 09:32:56 -0400
Subject: Re: [PATCH][2.5] Honour dont_enable_local_apic flag
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.50.0306011950080.31534-100000@montezuma.mastecende.com>
References: <200306012308.h51N8K6j001404@harpo.it.uu.se>
	 <1054511535.6676.85.camel@pc>
	 <Pine.LNX.4.50.0306011950080.31534-100000@montezuma.mastecende.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fOp4BSGZ06AOUTWQ3YAA"
Message-Id: <1054561578.22451.19.camel@pc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3-1mdk (Preview Release)
Date: 02 Jun 2003 09:46:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fOp4BSGZ06AOUTWQ3YAA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-06-02 at 00:50, Zwane Mwaikambo wrote:
> I agree with doing the clear apic capability flag,

Indeed.  I sure does seem to be the right way to go.

>  Brian how does this=20
> fare? This patch alone should fix it.

It looks good and will try it out.  But before I do, should not:

	set_bit(X86_FEATURE_APIC, &disabled_x86_caps);

also be done?

>=20
> Index: linux-2.5/arch/i386/kernel/apic.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /home/cvs/linux-2.5/arch/i386/kernel/apic.c,v
> retrieving revision 1.54
> diff -u -p -B -r1.54 apic.c
> --- linux-2.5/arch/i386/kernel/apic.c	31 May 2003 19:01:05 -0000	1.54
> +++ linux-2.5/arch/i386/kernel/apic.c	2 Jun 2003 03:50:31 -0000
> @@ -609,7 +609,7 @@ static int __init detect_init_APIC (void
> =20
>  	/* Disabled by DMI scan or kernel option? */
>  	if (dont_enable_local_apic)
> -		return -1;
> +		goto no_apic;
> =20
>  	/* Workaround for us being called before identify_cpu(). */
>  	get_cpu_vendor(&boot_cpu_data);
> @@ -665,6 +665,7 @@ static int __init detect_init_APIC (void
>  	return 0;
> =20
>  no_apic:
> +	clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
>  	printk("No local APIC present or hardware disabled\n");
>  	return -1;
>  }

b.

--=20
Brian J. Murrell <brian@interlinx.bc.ca>

--=-fOp4BSGZ06AOUTWQ3YAA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+21Uql3EQlGLyuXARAr6dAKCXsXhhnjJ/JpCUpniOW0bSlNaiKwCfTUqR
8eloROxk2UM4smCc2futom0=
=+lTm
-----END PGP SIGNATURE-----

--=-fOp4BSGZ06AOUTWQ3YAA--
