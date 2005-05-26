Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVEZGhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVEZGhw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 02:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVEZGhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 02:37:51 -0400
Received: from fmr20.intel.com ([134.134.136.19]:59311 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261221AbVEZGhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 02:37:33 -0400
Subject: Swsusp trival fix
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain
Date: Thu, 26 May 2005 14:44:02 +0800
Message-Id: <1117089842.8005.5.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,
The below patch fixes a small error in -mm tree. It makes the error
handling process correct, which is introduced by my previous
suspend/resume smp patch.

Thanks,
Shaohua

---

 linux-2.6.11-rc5-mm1-root/kernel/power/disk.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN kernel/power/disk.c~swsusp kernel/power/disk.c
--- linux-2.6.11-rc5-mm1/kernel/power/disk.c~swsusp	2005-05-26 14:16:24.789077512 +0800
+++ linux-2.6.11-rc5-mm1-root/kernel/power/disk.c	2005-05-26 14:18:23.369050616 +0800
@@ -135,7 +135,7 @@ static int prepare_processes(void)
 
 	if (freeze_processes()) {
 		error = -EBUSY;
-		goto enable_cpu;
+		goto thaw;
 	}
 
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
@@ -150,7 +150,6 @@ static int prepare_processes(void)
 	return 0;
 thaw:
 	thaw_processes();
-enable_cpu:
 	enable_nonboot_cpus();
 	pm_restore_console();
 	return error;
_


