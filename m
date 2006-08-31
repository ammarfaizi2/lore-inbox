Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbWHaMUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWHaMUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 08:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWHaMUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 08:20:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26063 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750699AbWHaMUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 08:20:31 -0400
Date: Thu, 31 Aug 2006 14:20:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: device_suspend/resume may sleep
Message-ID: <20060831122021.GX3923@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds warning when someone tries them from atomic context.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
index 826093e..849a069 100644
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -74,6 +74,7 @@ void dpm_resume(void)
 
 void device_resume(void)
 {
+	might_sleep();
 	down(&dpm_sem);
 	dpm_resume();
 	up(&dpm_sem);
diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index 69509e0..c51531f 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -100,6 +100,7 @@ int device_suspend(pm_message_t state)
 {
 	int error = 0;
 
+	might_sleep();
 	down(&dpm_sem);
 	down(&dpm_list_sem);
 	while (!list_empty(&dpm_active) && error == 0) {

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
