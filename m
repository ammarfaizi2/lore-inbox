Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWGMLXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWGMLXA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 07:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWGMLXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 07:23:00 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:27049 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932066AbWGMLXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 07:23:00 -0400
Date: Thu, 13 Jul 2006 13:22:38 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] correct oldconfig for unset choice options
Message-ID: <Pine.LNX.4.64.0607131315230.12900@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oldconfig currently ignores unset choice options and doesn't ask for them.
Correct the SYMBOL_DEF_USER flag of the choice symbol to be only set if 
it's set for all values.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---
 scripts/kconfig/confdata.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-mm/scripts/kconfig/confdata.c
===================================================================
--- linux-2.6-mm.orig/scripts/kconfig/confdata.c	2006-07-12 11:58:59.000000000 +0200
+++ linux-2.6-mm/scripts/kconfig/confdata.c	2006-07-12 12:17:20.000000000 +0200
@@ -357,7 +357,7 @@ int conf_read(const char *name)
 		for (e = prop->expr; e; e = e->left.expr)
 			if (e->right.sym->visible != no)
 				flags &= e->right.sym->flags;
-		sym->flags |= flags & SYMBOL_DEF_USER;
+		sym->flags &= flags | ~SYMBOL_DEF_USER;
 	}
 
 	sym_change_count += conf_warnings || conf_unsaved;
