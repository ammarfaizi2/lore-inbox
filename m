Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263046AbSJBLKQ>; Wed, 2 Oct 2002 07:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263047AbSJBLKQ>; Wed, 2 Oct 2002 07:10:16 -0400
Received: from host213-121-105-39.in-addr.btopenworld.com ([213.121.105.39]:18897
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S263046AbSJBLKP>; Wed, 2 Oct 2002 07:10:15 -0400
Subject: Re: [patch] kksymoops-2.5.38-C9
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209261536020.18328-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209261536020.18328-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-92uThaWeSb93Qd2gCWy3"
Organization: 
Message-Id: <1033557365.27033.75.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 02 Oct 2002 12:16:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-92uThaWeSb93Qd2gCWy3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-09-26 at 15:01, Ingo Molnar wrote:
> --- linux/Makefile.orig	Thu Sep 26 15:26:53 2002
> +++ linux/Makefile	Thu Sep 26 15:27:16 2002
> @@ -138,6 +138,7 @@
>  MAKEFILES	=3D $(TOPDIR)/.config
>  GENKSYMS	=3D /sbin/genksyms
>  DEPMOD		=3D /sbin/depmod
> +KALLSYMS	=3D /sbin/kallsyms
>  PERL		=3D perl
>  MODFLAGS	=3D -DMODULE
>  CFLAGS_MODULE   =3D $(MODFLAGS)
> @@ -291,32 +292,64 @@
>  vmlinux-objs :=3D $(HEAD) $(INIT) $(CORE_FILES) $(LIBS) $(DRIVERS) $(NET=
WORKS)

Ingo, this breaks cross compiles because kallsyms expects a host
executable:

$ /sbin/kallsyms .tmp_vmlinux > .tmp_kallsyms.o
.tmp_vmlinux: ELF file .tmp_vmlinux not for this architecture

You can't even do $(CROSS_COMPILE)kallsyms because that isn't part of
most peoples toolchains. (and /sbin might not be in the $PATH).

I'm not sure what kallsyms does *exactly* but it sounds like the same
functionality can be had from objcopy...

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-92uThaWeSb93Qd2gCWy3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9mtV1kbV2aYZGvn0RArBtAJ4yGEgsbyXMRHkITB5fHnDHBzOJFgCfday9
AdZn5//nygF/VwbsbjGdjYQ=
=Ctx/
-----END PGP SIGNATURE-----

--=-92uThaWeSb93Qd2gCWy3--

