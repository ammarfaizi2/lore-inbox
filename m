Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUHWTEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUHWTEU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267302AbUHWTCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:02:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:10180 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267298AbUHWShA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:00 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860824138@kroah.com>
Date: Mon, 23 Aug 2004 11:34:42 -0700
Message-Id: <10932860823806@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1790.2.9, 2004/08/02 15:36:10-07:00, nacc@us.ibm.com

[PATCH] PCI Hotplug: ibmphp_hpc: replace long_delay() with msleep()

Replace long_delay() with msleep() to guarantee the task
delays as desired.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/ibmphp_hpc.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
--- a/drivers/pci/hotplug/ibmphp_hpc.c	2004-08-23 11:08:05 -07:00
+++ b/drivers/pci/hotplug/ibmphp_hpc.c	2004-08-23 11:08:05 -07:00
@@ -205,7 +205,7 @@
 	// READ - step 4 : wait until start operation bit clears
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
-		long_delay (1 * HZ / 100);
+		msleep(10);
 		wpg_addr = WPGBbar + WPG_I2CMCNTL_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
@@ -221,7 +221,7 @@
 	// READ - step 5 : read I2C status register
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
-		long_delay (1 * HZ / 100);
+		msleep(10);
 		wpg_addr = WPGBbar + WPG_I2CSTAT_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
@@ -316,7 +316,7 @@
 	// WRITE - step 4 : wait until start operation bit clears
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
-		long_delay (1 * HZ / 100);
+		msleep(10);
 		wpg_addr = WPGBbar + WPG_I2CMCNTL_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
@@ -333,7 +333,7 @@
 	// WRITE - step 5 : read I2C status register
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
-		long_delay (1 * HZ / 100);
+		msleep(10);
 		wpg_addr = WPGBbar + WPG_I2CSTAT_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
@@ -748,7 +748,7 @@
 					done = TRUE;
 			}
 			if (!done) {
-				long_delay (1 * HZ);
+				msleep(1000);
 				if (timeout < 1) {
 					done = TRUE;
 					err ("%s - Error command complete timeout\n", __FUNCTION__);
@@ -891,7 +891,7 @@
 		case POLL_SLEEP:
 			/* don't sleep with a lock on the hardware */
 			up (&semOperations);
-			long_delay (POLL_INTERVAL_SEC * HZ);
+			msleep(POLL_INTERVAL_SEC * 1000);
 
 			if (ibmphp_shutdown) 
 				break;
@@ -908,8 +908,7 @@
 		/* give up the harware semaphore */
 		up (&semOperations);
 		/* sleep for a short time just for good measure */
-		set_current_state (TASK_INTERRUPTIBLE);
-		schedule_timeout (HZ/10);
+		msleep(100);
 	}
 	up (&sem_exit);
 	debug ("%s - Exit\n", __FUNCTION__);
@@ -974,7 +973,7 @@
 			if (SLOT_PWRGD (pslot->status)) {
 				// power goes on and off after closing latch
 				// check again to make sure power is still ON
-				long_delay (1 * HZ);
+				msleep(1000);
 				rc = ibmphp_hpc_readslot (pslot, READ_SLOTSTATUS, &status);
 				if (SLOT_PWRGD (status))
 					update = TRUE;
@@ -1147,7 +1146,7 @@
 		if (CTLR_WORKING (*pstatus) == HPC_CTLR_WORKING_NO)
 			done = TRUE;
 		if (!done) {
-			long_delay (1 * HZ);
+			msleep(1000);
 			if (timeout < 1) {
 				done = TRUE;
 				err ("HPCreadslot - Error ctlr timeout\n");

