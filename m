Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVCFXtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVCFXtf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVCFXsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:48:23 -0500
Received: from coderock.org ([193.77.147.115]:63407 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261570AbVCFWhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:37:02 -0500
Subject: [patch 10/14] serial/crisv10: replace schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:36:46 +0100
Message-Id: <20050306223647.3C19F1EDA4@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Use msleep() instead of schedule_timeout() to guarantee the task
delays as expected. The current code uses TASK_INTERRUPTIBLE, but does not care
about signals, so I believe msleep() should be ok.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/serial/crisv10.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/serial/crisv10.c~msleep-drivers_serial_crisv10 drivers/serial/crisv10.c
--- kj/drivers/serial/crisv10.c~msleep-drivers_serial_crisv10	2005-03-05 16:10:52.000000000 +0100
+++ kj-domen/drivers/serial/crisv10.c	2005-03-05 16:10:52.000000000 +0100
@@ -3757,10 +3757,8 @@ rs_write(struct tty_struct * tty, int fr
 		e100_enable_rx_irq(info);
 #endif
 
-		if (info->rs485.delay_rts_before_send > 0) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout((info->rs485.delay_rts_before_send * HZ)/1000);
-		}
+		if (info->rs485.delay_rts_before_send > 0)
+			msleep(info->rs485.delay_rts_before_send);
 	}
 #endif /* CONFIG_ETRAX_RS485 */
 
_
