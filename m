Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269857AbTGKJzG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 05:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269866AbTGKJzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 05:55:06 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:10735 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S269857AbTGKJzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 05:55:00 -0400
Subject: Re: [PATCH/RFC] Deprecate sysctl(2), add sysctl_name
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030711091630.GA2707@wotan.suse.de>
References: <20030711014154.GA15238@wotan.suse.de>
	 <Pine.LNX.4.44.0307101932510.5551-100000@home.osdl.org>
	 <20030711091630.GA2707@wotan.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-y0pJamtGsunzUSfvVtdm"
Organization: Red Hat, Inc.
Message-Id: <1057918176.5804.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 11 Jul 2003 12:09:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y0pJamtGsunzUSfvVtdm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> --- linux-2.5/kernel/sysctl.c	2003-07-04 23:52:20.000000000 +0200
> +++ linux-2.5-amd64/kernel/sysctl.c	2003-07-11 03:25:18.000000000 +0200
> @@ -823,7 +838,16 @@
> =20
>  	if (copy_from_user(&tmp, args, sizeof(tmp)))
>  		return -EFAULT;
> -	=09
> +=09
> +	if (tmp.nlen !=3D 2 || tmp.name[0] !=3D CTL_KERN ||
> +	    tmp.name[1] !=3D KERN_VERSION) {=20
> +		int i;
> +		printk(KERN_INFO "%s: numerical sysctl ", current->comm);=20
> +		for (i =3D 0; i < tmp.nlen; i++)=20
> +			printk("%d ", tmp.name[i]);=20
> +		printk("is obsolete.\n");
> +	}=20
> +
>  	lock_kernel();

how about rate limiting this ?

--=-y0pJamtGsunzUSfvVtdm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/DozgxULwo51rQBIRAqSTAJ9WwpL8V3DEmm3+IbIHL0A0GvuX1gCdH2Tq
jhJSHIvnOyoDFSoCTVYvWTo=
=sgnE
-----END PGP SIGNATURE-----

--=-y0pJamtGsunzUSfvVtdm--
