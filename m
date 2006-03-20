Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWCTWBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWCTWBE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWCTWBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:46265 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964993AbWCTWBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:03 -0500
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 21/23] get_cpu_sysdev() signedness fix
In-Reply-To: <11428920393385-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:39 -0800
Message-Id: <11428920391241-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doing (int < NR_CPUS) doesn't dtrt if it's negative..

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/base/cpu.c  |    2 +-
 include/linux/cpu.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

a29d642a4aa99c5234314ab2523281139226c231
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 07a7f97..29f3d75 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -141,7 +141,7 @@ int __devinit register_cpu(struct cpu *c
 	return error;
 }
 
-struct sys_device *get_cpu_sysdev(int cpu)
+struct sys_device *get_cpu_sysdev(unsigned cpu)
 {
 	if (cpu < NR_CPUS)
 		return cpu_sys_devices[cpu];
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 0ed1d48..d612b89 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -32,7 +32,7 @@ struct cpu {
 };
 
 extern int register_cpu(struct cpu *, int, struct node *);
-extern struct sys_device *get_cpu_sysdev(int cpu);
+extern struct sys_device *get_cpu_sysdev(unsigned cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *, struct node *);
 #endif
-- 
1.2.4


