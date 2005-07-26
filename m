Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVGZRWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVGZRWT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVGZRWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:22:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8839 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261881AbVGZRWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:22:15 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/23] Add missing device_suspsend(PMSG_FREEZE) calls.
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:21:38 -0600
In-Reply-To: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Tue, 26 Jul 2005 11:19:17 -0600")
Message-ID: <m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the recent addition of device_suspend calls into
sys_reboot two code paths were missed.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 kernel/sys.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

5f0fb00783b94248b5a76c161f1c30a033fce4d3
diff --git a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -391,6 +391,7 @@ asmlinkage long sys_reboot(int magic1, i
 	case LINUX_REBOOT_CMD_RESTART:
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
 		system_state = SYSTEM_RESTART;
+		device_suspend(PMSG_FREEZE);
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system.\n");
 		machine_restart(NULL);
@@ -452,6 +453,7 @@ asmlinkage long sys_reboot(int magic1, i
 		}
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
 		system_state = SYSTEM_RESTART;
+		device_suspend(PMSG_FREEZE);
 		device_shutdown();
 		printk(KERN_EMERG "Starting new kernel\n");
 		machine_shutdown();
