Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269507AbUI3VBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269507AbUI3VBj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269498AbUI3VBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:01:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20688 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269531AbUI3VAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:00:03 -0400
Subject: Re: Compiling a 2.4 driver under 2.6
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Brian McGrew <Brian@doubledimension.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E6456D527ABC5B4DBD1119A9FB461E35019397@constellation.doubledimension.com>
References: <E6456D527ABC5B4DBD1119A9FB461E35019397@constellation.doubledimension.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dJFI9Wr6AwBpfolyhIJ4"
Organization: Red Hat UK
Message-Id: <1096577995.2788.36.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 30 Sep 2004 22:59:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dJFI9Wr6AwBpfolyhIJ4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-09-30 at 22:31, Brian McGrew wrote:

> =3D=3D=3D[ Begin Error Output ]=3D=3D=3D
>=20
> 119_ mk
> /usr/bin/gcc -D__SMP__

oh boy; __SMP__ doesn't exist for 2.4 let alone 2.6



>  -DMODVERSIONS -DEXPORT_SYMTAB=20

this is very broken for 2.6


> -O1

any reason you're not using -O2

> -DCONFIG_MODVERSIONS=20

WTF???

> /usr/include/linux/config.h:5:2: #error Incorrectly using glibc headers f=
or a kernel module

you are using glibc headers for kernel modules. don't do this.


This makefile is quite broken; it needs converting to kbuild

> #ifndef __KERNEL__
> #define __KERNEL__
> #endif

this shouldn't be in modules

>=20
> #ifndef MODULE
> #define MODULE
> #endif

this shouldn't be there either

> #if defined(CONFIG_MODVERSIONS) && !defined(MODVERSIONS)
> # define MODVERSIONS /* force it on */
> #endif

this is broken

>=20
> #if defined(MODVERSIONS) && !defined(__GENKSYMS__)
> #include <linux/modversions.h>
> #include "ibb.ver"
> #endif

never include modversions.h directly
never ever include a .ver directly

>=20
> #ifndef EXPORT_SYMTAB
> #  define EXPORT_SYMTAB /* need this one cause we export ibb_rtc_wakeup *=
/
> #endif

dont do this

>  */
> #define TYPE(dev)   (MINOR(dev) >> 4)  /* high nibble */
> #define NUM(dev)    (MINOR(dev) & 0xf) /* low  nibble */

this doesn't work with 2.7

>=20
> static void ibb_intr(int irq, void *dev_id, struct pt_regs *regs);

this is wrong for 2.6

I stop here because I don't want to get IP contaminated and I just had
something to eat that I don't want to see again ;)
but it's not looking good.


given that this is (really bad) proprietary code, I think you want to
contact the vendor of this code and get him to fix it up.


--=-dJFI9Wr6AwBpfolyhIJ4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBXHPLxULwo51rQBIRAjMEAJ4gZ1d2LX/ArDwBPWPiiinaS7vFTgCdGz2D
aOLMD7CJHdcSt+xMAQYffMw=
=osj9
-----END PGP SIGNATURE-----

--=-dJFI9Wr6AwBpfolyhIJ4--

