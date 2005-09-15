Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbVIOGyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbVIOGyy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbVIOGye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:54:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50339 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030374AbVIOGyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:54:22 -0400
Date: Thu, 15 Sep 2005 08:54:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: fix comments
Message-ID: <20050915065412.GC2726@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comments in swsusp.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit eda1a89e8ae458d17de4f876615cec4da88b72d0
tree 44ec95702f549ba9570de6746c4eaad3e42091bb
parent ec2999be998bb1981287b20dd656214956e45be8
author <pavel@amd.(none)> Thu, 15 Sep 2005 08:53:30 +0200
committer <pavel@amd.(none)> Thu, 15 Sep 2005 08:53:30 +0200

 kernel/power/power.h  |    2 +-
 kernel/power/swsusp.c |   10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/power/power.h b/kernel/power/power.h
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -1,7 +1,7 @@
 #include <linux/suspend.h>
 #include <linux/utsname.h>
 
-/* With SUSPEND_CONSOLE defined, it suspend looks *really* cool, but
+/* With SUSPEND_CONSOLE defined suspend looks *really* cool, but
    we probably do not take enough locks for switching consoles, etc,
    so bad things might happen.
 */
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -363,7 +363,7 @@ static void lock_swapdevices(void)
 }
 
 /**
- *	write_swap_page - Write one page to a fresh swap location.
+ *	write_page - Write one page to a fresh swap location.
  *	@addr:	Address we're writing.
  *	@loc:	Place to store the entry we used.
  *
@@ -863,6 +863,9 @@ static int alloc_image_pages(void)
 	return 0;
 }
 
+/* Free pages we allocated for suspend. Suspend pages are alocated
+ * before atomic copy, so we need to free them after resume.
+ */
 void swsusp_free(void)
 {
 	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
@@ -1213,8 +1216,9 @@ static struct pbe * swsusp_pagedir_reloc
 		free_pagedir(pblist);
 		free_eaten_memory();
 		pblist = NULL;
-	}
-	else
+		/* Is this even worth handling? It should never ever happen, and we 
+		   have just lost user's state, anyway... */
+	} else
 		printk("swsusp: Relocated %d pages\n", rel);
 
 	return pblist;

-- 
if you have sharp zaurus hardware you don't need... you know my address
