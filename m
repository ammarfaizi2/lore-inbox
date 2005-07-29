Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbVG2Sx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVG2Sx6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVG2Svx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:51:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30089 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262680AbVG2SvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:51:08 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] reboot: remove device_suspend(PMSG_FREEZE) from
 kernel_kexec
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 12:50:57 -0600
Message-ID: <m18xzp4fam.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If device_suspend(PMSG_FREEZE) is not ready to be called in
kernel_restart it is definitely ready to be called in the more the
more fickle kernel_kexec. 

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 kernel/sys.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

83cf6e3b0d37563138e4d0fd4d29e69e5c7e93df
diff --git a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -392,7 +392,6 @@ void kernel_kexec(void)
 	}
 	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
 	system_state = SYSTEM_RESTART;
-	device_suspend(PMSG_FREEZE);
 	device_shutdown();
 	printk(KERN_EMERG "Starting new kernel\n");
 	machine_shutdown();
