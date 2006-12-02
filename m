Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424428AbWLBTZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424428AbWLBTZu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 14:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424433AbWLBTZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 14:25:50 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44740 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1424428AbWLBTZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 14:25:50 -0500
Date: Sat, 2 Dec 2006 20:25:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       dcb314@hotmail.com
Subject: swsusp: kill write-only variable
Message-ID: <20061202192541.GA4019@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup write-only variable, suggested by D Binderman.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit e4bb3afa65dd97dd64fee857823040a963091444
tree ee5af7ebe992cbcffd3824f853411a26c3cd085a
parent 7f5ff90d786d5a8ef2488334f86e59ded46d9b72
author Pavel <pavel@amd.ucw.cz> Sat, 02 Dec 2006 20:24:40 +0100
committer Pavel <pavel@amd.ucw.cz> Sat, 02 Dec 2006 20:24:40 +0100

 kernel/power/disk.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index b1fb786..a049596 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -40,12 +40,10 @@ dev_t swsusp_resume_device;
 
 static void power_down(suspend_disk_method_t mode)
 {
-	int error = 0;
-
 	switch(mode) {
 	case PM_DISK_PLATFORM:
 		kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
-		error = pm_ops->enter(PM_SUSPEND_DISK);
+		pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:
 		kernel_power_off();

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
