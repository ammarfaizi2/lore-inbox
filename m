Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317344AbSFCKBR>; Mon, 3 Jun 2002 06:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317345AbSFCKBQ>; Mon, 3 Jun 2002 06:01:16 -0400
Received: from [195.39.17.254] ([195.39.17.254]:927 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317344AbSFCKBP>;
	Mon, 3 Jun 2002 06:01:15 -0400
Date: Mon, 3 Jun 2002 11:55:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: suspend.c: This is broken, fixme
Message-ID: <20020603095507.GA3030@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I found this in 2.5.20...

--- a/kernel/suspend.c  Sun Jun  2 18:44:56 2002
+++ b/kernel/suspend.c  Sun Jun  2 18:44:56 2002
@@ -64,6 +64,7 @@
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <linux/swapops.h>

 unsigned char software_suspend_enabled = 0;

@@ -300,7 +301,8 @@
 static void do_suspend_sync(void)
 {
        while (1) {
-               run_task_queue(&tq_disk);
+               blk_run_queues();
+#error this is broken, FIXME
                if (!TQ_ACTIVE(tq_disk))
                        break;

. Why is it broken?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
