Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263074AbTDBRnj>; Wed, 2 Apr 2003 12:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263082AbTDBRnj>; Wed, 2 Apr 2003 12:43:39 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:57863 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S263074AbTDBRni>; Wed, 2 Apr 2003 12:43:38 -0500
Date: Wed, 2 Apr 2003 11:55:03 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Fix for module.c in current linus-2.5 BK
Message-ID: <20030402175503.GC32302@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

It looks like the problem is a missing "k". The field "num_syms" is only
defined if CONFIG_KALLSYMS is defined.

Art Haas

===== kernel/module.c 1.72 vs edited =====
--- 1.72/kernel/module.c	Mon Mar 24 19:31:40 2003
+++ edited/kernel/module.c	Wed Apr  2 11:27:34 2003
@@ -1273,7 +1273,7 @@
 		goto cleanup;
 
 	/* Set up EXPORTed & EXPORT_GPLed symbols (section 0 is 0 length) */
-	mod->num_syms = sechdrs[exportindex].sh_size / sizeof(*mod->syms);
+	mod->num_ksyms = sechdrs[exportindex].sh_size / sizeof(*mod->syms);
 	mod->syms = (void *)sechdrs[exportindex].sh_addr;
 	if (crcindex)
 		mod->crcs = (void *)sechdrs[crcindex].sh_addr;
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
