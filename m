Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbUJ3Www@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbUJ3Www (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbUJ3WvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:51:04 -0400
Received: from baikonur.stro.at ([213.239.196.228]:5505 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S261383AbUJ3WrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:47:15 -0400
Subject: [patch 3/8]  serial/pmac_zilog: replace 	schedule_timeout() with msleep()
To: rmk+lkml@arm.linux.org.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, janitor@sternwelten.at,
       nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sun, 31 Oct 2004 00:47:05 +0200
Message-ID: <E1CO202-00030e-8U@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.10-rc1-max/drivers/serial/pmac_zilog.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/serial/pmac_zilog.c~msleep-drivers_serial_pmac_zilog drivers/serial/pmac_zilog.c
--- linux-2.6.10-rc1/drivers/serial/pmac_zilog.c~msleep-drivers_serial_pmac_zilog	2004-10-24 17:05:09.000000000 +0200
+++ linux-2.6.10-rc1-max/drivers/serial/pmac_zilog.c	2004-10-24 17:05:09.000000000 +0200
@@ -949,8 +949,7 @@ static int pmz_startup(struct uart_port 
 	 */
 	if (pwr_delay != 0) {
 		pmz_debug("pmz: delaying %d ms\n", pwr_delay);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout((pwr_delay * HZ)/1000);
+		msleep(pwr_delay);
 	}
 
 	/* IrDA reset is done now */
@@ -1684,8 +1683,7 @@ static int pmz_resume(struct macio_dev *
 	 */
 	if (pwr_delay != 0) {
 		pmz_debug("pmz: delaying %d ms\n", pwr_delay);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout((pwr_delay * HZ)/1000);
+		msleep(pwr_delay);
 	}
 
 	pmz_debug("resume, switching complete\n");
_
