Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVL2Qlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVL2Qlt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVL2QlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:41:16 -0500
Received: from host3-98.pool876.interbusiness.it ([87.6.98.3]:53154 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750816AbVL2Qks
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:40:48 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 4/5] Hostfs: update for new glibc - add missing symbol exports
Date: Thu, 29 Dec 2005 17:39:59 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051229163959.4985.38748.stgit@zion.home.lan>
In-Reply-To: <20051229163803.4985.66742.stgit@zion.home.lan>
References: <20051229163803.4985.66742.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Today, when compiling UML, I got warnings for two used unexported symbols:
readdir64 and truncate64. Indeed, my glibc headers are aliasing readdir to
readdir64 and truncate to truncate64 (and so on).

I'm then adding additional exports. Since I've no idea if the symbols where
always provided in the supported glibc's, I've added weak definitions too.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/user_syms.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 56d3f87..8da6ab3 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -34,6 +34,11 @@ EXPORT_SYMBOL(strstr);
        int sym(void);                  \
        EXPORT_SYMBOL(sym);
 
+extern void readdir64(void) __attribute__((weak));
+EXPORT_SYMBOL(readdir64);
+extern void truncate64(void) __attribute__((weak));
+EXPORT_SYMBOL(truncate64);
+
 #ifdef SUBARCH_i386
 EXPORT_SYMBOL(vsyscall_ehdr);
 EXPORT_SYMBOL(vsyscall_end);

