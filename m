Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbTIKK65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 06:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbTIKK65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 06:58:57 -0400
Received: from [203.145.184.221] ([203.145.184.221]:53777 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S261204AbTIKK6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 06:58:54 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH-2.6.0-test5-mm1] conversion of schedule_task to schedule_work
Date: Thu, 11 Sep 2003 16:32:14 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309111632.14197.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch converts one 'schedule_task'
in the code, and one 'schedule_task' in a comment
to 'schedule_work'. The file changed is drivers/char/istallion.c
The patch applies against 2.6.0-test5-mm1.

Regards
KK

============================
Compilation Warning removed:
drivers/char/istallion.c:2947: warning: implicit declaration of function `schedule_task'
drivers/char/istallion.c: In function `stli_startbrd':

Linking warning removed:
drivers/built-in.o(.text+0x25e73): In function `stli_poll':
: undefined reference to `schedule_task'

=============================
diffstat output:

istallion.c |    4 ++--
1 files changed, 2 insertions(+), 2 deletions(-)

=============================
The following is the patch:

--- linux-2.6.0-test5-mm1/drivers/char/istallion.orig.c	2003-09-11 14:51:35.000000000 +0530
+++ linux-2.6.0-test5-mm1/drivers/char/istallion.c	2003-09-11 14:52:06.000000000 +0530
@@ -2303,7 +2303,7 @@
 
 	/*
 	 * FIXME: There's a module removal race here: tty_hangup
-	 * calls schedule_task which will call into this
+	 * calls schedule_work which will call into this
 	 * driver later.
 	 */
 	portp = (stliport_t *) arg;
@@ -2944,7 +2944,7 @@
 			    ((portp->sigs & TIOCM_CD) == 0)) {
 				if (portp->flags & ASYNC_CHECK_CD) {
 					if (tty)
-						schedule_task(&portp->tqhangup);
+						schedule_work(&portp->tqhangup);
 				}
 			}
 		}




