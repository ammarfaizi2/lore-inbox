Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUHWT5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUHWT5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267519AbUHWTzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:55:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:42435 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266763AbUHWSgM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:12 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286082136@kroah.com>
Date: Mon, 23 Aug 2004 11:34:42 -0700
Message-Id: <1093286082562@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1790.2.5, 2004/08/02 15:34:38-07:00, nacc@us.ibm.com

[PATCH] PCI Hotplug: cpci_hotplug_core: replace schedule_timeout() with msleep()

Uses msleep() instead of schedule_timeout() to guarantee
the task delays the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/cpci_hotplug_core.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
--- a/drivers/pci/hotplug/cpci_hotplug_core.c	2004-08-23 11:08:28 -07:00
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c	2004-08-23 11:08:28 -07:00
@@ -513,11 +513,10 @@
 			break;
 		while(controller->ops->query_enum()) {
 			rc = check_slots();
-			if(rc > 0) {
+			if (rc > 0)
 				/* Give userspace a chance to handle extraction */
-				set_current_state(TASK_INTERRUPTIBLE);
-				schedule_timeout(HZ / 2);
-			} else if(rc < 0) {
+				msleep(500);
+			else if (rc < 0) {
 				dbg("%s - error checking slots", __FUNCTION__);
 				thread_finished = 1;
 				break;
@@ -568,11 +567,10 @@
 
 		while(controller->ops->query_enum()) {
 			rc = check_slots();
-			if(rc > 0) {
+			if(rc > 0)
 				/* Give userspace a chance to handle extraction */
-				set_current_state(TASK_INTERRUPTIBLE);
-				schedule_timeout(HZ / 2);
-			} else if(rc < 0) {
+				msleep(500);
+			else if (rc < 0) {
 				dbg("%s - error checking slots", __FUNCTION__);
 				thread_finished = 1;
 				break;
@@ -595,8 +593,7 @@
 			}
 		}
 
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ / 10);
+		msleep(100);
 	}
 	dbg("poll thread signals exit");
 	up(&thread_exit);

