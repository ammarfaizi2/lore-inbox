Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315197AbSDWNiC>; Tue, 23 Apr 2002 09:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315201AbSDWNiB>; Tue, 23 Apr 2002 09:38:01 -0400
Received: from gherkin.frus.com ([192.158.254.49]:38031 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S315197AbSDWNh4>;
	Tue, 23 Apr 2002 09:37:56 -0400
Message-Id: <m1700US-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: [PATCH] linux/kernel/acct.c
To: linux-kernel@vger.kernel.org
Date: Tue, 23 Apr 2002 08:37:52 -0500 (CDT)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For non-SMP systems, running "accton" generates an "Oops".  This was
diagnosed and fixed in the 2.5.7 timeframe, but the fix didn't make it
into 2.5.8.  The following trivial patch is against vanilla 2.5.8:
please apply.

--- linux/kernel/acct.c.orig	Mon Apr 22 09:33:45 2002
+++ linux/kernel/acct.c	Mon Apr 22 10:39:01 2002
@@ -160,8 +160,6 @@
 {
 	struct file *old_acct = NULL;
 
-	BUG_ON(!spin_is_locked(&acct_globals.lock));
-
 	if (acct_globals.file) {
 		old_acct = acct_globals.file;
 		del_timer(&acct_globals.timer);

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
