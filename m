Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270525AbTGNEKY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 00:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270535AbTGNEKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 00:10:24 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:51379 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S270525AbTGNEKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 00:10:20 -0400
Subject: PID_MAX_DEFAULT
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1058156222.751.1407.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 Jul 2003 00:17:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few things have changed since PID_MAX_DEFAULT
was set to 0x8000. It's now adjustable via the
/proc/sys/kernel/pid_max file. An app, /bin/ps,
now reads this file to determine column width
for PID, PPID, PGID, SESS, LWP, and so on.

The common-case Linux box is best served by a
value that keeps /bin/ps PID columns narrow,
allowing for more space elsewhere. The following
patch gives 4-digit PID values as a default.

diff -Naurd old/include/linux/threads.h new/include/linux/threads.h
--- old/include/linux/threads.h	2003-07-12 19:01:14.000000000 -0400
+++ new/include/linux/threads.h	2003-07-12 19:03:34.000000000 -0400
@@ -25,7 +25,7 @@
 /*
  * This controls the default maximum pid allocated to a process
  */
-#define PID_MAX_DEFAULT 0x8000
+#define PID_MAX_DEFAULT 10000
 
 /*
  * A maximum of 4 million PIDs should be enough for a while:



