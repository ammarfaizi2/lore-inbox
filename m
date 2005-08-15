Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVHOS0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVHOS0x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVHOS0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:26:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:7591 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964890AbVHOS0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:26:52 -0400
Date: Mon, 15 Aug 2005 11:26:50 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [-mm PATCH 28/32] drivers/sbus: fix-up schedule_timeout() usage
Message-ID: <20050815182650.GE2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Use schedule_timeout_uninterruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 drivers/sbus/char/bpp.c     |    3 +--
 drivers/sbus/char/vfc_i2c.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff -urpN 2.6.13-rc5-mm1/drivers/sbus/char/bpp.c 2.6.13-rc5-mm1-dev/drivers/sbus/char/bpp.c
--- 2.6.13-rc5-mm1/drivers/sbus/char/bpp.c	2005-08-07 09:58:07.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/drivers/sbus/char/bpp.c	2005-08-10 14:20:34.000000000 -0700
@@ -295,8 +295,7 @@ static unsigned short get_pins(unsigned 
 
 static void snooze(unsigned long snooze_time, unsigned minor)
 {
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(snooze_time + 1);
+	schedule_timeout_uninterruptible(snooze_time + 1);
 }
 
 static int wait_for(unsigned short set, unsigned short clr,
diff -urpN 2.6.13-rc5-mm1/drivers/sbus/char/vfc_i2c.c 2.6.13-rc5-mm1-dev/drivers/sbus/char/vfc_i2c.c
--- 2.6.13-rc5-mm1/drivers/sbus/char/vfc_i2c.c	2005-08-07 10:05:21.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/drivers/sbus/char/vfc_i2c.c	2005-08-10 14:20:42.000000000 -0700
@@ -81,8 +81,7 @@ int vfc_pcf8584_init(struct vfc_dev *dev
 
 void vfc_i2c_delay_no_busy(struct vfc_dev *dev, unsigned long usecs) 
 {
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(usecs_to_jiffies(usecs));
+	schedule_timeout_uninterruptible(usecs_to_jiffies(usecs));
 }
 
 void inline vfc_i2c_delay(struct vfc_dev *dev) 
