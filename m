Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUBXBHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUBXBG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:06:28 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:15123 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262128AbUBXBGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:06:08 -0500
Date: Tue, 24 Feb 2004 01:06:05 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: small n_tty patch.
Message-ID: <Pine.LNX.4.44.0402240104500.17027-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove kd.h. We don't need this header. Use the inline functions to set 
the current process state.

--- n_tty.c	2004-02-23 00:06:05.000000000 -0800
+++ /usr/src/ruby-2.6/drivers/char/n_tty.c	2004-02-23 00:10:20.000000000 -0800
@@ -40,7 +40,6 @@
 #include <linux/tty.h>
 #include <linux/timer.h>
 #include <linux/ctype.h>
-#include <linux/kd.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/slab.h>
@@ -1091,7 +1090,7 @@
 			set_bit(TTY_DONT_FLIP, &tty->flags);
 			continue;
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 
 		/* Deal with packet mode. */
 		if (tty->packet && b == buf) {
@@ -1170,7 +1169,7 @@
 	if (!waitqueue_active(&tty->read_wait))
 		tty->minimum_to_wake = minimum;
 
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	size = b - buf;
 	if (size) {
 		retval = size;
@@ -1246,7 +1245,7 @@
 		schedule();
 	}
 break_out:
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tty->write_wait, &wait);
 	return (b - buf) ? b - buf : retval;
 }

