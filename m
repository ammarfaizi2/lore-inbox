Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265688AbSJSWLP>; Sat, 19 Oct 2002 18:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbSJSWLP>; Sat, 19 Oct 2002 18:11:15 -0400
Received: from ra.abo.fi ([130.232.213.1]:62122 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id <S265688AbSJSWLO>;
	Sat, 19 Oct 2002 18:11:14 -0400
Date: Sun, 20 Oct 2002 01:17:14 +0300 (EEST)
From: Marcus Alanen <maalanen@ra.abo.fi>
To: linux-kernel@vger.kernel.org
cc: trivial@rustcorp.com.au
Subject: [patch] setup_arg_pages. ARCH_STACK_GROWSUP ??
Message-ID: <Pine.LNX.4.44.0210200110450.16009-100000@tuxedo.abo.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can see, setup_arg_pages code is hosed for the 
ARCH_STACK_GROWSUP case, completely wrong types... Does any arch even 
use this?

Marcus

diff -Naurd --exclude-from=/home/maalanen/linux/base/diff_exclude linus-2.5.44/fs/exec.c msa-2.5.44/fs/exec.c
--- linus-2.5.44/fs/exec.c	Wed Oct 16 16:31:15 2002
+++ msa-2.5.44/fs/exec.c	Sat Oct 19 22:03:11 2002
@@ -354,11 +354,11 @@
 		memmove(to, to + offset, PAGE_SIZE - offset);
 		from = kmap(bprm->page[j]);
 		memcpy(to + PAGE_SIZE - offset, from, offset);
-		kunmap(bprm[j - 1]);
+		kunmap(bprm->page[j - 1]);
 		to = from;
 	}
 	memmove(to, to + offset, PAGE_SIZE - offset);
-	kunmap(bprm[j - 1]);
+	kunmap(bprm->page[j - 1]);
 
 	/* Adjust bprm->p to point to the end of the strings. */
 	bprm->p = PAGE_SIZE * i - offset;

