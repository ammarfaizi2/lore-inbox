Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVKAJgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVKAJgQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 04:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVKAJgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 04:36:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20666 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750718AbVKAJgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 04:36:16 -0500
Date: Tue, 1 Nov 2005 10:36:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] swsusp: remove unused variable
Message-ID: <20051101093603.GA7193@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable, and make code less evil that way. Fix
whitespace around for-loop-like macro.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -85,18 +85,11 @@ unsigned int nr_copy_pages __nosavedata 
 /* Suspend pagedir is allocated before final copy, therefore it
    must be freed after resume
 
-   Warning: this is evil. There are actually two pagedirs at time of
-   resume. One is "pagedir_save", which is empty frame allocated at
-   time of suspend, that must be freed. Second is "pagedir_nosave",
-   allocated at time of resume, that travels through memory not to
-   collide with anything.
-
    Warning: this is even more evil than it seems. Pagedirs this file
    talks about are completely different from page directories used by
    MMU hardware.
  */
 suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
-suspend_pagedir_t *pagedir_save;
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
@@ -385,7 +378,7 @@ static void data_free(void)
 	swp_entry_t entry;
 	struct pbe *p;
 
-	for_each_pbe(p, pagedir_nosave) {
+	for_each_pbe (p, pagedir_nosave) {
 		entry = p->swap_address;
 		if (entry.val)
 			swap_free(entry);

-- 
Thanks, Sharp!
