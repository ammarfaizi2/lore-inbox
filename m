Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135548AbRDXLna>; Tue, 24 Apr 2001 07:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135553AbRDXLnK>; Tue, 24 Apr 2001 07:43:10 -0400
Received: from corp1.cbn.net.id ([202.158.3.24]:19466 "HELO corp1.cbn.net.id")
	by vger.kernel.org with SMTP id <S135548AbRDXLnA>;
	Tue, 24 Apr 2001 07:43:00 -0400
Date: Tue, 24 Apr 2001 18:44:58 +0700 (JAVT)
From: <imel96@trustix.co.id>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Single user linux
In-Reply-To: <992trn$lk1$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0104241830020.11899-100000@tessy.trustix.co.id>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

a friend of my asked me on how to make linux easier to use
for personal/casual win user.

i found out that one of the big problem with linux and most
other operating system is the multi-user thing.

i think, no personal computer user should know about what's
an operating system idea of a user. they just want to use
the computer, that's it.

by a personal computer i mean home pc, notebook, tablet,
pda, and communicator. only one user will use those devices,
or maybe his/her friend/family. do you think that user want
to know about user account?

from that, i also found out that it is very awkward to type
username and password every time i use my computer.
so here's a patch. i also have removed the user_struct from
my kernel, but i don't think you'd like #ifdef's.
may be it'll be good for midori too.


	imel



--- sched.h	Mon Apr  2 18:57:06 2001
+++ sched.h~	Tue Apr 24 17:32:33 2001
@@ -655,6 +655,12 @@
 		       unsigned long, const char *, void *);
 extern void free_irq(unsigned int, void *);

+#ifdef CONFIG_NOUSER
+#define capable(x)	1
+#define suser()		1
+#define fsuser()	1
+#else
+
 /*
  * This has now become a routine instead of a macro, it sets a flag if
  * it returns true (to do BSD-style accounting where the process is flagged
@@ -706,6 +712,8 @@
 	}
 	return 0;
 }
+
+#endif /* CONFIG_NOUSER */

 /*
  * Routines for handling mm_structs

diff -ur linux/Documentation/Configure.help nouser/Documentation/Configure.help
--- linux/Documentation/Configure.help	Mon Apr  2 18:53:29 2001
+++ nouser/Documentation/Configure.help	Tue Apr 24 18:08:49 2001
@@ -13626,6 +13626,14 @@
   a work-around for a number of buggy BIOSes. Switch this option on if
   your computer crashes instead of powering off properly.

+Disable Multi-user (DANGEROUS)
+CONFIG_NOUSER
+  Disable kernel multi-user support. Normally, we treat each user
+  differently, depending on his/her permissions. If you _really_
+  think that you're not going to use your computer in a hostile
+  environment and would like to cut a few bytes, say Y.
+  Most people should say N.
+
 Watchdog Timer Support
 CONFIG_WATCHDOG
   If you say Y here (and to one of the following options) and create a
diff -ur linux/arch/i386/config.in nouser/arch/i386/config.in
--- linux/arch/i386/config.in	Mon Feb  5 18:50:27 2001
+++ nouser/arch/i386/config.in	Tue Apr 24 17:53:42 2001
@@ -244,6 +244,8 @@
    bool '    Use real mode APM BIOS call to power off' CONFIG_APM_REAL_MODE_POWER_OFF
 fi

+bool 'Disable Multi-user (DANGEROUS)' CONFIG_NOUSER
+
 endmenu

 source drivers/mtd/Config.in

