Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTFKRtn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTFKRtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:49:43 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:45465 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263573AbTFKRti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:49:38 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: "jds" <jds@soltis.cc>, linux-kernel@vger.kernel.org
Subject: Re: problem when compile 2.5.70-mm8
Date: Wed, 11 Jun 2003 20:02:48 +0200
User-Agent: KMail/1.5.9
References: <20030611171334.M36451@soltis.cc>
In-Reply-To: <20030611171334.M36451@soltis.cc>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_I725+fmLDJkIesw";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306112002.48728.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_I725+fmLDJkIesw
Content-Type: multipart/mixed;
  boundary="Boundary-01=_I725+cyxyXI+/ci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_I725+cyxyXI+/ci
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

jds wrote:
> Hi:
>
>    I try the compile kernel 2.5.70-mm8 and recive this messages:
  ~~ snip ~~
>   CC      arch/i386/kernel/setup.o
> arch/i386/kernel/setup.c: In function `setup_early_printk':
> arch/i386/kernel/setup.c:919: invalid lvalue in unary `&'
> make[1]: *** [arch/i386/kernel/setup.o] Error 1
> make: *** [arch/i386/kernel] Error 2
>
>   Help me please;
>
>   Regards.

As posted before the attached patch helps.

If you do not want to use the EARLY_PRINTK feature at all but are too lazy =
to=20
turn it off in the Kernel debug menu explicitly (as I am, too ;-) you may=20
also use the second attached patch wich corrects dependencies in Kconf.

Best regards
   Thomas Schlichter

--Boundary-01=_I725+cyxyXI+/ci
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="early_printk_fix.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="early_printk_fix.diff"

=2D-- linux-2.5.70-mm8/arch/i386/kernel/setup.c.orig	Wed Jun 11 11:10:35 20=
03
+++ linux-2.5.70-mm8/arch/i386/kernel/setup.c	Wed Jun 11 11:11:36 2003
@@ -910,6 +910,7 @@
 extern int __init serial8250_console_init(void);
 void setup_early_printk(void)
 {
+#ifdef CONFIG_SMP
 	/*=20
 	 * printk currently checks cpu_online_map to make sure that
 	 * we don't try to printk from a CPU which hasn't had resources
@@ -917,6 +918,7 @@
 	 * enable here don't require per-cpu resources.
 	 */
 	set_bit(smp_processor_id(), &cpu_online_map);
+#endif
 #ifdef CONFIG_DEBUG_EP_SERIAL
 	console_setup(CONFIG_DEBUG_SERIAL_OPTIONS);
 	serial8250_console_init();

--Boundary-01=_I725+cyxyXI+/ci
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="early_printk_Kconf.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="early_printk_Kconf.diff"

=2D-- linux-2.5.70-mm8/arch/i386/Kconfig.orig	Wed Jun 11 11:23:17 2003
+++ linux-2.5.70-mm8/arch/i386/Kconfig	Wed Jun 11 11:25:25 2003
@@ -1795,7 +1795,7 @@
=20
 config DEBUG_EARLY_PRINTK
 	bool
=2D	depends on !DEBUG_EARLY_PRINTK_OFF
+	depends on DEBUG_EP_SERIAL || DEBUG_EP_VGA
 	default y
=20
 config DEBUG_SERIAL_OPTIONS

--Boundary-01=_I725+cyxyXI+/ci--

--Boundary-03=_I725+fmLDJkIesw
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+527IYAiN+WRIZzQRArjBAJ9UNRVIB2tmE30Xhqqmt8mm4t+hCACfdtH5
FavNL/jabkQOTn1Y2PVUFYM=
=9B2s
-----END PGP SIGNATURE-----

--Boundary-03=_I725+fmLDJkIesw--
