Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTJRRo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 13:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbTJRRo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 13:44:28 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:56056 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261746AbTJRRoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:44:04 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test7-mm1
Date: Sat, 18 Oct 2003 19:43:38 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20031015013649.4aebc910.akpm@osdl.org>
In-Reply-To: <20031015013649.4aebc910.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_KvXk/gy9rHlF3p+";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310181943.39148.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_KvXk/gy9rHlF3p+
Content-Type: multipart/mixed;
  boundary="Boundary-01=_KvXk/u24jy83e6v"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_KvXk/u24jy83e6v
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Andrew,

On Wednesday 15 October 2003 10:36, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test7=
/2
>.6.0-test7-mm1
  ~~ snip ~~
> +scale-min_free_kbytes.patch
>
>  Scale min_free_kbytes according to machine size.

This patch actually doesn't work, as is uses nr_free_buffer_pages() before =
the=20
zonelists are set up. So min_free_kbytes is always set to 128.

The attached fix works here without a problem, but I'm not sure it doesn't=
=20
break anything...

Regards
   Thomas

P.S.: 1. I've got a ported memsetup-fix from the 2.4 tree, if you want I co=
uld=20
send it to you.
2. Should we consider replacing the bogus int_sqrt() with the fb_sqrt()=20
version? (btw. it is always exact) We could place it somewhere central, so =
it=20
can be used from any place...

--Boundary-01=_KvXk/u24jy83e6v
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix-scale_min_free_pages.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fix-scale_min_free_pages.diff"

=2D-- linux-2.6.0-test7-mm1/init/main.c.orig	Sat Oct 18 19:20:14 2003
+++ linux-2.6.0-test7-mm1/init/main.c	Sat Oct 18 18:58:26 2003
@@ -396,7 +396,6 @@
 	lock_kernel();
 	printk(linux_banner);
 	setup_arch(&command_line);
=2D	init_per_zone_pages_min();
 	setup_per_cpu_areas();
=20
 	/*
@@ -406,6 +405,7 @@
 	smp_prepare_boot_cpu();
=20
 	build_all_zonelists();
+	init_per_zone_pages_min();
 	page_alloc_init();
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_args("Booting kernel", command_line, __start___param,

--Boundary-01=_KvXk/u24jy83e6v--

--Boundary-03=_KvXk/gy9rHlF3p+
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/kXvKYAiN+WRIZzQRAmAWAKCIjPiiaiz/91EdCE8Y78kZFz1yVACggAwb
ZeIhB7ZnAYMIGCvOon1MwA0=
=Dxoy
-----END PGP SIGNATURE-----

--Boundary-03=_KvXk/gy9rHlF3p+--
