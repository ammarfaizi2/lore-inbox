Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbTIRIF5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 04:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTIRIF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 04:05:57 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:60143 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263017AbTIRIFz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 04:05:55 -0400
Subject: Re: fix off-by-one error in ioremap()
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: len.brown@intel.com
In-Reply-To: <200309172107.h8HL7UBf011628@hera.kernel.org>
References: <200309172107.h8HL7UBf011628@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hUpyw5ccu3FzSej+mtO8"
Organization: Red Hat, Inc.
Message-Id: <1063872336.5026.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Thu, 18 Sep 2003 10:05:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hUpyw5ccu3FzSej+mtO8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-09-12 at 10:15, Linux Kernel Mailing List wrote:
> ChangeSet 1.1063.43.5, 2003/09/12 04:15:36-04:00, len.brown@intel.com
>=20
> 	fix off-by-one error in ioremap()
> 	fixes kernel crash in acpi mode: http://bugzilla.kernel.org/show_bug.cgi=
?id=3D1085

> diff -Nru a/arch/i386/mm/ioremap.c b/arch/i386/mm/ioremap.c
> --- a/arch/i386/mm/ioremap.c	Wed Sep 17 14:07:31 2003
> +++ b/arch/i386/mm/ioremap.c	Wed Sep 17 14:07:31 2003
> @@ -140,7 +140,7 @@
>  	 */
>  	offset =3D phys_addr & ~PAGE_MASK;
>  	phys_addr &=3D PAGE_MASK;
> -	size =3D PAGE_ALIGN(last_addr) - phys_addr;
> +	size =3D PAGE_ALIGN(last_addr+1) - phys_addr;
> =20


A bit higher in that function is:
                                                                           =
                            =20
        /* Don't allow wraparound or zero size */
        last_addr =3D phys_addr + size - 1;
        if (!size || last_addr < phys_addr)
                return NULL;
                                                                           =
                            =20

so why do you undo the deliberate -1 there ?

--=-hUpyw5ccu3FzSej+mtO8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/aWdQxULwo51rQBIRAnsdAJkB2KQ8wulIAjJKrkdj0cmVfz3fowCdH9po
Ej7WDG3W8Enh2QJmpiQ/tBk=
=nXqm
-----END PGP SIGNATURE-----

--=-hUpyw5ccu3FzSej+mtO8--
