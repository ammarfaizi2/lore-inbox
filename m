Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131689AbQKVWy6>; Wed, 22 Nov 2000 17:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131690AbQKVWys>; Wed, 22 Nov 2000 17:54:48 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:18190 "EHLO
        etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
        id <S131689AbQKVWyn>; Wed, 22 Nov 2000 17:54:43 -0500
Date: Wed, 22 Nov 2000 23:24:16 +0100
From: Kurt Garloff <garloff@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up interrupt entry
Message-ID: <20001122232415.A30911@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>, Andi Kleen <ak@suse.de>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20001118112009.A23763@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001118112009.A23763@gruyere.muc.suse.de>; from ak@suse.de on Sat, Nov 18, 2000 at 11:20:09AM +0100
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2000 at 11:20:09AM +0100, Andi Kleen wrote:
> Index: include/asm-i386/hw_irq.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvs/linux/include/asm-i386/hw_irq.h,v
> retrieving revision 1.11
> diff -u -u -r1.11 hw_irq.h
> --- include/asm-i386/hw_irq.h	2000/05/16 16:08:15	1.11
> +++ include/asm-i386/hw_irq.h	2000/11/18 10:33:48
> @@ -103,9 +107,12 @@
>  	"pushl %edx\n\t" \
>  	"pushl %ecx\n\t" \
>  	"pushl %ebx\n\t" \
> -	"movl $" STR(__KERNEL_DS) ",%edx\n\t" \
                                 ^^^
> -	"movl %edx,%ds\n\t" \
> -	"movl %edx,%es\n\t"
> +	"movl $" STR(__KERNEL_DS),%eax\n\t" \
                                 ^

You missed a ' "'
Apart from that it
(a) makes sense
(b) survived real world usage ...

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6HEePxmLh6hyYd04RAr5FAJ9Fssr+4qW0uD/WuVJxkxlUjNwdXwCffhGk
9bv0VSUdmJNPWEKXFCKQqus=
=pFrK
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
