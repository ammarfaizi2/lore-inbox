Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVCQIUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVCQIUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 03:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVCQIUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 03:20:36 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:49119 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261850AbVCQITx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 03:19:53 -0500
Date: Thu, 17 Mar 2005 10:19:51 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4
Message-ID: <20050317081951.GF5037@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050316040654.62881834.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline
In-Reply-To: <20050316040654.62881834.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2005 at 04:06:54AM -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.=
11-mm4/
>=20
sh and sh64 need xlate_dev_mem_ptr/xlate_dev_kmem_ptr definitions too..
otherwise end up with:

  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0xf0): In function `read_mem':
mem.c: undefined reference to `xlate_dev_mem_ptr'
drivers/built-in.o(.text+0x210): In function `write_mem':
mem.c: undefined reference to `xlate_dev_mem_ptr'
drivers/built-in.o(.text+0x478): In function `read_kmem':
mem.c: undefined reference to `xlate_dev_kmem_ptr'
drivers/built-in.o(.text+0x628): In function `write_kmem':
mem.c: undefined reference to `xlate_dev_kmem_ptr'
make: *** [.tmp_vmlinux1] Error 1

 include/asm-sh/io.h   |   11 +++++++++++
 include/asm-sh64/io.h |   11 +++++++++++
 2 files changed, 22 insertions(+)

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

--- linux-sh-2.6.11-mm4.orig/include/asm-sh/io.h	2005-03-17 10:10:56.911518=
490 +0200
+++ linux-sh-2.6.11-mm4/include/asm-sh/io.h	2005-03-17 10:11:35.164242096 +=
0200
@@ -295,6 +295,17 @@
 #define dma_cache_wback(_start,_size) \
     __flush_wback_region(_start,_size)
=20
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif /* __KERNEL__ */
=20
 #endif /* __ASM_SH_IO_H */
--- linux-sh-2.6.11-mm4.orig/include/asm-sh64/io.h	2005-03-17 10:11:44.1879=
97628 +0200
+++ linux-sh-2.6.11-mm4/include/asm-sh64/io.h	2005-03-17 10:12:26.554154928=
 +0200
@@ -235,5 +235,16 @@
 		asm volatile ("ocbwb	%0, 0" : : "r" (s));
 }
=20
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_SH64_IO_H */

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCOT2n1K+teJFxZ9wRAqZDAJ4ukcfZaobFENZhONTBGtbNxbetzgCdFam6
lKpzJGj0Cgi8ZPh+orqE1pI=
=lHpY
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
