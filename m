Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbUJYAV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbUJYAV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 20:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUJYAV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 20:21:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:45772 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261634AbUJYAVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 20:21:47 -0400
Subject: [PATCH][RESEND] Fix msleep to sleep _at_least_ the requested amount
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.58.0410221552320.2101@ppc970.osdl.org>
References: <200410221906.i9MJ63Ai022889@hera.kernel.org>
	 <1098484616.6028.80.camel@gaston>
	 <Pine.LNX.4.58.0410221552320.2101@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1098663439.16132.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 25 Oct 2004 10:19:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

You "agreed" but didn't apply the patch on the last message ... so here
it is again.


Makes sure msleep() sleeps at least the amount provided, since
schedule_timeout() doesn't guarantee a full jiffy.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== kernel/timer.c 1.100 vs edited =====
--- 1.100/kernel/timer.c	2004-10-19 19:40:28 +10:00
+++ edited/kernel/timer.c	2004-10-23 09:16:10 +10:00
@@ -1605,7 +1605,7 @@
  */
 void msleep(unsigned int msecs)
 {
-	unsigned long timeout = msecs_to_jiffies(msecs);
+	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
 
 	while (timeout) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
@@ -1621,7 +1621,7 @@
  */
 unsigned long msleep_interruptible(unsigned int msecs)
 {
-	unsigned long timeout = msecs_to_jiffies(msecs);
+	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
 
 	while (timeout && !signal_pending(current)) {
 		set_current_state(TASK_INTERRUPTIBLE);


