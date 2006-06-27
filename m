Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933444AbWF0En4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933444AbWF0En4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030702AbWF0EnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:43:08 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:58331 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030703AbWF0EnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:43:01 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 10/13] [Suspend2] Replace swsusp reboot hook.
Date: Tue, 27 Jun 2006 14:43:00 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044259.15066.26437.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the swsusp reboot hook with one for suspend2.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/sys.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 0b6ec0e..aaf29e6 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -737,12 +737,12 @@ asmlinkage long sys_reboot(int magic1, i
 		unlock_kernel();
 		return -EINVAL;
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
+#ifdef CONFIG_SUSPEND2
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
 		{
-			int ret = software_suspend();
+			suspend2_try_suspend();
 			unlock_kernel();
-			return ret;
+			return 0;
 		}
 #endif
 

--
Nigel Cunningham		nigel at suspend2 dot net
