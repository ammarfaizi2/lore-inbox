Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbTBUJiE>; Fri, 21 Feb 2003 04:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbTBUJiE>; Fri, 21 Feb 2003 04:38:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62473 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267265AbTBUJiD>; Fri, 21 Feb 2003 04:38:03 -0500
Date: Fri, 21 Feb 2003 10:46:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       ncunningham@clear.net.nz
Subject: swsusp: don't sync with stopped pdflush
Message-ID: <20030221094656.GA18889@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Patch from Nigel, please apply.
						Pavel
--- clean/kernel/suspend.c	2003-02-11 17:41:41.000000000 +0100
+++ linux/kernel/suspend.c	2003-02-21 10:40:02.000000000 +0100
@@ -604,12 +606,12 @@
 
 static int prepare_suspend_processes(void)
 {
+	sys_sync();	/* Syncing needs pdflushd, so do it before stopping processes */
 	if (freeze_processes()) {
 		printk( KERN_ERR "Suspend failed: Not all processes stopped!\n" );
 		thaw_processes();
 		return 1;
 	}
-	sys_sync();
 	return 0;
 }
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
