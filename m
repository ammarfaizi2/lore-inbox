Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbSJ2Xh4>; Tue, 29 Oct 2002 18:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262481AbSJ2Xh4>; Tue, 29 Oct 2002 18:37:56 -0500
Received: from air-2.osdl.org ([65.172.181.6]:49812 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262480AbSJ2Xhx>;
	Tue, 29 Oct 2002 18:37:53 -0500
Subject: Re: [PATCH 1/3] High-res-timers part 1 (core) take 8
From: Stephen Hemminger <shemminger@osdl.org>
To: george anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3DBEE360.EE73EF8C@mvista.com>
References: <3DBEE360.EE73EF8C@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Oct 2002 15:44:08 -0800
Message-Id: <1035935049.1580.463.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your patch adds a new config option that seems like a step backwards in
ease of use. The CONFIG_TIMERLIST option is adding a new dimension to
complexity kernel configuration. For no other parameter that I can think
of does the kernel configuration process ask for a size information.
Number of users, processes, threads, groups, are all sized dynamically
now; this is good.

How is the end user supposed to know how many timer list entries are
expected?  There is no context about what a timer list entry is and no
direct correlation back to anything meaningful in user terms (processes,
devices, sockets, ...).  Also, what happens if the time list size is
exhausted? does the kernel die? is it slower?...

Can't this just be dynamically sized?
============================================================================
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude
linux-2.5.44-bk1-posix/init/Config.in linux/init/Config.in
--- linux-2.5.44-bk1-posix/init/Config.in       Mon Sep  9 10:35:03 2002
+++ linux/init/Config.in        Tue Oct 29 07:37:11 2002
@@ -9,6 +9,27 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+choice 'Size of timer list?' \
+       "512            CONFIG_TIMERLIST_512 \
+       1024            CONFIG_TIMERLIST_1k  \
+       2048            CONFIG_TIMERLIST_2k  \
+       4096            CONFIG_TIMERLIST_4k  \
+       8192            CONFIG_TIMERLIST_8k" 512
+if [ "$CONFIG_TIMERLIST_512" = "y" ]; then
+       define_int CONFIG_NEW_TIMER_LISTSIZE 512
+fi
+if [ "$CONFIG_TIMERLIST_1k" =  "y" ]; then
+       define_int CONFIG_NEW_TIMER_LISTSIZE 1024
+fi
+if [ "$CONFIG_TIMERLIST_2k" =  "y" ]; then
+       define_int CONFIG_NEW_TIMER_LISTSIZE 2048
+fi
+if [ "$CONFIG_TIMERLIST_4k" =  "y" ]; then
+       define_int CONFIG_NEW_TIMER_LISTSIZE 4096
+fi
+if [ "$CONFIG_TIMERLIST_8k" =  "y" ]; then
+       define_int CONFIG_NEW_TIMER_LISTSIZE 8192
+fi
 endmenu
 


