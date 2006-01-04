Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWADWBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWADWBw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWADWBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:01:51 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:34806 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S932145AbWADWBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:01:42 -0500
Date: Wed, 04 Jan 2006 17:01:21 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 12/15] via-pmu: Wrap some uses of sleep_in_progress with proper
 ifdef's
To: linux-kernel@vger.kernel.org
Message-id: <0ISL00EOC96O6A@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basically completes what's already in the rest of the driver.
sleep_in_progress is only defined for pm+ppc32.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 drivers/macintosh/via-pmu.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

3ab202d5d55c3ea17d88454b212a0363f9a2b115
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 5640435..64549ad 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -2911,8 +2911,10 @@ pmu_ioctl(struct inode * inode, struct f
 	 * the fbdev
 	 */
 	case PMU_IOC_GET_BACKLIGHT:
+#if defined(CONFIG_PM) && defined(CONFIG_PPC32)
 		if (sleep_in_progress)
 			return -EBUSY;
+#endif
 		error = get_backlight_level();
 		if (error < 0)
 			return error;
@@ -2920,8 +2922,10 @@ pmu_ioctl(struct inode * inode, struct f
 	case PMU_IOC_SET_BACKLIGHT:
 	{
 		__u32 value;
+#if defined(CONFIG_PM) && defined(CONFIG_PPC32)
 		if (sleep_in_progress)
 			return -EBUSY;
+#endif
 		error = get_user(value, argp);
 		if (!error)
 			error = set_backlight_level(value);
-- 
1.0.5
