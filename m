Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVCSNR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVCSNR1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVCSNR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:17:27 -0500
Received: from coderock.org ([193.77.147.115]:58759 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262460AbVCSNRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:17:22 -0500
Subject: [patch 01/10] char/ds1620: use msleep() instead of schedule_timeout()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:17:15 +0100
Message-Id: <20050319131716.DB08C1ECA8@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Not sure why any driver needs to sleep for *two* ticks, so let's fix it.

Use msleep() instead of schedule_timeout() to guarantee the
task delays as expected. Signals are never checked for by the callers or
in the function itself, so use TASK_UNINTERRUPTIBLE instead of
TASK_INTERRUPTIBLE. The delay is presumed to have been written when HZ==100,
and thus has been multiplied by 10 to pass to msleep().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/ds1620.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/char/ds1620.c~msleep-drivers_char_ds1620 drivers/char/ds1620.c
--- kj/drivers/char/ds1620.c~msleep-drivers_char_ds1620	2005-03-18 20:05:09.000000000 +0100
+++ kj-domen/drivers/char/ds1620.c	2005-03-18 20:05:09.000000000 +0100
@@ -163,8 +163,7 @@ static void ds1620_out(int cmd, int bits
 	netwinder_ds1620_reset();
 	netwinder_unlock(&flags);
 
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(2);
+	msleep(20);
 }
 
 static unsigned int ds1620_in(int cmd, int bits)
_
