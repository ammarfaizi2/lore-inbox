Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266203AbSKONXB>; Fri, 15 Nov 2002 08:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266236AbSKONXB>; Fri, 15 Nov 2002 08:23:01 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:45060 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S266203AbSKONXA>;
	Fri, 15 Nov 2002 08:23:00 -0500
Date: Fri, 15 Nov 2002 16:29:08 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: PC-9800 patch for 2.5.47-ac4: not merged yet (15/15) SMP
Message-ID: <20021115132908.GB552@pazke.ipt>
Mail-Followup-To: Osamu Tomita <tomita@cinet.co.jp>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	LKML <linux-kernel@vger.kernel.org>
References: <3DD4E2D5.AEF13F1@cinet.co.jp> <3DD4F1D9.A4F58358@cinet.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <3DD4F1D9.A4F58358@cinet.co.jp>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On =D0=9F=D1=82=D0=BD, =D0=9D=D0=BE=D1=8F 15, 2002 at 10:08:41 +0900, Osamu=
 Tomita wrote:
> This is for SMP support.
=20
>  void __init find_smp_config (void)
>  {
> +#ifndef CONFIG_PC9800
>  	unsigned int address;
> +#endif
> =20
>  	/*
>  	 * FIXME: Linux assumes you have 640K of base ram..
> @@ -762,6 +793,7 @@
>  		smp_scan_config(639*0x400,0x400) ||
>  			smp_scan_config(0xF0000,0x10000))
>  		return;
> +#ifndef CONFIG_PC9800	/* PC-9800 has no EBDA area? */
>  	/*
>  	 * If it is an SMP machine we should know now, unless the
>  	 * configuration is in an EISA/MCA bus machine with an
> @@ -784,6 +816,7 @@
>  	smp_scan_config(address, 0x400);
>  	if (smp_found_config)
>  		printk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, cont=
act linux-smp@vger.kernel.org if you experience SMP problems!\n");
> +#endif
>  }

Can you redo this fragment this way ?

#ifndef CONFIG_PC9800	/* PC-9800 has no EBDA area? */
	{
		unsigned int address =3D *(unsigned short *)phys_to_virt(0x40E);
		address <<=3D 4;
		smp_scan_config(address, 0x400);
		if (smp_found_config)
			printk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contac=
t linux-smp@vger.kernel.org if you experience SMP problems!\n");
	}
#endif

IMHO this is better way (one #ifndef less)

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE91PakBm4rlNOo3YgRAhYfAJUTxJBb7LzspoNt9nEuu8TSvrlIAJ4lPCB9
LbsYguqDan/2GuxKQhtmVA==
=BOsk
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
