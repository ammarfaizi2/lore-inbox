Return-Path: <linux-kernel-owner+w=401wt.eu-S1750804AbWLQTUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWLQTUR (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 14:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWLQTUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 14:20:17 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:55225 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbWLQTUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 14:20:15 -0500
X-Originating-Ip: 24.148.236.183
Date: Sun, 17 Dec 2006 14:15:23 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org, Riley@Williams.name
Subject: [PATCH] Use ARRAY_SIZE() macro in i386 relocs.c file
Message-ID: <Pine.LNX.4.64.0612171409340.9120@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Change the explicit code in the relocs.c file to use ARRAY_SIZE()
and add a definition of ARRAY_SIZE() since this is a userspace program
and wouldn't include kernel.h.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  As Randy Dunlap pointed out, the relocs.c file is a userspace
file and wouldn't include kernel.h so it should be fixed manually to
use ARRAY_SIZE().

  I'm submitting this patch for that single file simply because this
file represents the *single* exception to being able to globally make
the change throughout the entire source tree, so taking this file out
of the equation means I don't have to constantly treat it as the
exception, if that's all right.


diff --git a/arch/i386/boot/compressed/relocs.c b/arch/i386/boot/compressed/relocs.c
index 468da89..5b642f4 100644
--- a/arch/i386/boot/compressed/relocs.c
+++ b/arch/i386/boot/compressed/relocs.c
@@ -11,6 +11,7 @@
 #include <endian.h>

 #define MAX_SHDRS 100
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 static Elf32_Ehdr ehdr;
 static Elf32_Shdr shdr[MAX_SHDRS];
 static Elf32_Sym  *symtab[MAX_SHDRS];
@@ -69,7 +70,7 @@ static const char *sym_type(unsigned type)
 #undef SYM_TYPE
 	};
 	const char *name = "unknown sym type name";
-	if (type < sizeof(type_name)/sizeof(type_name[0])) {
+	if (type < ARRAY_SIZE(type_name)) {
 		name = type_name[type];
 	}
 	return name;
@@ -85,7 +86,7 @@ static const char *sym_bind(unsigned bind)
 #undef SYM_BIND
 	};
 	const char *name = "unknown sym bind name";
-	if (bind < sizeof(bind_name)/sizeof(bind_name[0])) {
+	if (bind < ARRAY_SIZE(bind_name)) {
 		name = bind_name[bind];
 	}
 	return name;
@@ -102,7 +103,7 @@ static const char *sym_visibility(unsigned visibility)
 #undef SYM_VISIBILITY
 	};
 	const char *name = "unknown sym visibility name";
-	if (visibility < sizeof(visibility_name)/sizeof(visibility_name[0])) {
+	if (visibility < ARRAY_SIZE(visibility_name)) {
 		name = visibility_name[visibility];
 	}
 	return name;
@@ -126,7 +127,7 @@ static const char *rel_type(unsigned type)
 #undef REL_TYPE
 	};
 	const char *name = "unknown type rel type name";
-	if (type < sizeof(type_name)/sizeof(type_name[0])) {
+	if (type < ARRAY_SIZE(type_name)) {
 		name = type_name[type];
 	}
 	return name;
