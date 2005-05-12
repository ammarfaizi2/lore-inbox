Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVELJCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVELJCa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 05:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVELJAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 05:00:12 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:25889
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261358AbVELI5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:57:04 -0400
Message-Id: <s283286f.070@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Thu, 12 May 2005 10:57:21 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix file2alias for cross builds
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartD2F11E61.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartD2F11E61.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

When doing cross builds for 64-bit targets on 32-bit platforms, 64-bit
types may not have the same alignment on build and target platforms,
causing problems when parsing the ieee1394_device_id structures. This
adds explicit alignment to the 64-bit type used in file2alias.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/scripts/mod/file2alias.c linux-2.6.12-rc4/=
scripts/mod/file2alias.c
--- linux-2.6.12-rc4.base/scripts/mod/file2alias.c	2005-05-11 =
17:28:26.866988056 +0200
+++ linux-2.6.12-rc4/scripts/mod/file2alias.c	2005-05-11 17:50:36.3168809=
52 +0200
@@ -17,7 +17,8 @@
 #if KERNEL_ELFCLASS =3D=3D ELFCLASS32
 typedef Elf32_Addr	kernel_ulong_t;
 #else
-typedef Elf64_Addr	kernel_ulong_t;
+/* This can't be a typedef as otherwise the attribute gets ignored. */
+#define kernel_ulong_t __attribute__((__aligned__(8))) Elf64_Addr
 #endif
 #ifdef __sun__
 #include <inttypes.h>



--=__PartD2F11E61.1__=
Content-Type: text/plain; name="linux-2.6.12-rc4-cross-file2alias.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.12-rc4-cross-file2alias.patch"

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

When doing cross builds for 64-bit targets on 32-bit platforms, 64-bit
types may not have the same alignment on build and target platforms,
causing problems when parsing the ieee1394_device_id structures. This
adds explicit alignment to the 64-bit type used in file2alias.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/scripts/mod/file2alias.c linux-2.6.12-rc4/scripts/mod/file2alias.c
--- linux-2.6.12-rc4.base/scripts/mod/file2alias.c	2005-05-11 17:28:26.866988056 +0200
+++ linux-2.6.12-rc4/scripts/mod/file2alias.c	2005-05-11 17:50:36.316880952 +0200
@@ -17,7 +17,8 @@
 #if KERNEL_ELFCLASS == ELFCLASS32
 typedef Elf32_Addr	kernel_ulong_t;
 #else
-typedef Elf64_Addr	kernel_ulong_t;
+/* This can't be a typedef as otherwise the attribute gets ignored. */
+#define kernel_ulong_t __attribute__((__aligned__(8))) Elf64_Addr
 #endif
 #ifdef __sun__
 #include <inttypes.h>

--=__PartD2F11E61.1__=--
