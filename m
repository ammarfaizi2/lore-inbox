Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265576AbTFWXRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbTFWXQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:16:30 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:28932 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265576AbTFWXNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:13:38 -0400
Subject: [PATCH] fix in-kernel genksyms for parisc symbols
From: James Bottomley <James.Bottomley@steeleye.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-ITI10m8+ZEG63OKo13HU"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 23 Jun 2003 18:27:43 -0500
Message-Id: <1056410864.1826.57.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ITI10m8+ZEG63OKo13HU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The problem is that the parisc libgcc.a library contains symbols that
look like $$mulI and the like, but genksyms doesn't think $ is legal for
a function symbol, so they all get dropped from the output.  This means
that inserting almost any module on parisc taints the kernel because
these symbols have no version.

The fix (attached below) was to allow $ in an identifier in lex.l (and
obviously to update the _shipped files as well, but my flex/bison seem
to be rather different from the one they were generated with, so I'll
leave that to whomever has the correct versions).

James



--=-ITI10m8+ZEG63OKo13HU
Content-Disposition: attachment; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D scripts/genksyms/lex.l 1.2 vs edited =3D=3D=3D=3D=3D
--- 1.2/scripts/genksyms/lex.l	Wed Feb 19 16:42:13 2003
+++ edited/scripts/genksyms/lex.l	Mon Jun 23 17:17:17 2003
@@ -37,7 +37,7 @@
=20
 %}
=20
-IDENT			[A-Za-z_][A-Za-z0-9_]*
+IDENT			[A-Za-z_\$][A-Za-z0-9_\$]*
=20
 O_INT			0[0-7]*
 D_INT			[1-9][0-9]*

--=-ITI10m8+ZEG63OKo13HU--

