Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVAKXRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVAKXRj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVAKXRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:17:37 -0500
Received: from coderock.org ([193.77.147.115]:9157 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262908AbVAKXRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:17:08 -0500
Subject: [patch 1/1] ide/ide-cd: use ssleep() instead of schedule_timeout()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:17:00 +0100
Message-Id: <20050111231701.1A9B31F225@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Description: Uses ssleep() in place of cdrom_sleep() to guarantee the task
delays as expected. Remove cdrom_sleep() definition, as this is the only place
where it is called.

Signed-off-by: Nishanth Aravamudan
Acked-by: Jens Axboe <axboe@suse.de>

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/ide/ide-cd.c |   15 +--------------
 1 files changed, 1 insertion(+), 14 deletions(-)

diff -puN drivers/ide/ide-cd.c~msleep-drivers_ide_ide-cd drivers/ide/ide-cd.c
--- kj/drivers/ide/ide-cd.c~msleep-drivers_ide_ide-cd	2005-01-10 18:00:53.000000000 +0100
+++ kj-domen/drivers/ide/ide-cd.c	2005-01-10 18:00:53.000000000 +0100
@@ -1464,19 +1464,6 @@ static ide_startstop_t cdrom_do_packet_c
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
@@ -1511,7 +1498,7 @@ int cdrom_queue_packet_command(ide_drive
 				/* The drive is in the process of loading
 				   a disk.  Retry, but wait a little to give
 				   the drive time to complete the load. */
-				cdrom_sleep(2 * HZ);
+				ssleep(2);
 			} else {
 				/* Otherwise, don't retry. */
 				retries = 0;
_
