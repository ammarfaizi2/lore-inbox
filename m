Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbTKSDjX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 22:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263822AbTKSDjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 22:39:23 -0500
Received: from reptilian.maxnet.nu ([212.209.142.131]:54540 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S263819AbTKSDjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 22:39:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Habets <thomas@habets.pp.se>
To: sparclinux@vger.kernel.org
Subject: PATCH: forgotten EXPORT_SYMBOL()s on sparc
Date: Wed, 19 Nov 2003 04:38:40 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AMJBP-0003L5-00@reptilian.maxnet.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


These two symbols not exported on sparc made my life (well, my evening
anyway) hell (well... long anyway). I couldn't load a bunch of modules, like
sunrpc and ipv6 until I added them.

Note that these two lines are probably in the wrong place in the file.
Bleh, my mailclient is doing evil things to the patch, but it's only two
lines, so it should be clear.

Also, I wonder what the status is for keyboard, mouse and framebuffer is for
2.6.0 on sparc. None of them seem to work right now.

- --- linux-2.6.0-test9.orig/arch/sparc/kernel/sparc_ksyms.c   2003-10-25
20:42:54.000000000 +0200
+++ linux-2.6.0-test9/arch/sparc/kernel/sparc_ksyms.c       2003-11-19
03:09:46.000000000 +0100
@@ -287,6 +287,8 @@

 /* Networking helper routines. */
 /* XXX This is NOVERS because C_LABEL_STR doesn't get the version number.
 -DaveM */
+EXPORT_SYMBOL(sparc_flush_page_to_ram);
+EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL_NOVERS(__csum_partial_copy_sparc_generic);

 /* No version information on this, heavily used in inline asm,

- ---------
typedef struct me_s {
  char name[]      = { "Thomas Habets" };
  char email[]     = { "thomas@habets.pp.se" };
  char kernel[]    = { "Linux 2.4" };
  char *pgpKey[]   = { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] = { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/uuXAKGrpCq1I6FQRAu3ZAKCrglCwluOp1wt1NXuX78CemjzQuwCbB2rA
OFRBa5wypAiFD/U2EwCVMFg=
=cNKA
-----END PGP SIGNATURE-----
