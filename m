Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263063AbUKTDPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbUKTDPl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 22:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263071AbUKTCnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:43:49 -0500
Received: from baikonur.stro.at ([213.239.196.228]:41160 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263063AbUKTCel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:34:41 -0500
Subject: [patch 05/10]  ide/ide-cd: replace 	cdrom_sleep() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:34:40 +0100
Message-ID: <E1CVL5E-0001PI-KM@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Uses msleep() in place of cdrom_sleep()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/drivers/ide/ide-cd.c |   15 +--------------
 1 files changed, 1 insertion(+), 14 deletions(-)

diff -puN drivers/ide/ide-cd.c~msleep-drivers_ide_ide-cd drivers/ide/ide-cd.c
--- linux-2.6.10-rc2-bk4/drivers/ide/ide-cd.c~msleep-drivers_ide_ide-cd	2004-11-19 17:15:27.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/drivers/ide/ide-cd.c	2004-11-19 17:15:27.000000000 +0100
@@ -1514,19 +1514,6 @@ static ide_startstop_t cdrom_do_packet_c
 }
 
 
-/* Sleep for TIME jiffies.
-   Not to be called from an interrupt handler. */
-static
-void cdrom_sleep (int time)
-{
-	int sleep = time;
-
-	do {
-		set_current_state(TASK_INTERRUPTIBLE);
-		sleep = schedule_timeout(sleep);
-	} while (sleep);
-}
-
 static
 int cdrom_queue_packet_command(ide_drive_t *drive, struct request *rq)
 {
@@ -1561,7 +1548,7 @@ int cdrom_queue_packet_command(ide_drive
 				/* The drive is in the process of loading
 				   a disk.  Retry, but wait a little to give
 				   the drive time to complete the load. */
-				cdrom_sleep(2 * HZ);
+				msleep(2000);
 			} else {
 				/* Otherwise, don't retry. */
 				retries = 0;
_
