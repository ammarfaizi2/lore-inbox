Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267266AbTBUJj5>; Fri, 21 Feb 2003 04:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTBUJj5>; Fri, 21 Feb 2003 04:39:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22026 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267266AbTBUJj4>; Fri, 21 Feb 2003 04:39:56 -0500
Date: Fri, 21 Feb 2003 10:48:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       ncunningham@clear.net.nz
Subject: swsusp: kill bogus wakeup warning
Message-ID: <20030221094850.GA18896@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This kills 'bogus wakeup' warning from pdflush. Patch from Nigel,
please apply.
							Pavel

--- clean/mm/pdflush.c	2003-02-15 18:51:31.000000000 +0100
+++ linux/mm/pdflush.c	2003-02-21 10:41:33.000000000 +0100
@@ -103,9 +103,11 @@
 		my_work->when_i_went_to_sleep = jiffies;
 		spin_unlock_irq(&pdflush_lock);
 
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
 		schedule();
+		if (current->flags & PF_FREEZE) {
+			refrigerator(PF_IOTHREAD);
+			continue;
+		}
 
 		spin_lock_irq(&pdflush_lock);
 		if (!list_empty(&my_work->list)) {

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
