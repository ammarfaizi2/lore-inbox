Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSIATOL>; Sun, 1 Sep 2002 15:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSIATOL>; Sun, 1 Sep 2002 15:14:11 -0400
Received: from ppp-217-133-221-133.dialup.tiscali.it ([217.133.221.133]:29330
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317373AbSIATOK>; Sun, 1 Sep 2002 15:14:10 -0400
Subject: [PATCH] Re: 2.5.33 PNPBIOS does not compile
From: Luca Barbieri <ldb@ldb.ods.org>
To: Nicholas Miell <nmiell@attbi.com>, Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1030864488.21055.25.camel@entropy>
References: <1030864488.21055.25.camel@entropy>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-3SaQh3XeWhaxwPEKs2jQ"
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Sep 2002 21:18:30 +0200
Message-Id: <1030907910.1993.110.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3SaQh3XeWhaxwPEKs2jQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2002-09-01 at 09:14, Nicholas Miell wrote:
> pnpbios_core.c: In function `call_pnp_bios':
> pnpbios_core.c:167: invalid lvalue in unary `&'
> pnpbios_core.c:167: invalid lvalue in unary `&'
> pnpbios_core.c:169: invalid lvalue in unary `&'
> pnpbios_core.c:169: invalid lvalue in unary `&'
> pnpbios_core.c: In function `pnpbios_init':
> pnpbios_core.c:1276: invalid lvalue in unary `&'
> pnpbios_core.c:1276: invalid lvalue in unary `&'
> pnpbios_core.c:1277: invalid lvalue in unary `&'
> pnpbios_core.c:1277: invalid lvalue in unary `&'
> pnpbios_core.c:1278: invalid lvalue in unary `&'
> pnpbios_core.c:1278: invalid lvalue in unary `&'
> make[2]: *** [pnpbios_core.o] Error 1
> make[2]: Target `first_rule' not remade because of errors.
> make[1]: *** [pnp] Error 2
> 
> ... which is the result of the expansion of the Q_SET_SEL and Q2_SET_SEL
> macros. 
Yes, this should fix the problem.

diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32/drivers/pnp/pnpbios_core.c linux-2.5.32_pnpbelow/drivers/pnp/pnpbios_core.c
--- linux-2.5.32/drivers/pnp/pnpbios_core.c	2002-08-27 21:26:32.000000000 +0200
+++ linux-2.5.32_pnpbelow/drivers/pnp/pnpbios_core.c	2002-08-31 18:38:38.000000000 +0200
@@ -127,11 +127,11 @@ __asm__(
 
 #define Q_SET_SEL(cpu, selname, address, size) \
 set_base(cpu_gdt_table[cpu][(selname) >> 3], __va((u32)(address))); \
-set_limit(&cpu_gdt_table[cpu][(selname) >> 3], size)
+set_limit(cpu_gdt_table[cpu][(selname) >> 3], size)
 
 #define Q2_SET_SEL(cpu, selname, address, size) \
 set_base(cpu_gdt_table[cpu][(selname) >> 3], (u32)(address)); \
-set_limit(&cpu_gdt_table[cpu][(selname) >> 3], size)
+set_limit(cpu_gdt_table[cpu][(selname) >> 3], size)
 
 /*
  * At some point we want to use this stack frame pointer to unwind


--=-3SaQh3XeWhaxwPEKs2jQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9cmgGdjkty3ft5+cRAsVUAKDAivDFdGP/ud6vwURPJ0a/3KJLCQCglZ2w
ibXB/JW2z9ZMOL8enZphzQg=
=hqhg
-----END PGP SIGNATURE-----

--=-3SaQh3XeWhaxwPEKs2jQ--
