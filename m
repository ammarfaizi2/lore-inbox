Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTFKJSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 05:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTFKJSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 05:18:16 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:61414 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S264265AbTFKJSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 05:18:09 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Stefano Rivoir <s.rivoir@gts.it>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.70-mm8
Date: Wed, 11 Jun 2003 11:31:42 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030611013325.355a6184.akpm@digeo.com> <3EE6F3B7.9040809@gts.it>
In-Reply-To: <3EE6F3B7.9040809@gts.it>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_/bv5+DzRm0GxNrU";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306111131.43023.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_/bv5+DzRm0GxNrU
Content-Type: multipart/mixed;
  boundary="Boundary-01=_+bv5+CkLkvSTAsl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_+bv5+CkLkvSTAsl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!

Stefano Rivoir wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.=
5.
> >70-mm8/
>
> arch/i386/kernel/setup.c: In function 'setup_early_printk':
> arch/i386/kernel/setup.c:919: error: invalid lvalue in unary '&'
> make[1]: *** [arch/i386/kernel/setup.o] Error 1
>
> Bye

I had the same problem, it occours when the kernel is compiled without SMP=
=20
support and EARLY_PRINTK is not explicitly disabled in the 'Kernel hacking'=
=20
config-section.

The attached patch helps me with this error...

Best regards
   Thomas Schlichter

--Boundary-01=_+bv5+CkLkvSTAsl
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

--Boundary-01=_+bv5+CkLkvSTAsl--

--Boundary-03=_/bv5+DzRm0GxNrU
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+5vb+YAiN+WRIZzQRAoAyAJ9qjgtyNT8KcRd/R9J3wERn35JB8QCg/PDm
u3wmw5i69c2gJ2An30g/+lY=
=WAPt
-----END PGP SIGNATURE-----

--Boundary-03=_/bv5+DzRm0GxNrU--
