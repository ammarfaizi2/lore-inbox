Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVE0J0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVE0J0o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVE0JYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:24:06 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:30906 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262392AbVE0JBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:01:05 -0400
Date: Fri, 27 May 2005 11:02:42 +0200
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [patch 4/10] s390: schedule_timeout cleanup in ctctty
Message-ID: <20050527090242.GD8213@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Frank Pavlic <pavlic@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch 4/10] s390: schedule_timeout cleanup in ctctty.

From: Domen Puncer <domen@coderock.org>

Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/ctctty.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/net/ctctty.c linux-2.6-patched/drivers/s390/net/ctctty.c
--- linux-2.6/drivers/s390/net/ctctty.c	2005-05-06 11:25:57.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/ctctty.c	2005-05-06 11:26:14.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * $Id: ctctty.c,v 1.26 2004/08/04 11:06:55 mschwide Exp $
+ * $Id: ctctty.c,v 1.29 2005/04/05 08:50:44 mschwide Exp $
  *
  * CTC / ESCON network driver, tty interface.
  *
@@ -1056,8 +1056,7 @@ ctc_tty_close(struct tty_struct *tty, st
 	info->tty = 0;
 	tty->closing = 0;
 	if (info->blocked_open) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ/2);
+		msleep_interruptible(500);
 		wake_up_interruptible(&info->open_wait);
 	}
 	info->flags &= ~(CTC_ASYNC_NORMAL_ACTIVE | CTC_ASYNC_CLOSING);
