Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbUJ0UcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbUJ0UcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbUJ0U37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:29:59 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56074 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262630AbUJ0UZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:25:41 -0400
Date: Wed, 27 Oct 2004 22:25:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] Doc/kbuild/makefiles.txt: check_gcc -> cc-option
Message-ID: <20041027202507.GB2713@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

It's not good to show the obsolete check_gcc in an example.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/Documentation/kbuild/makefiles.txt.old	2004-10-27 19:58:24.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/Documentation/kbuild/makefiles.txt	2004-10-27 20:03:24.000000000 +0200
@@ -707,15 +707,17 @@
 	probe supported options:
 
 		#arch/i386/Makefile
- -		check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc \
- -		            /dev/null\ > /dev/null 2>&1; then echo "$(1)"; \
- -		            else echo "$(2)"; fi)
- -		cflags-$(CONFIG_MCYRIXIII) += $(call check_gcc,\
- -		                                     -march=c3,-march=i486)
 
- -		CFLAGS += $(cflags-y)
+		...
+		cflags-$(CONFIG_MPENTIUMII)     += $(call cc-option,\
+						-march=pentium2,-march=i686)
+		...
+		# Disable unit-at-a-time mode ...
+		CFLAGS += $(call cc-option,-fno-unit-at-a-time)
+		...
 
- -	The above examples both utilise the trick that a config option expands
+
+	The first examples utilises the trick that a config option expands
 	to 'y' when selected.
 
     CFLAGS_KERNEL	$(CC) options specific for built-in

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgAQjmfzqmE8StAARAlpgAJwMs91KxFXt6J5CMIxX7CBmU+ck2QCggOtq
79uRYePvlHJEQ+lSKgNzzdQ=
=o4Vo
-----END PGP SIGNATURE-----
