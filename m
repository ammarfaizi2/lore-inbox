Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWIZFti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWIZFti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWIZFtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:49:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:36565 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751383AbWIZFjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:20 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 24/47] PM: device_suspend/resume may sleep
Date: Mon, 25 Sep 2006 22:37:44 -0700
Message-Id: <11592491611339-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491581007-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@suse.cz>

This adds warning when someone tries them from atomic context.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/power/resume.c  |    1 +
 drivers/base/power/suspend.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
index 48e3d49..7cb62d6 100644
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -96,6 +96,7 @@ void dpm_resume(void)
 
 void device_resume(void)
 {
+	might_sleep();
 	down(&dpm_sem);
 	dpm_resume();
 	up(&dpm_sem);
diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index 6453c25..ece136b 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -140,6 +140,7 @@ int device_suspend(pm_message_t state)
 {
 	int error = 0;
 
+	might_sleep();
 	down(&dpm_sem);
 	down(&dpm_list_sem);
 	while (!list_empty(&dpm_active) && error == 0) {
-- 
1.4.2.1

