Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVHFTqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVHFTqD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 15:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVHFTqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 15:46:02 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8588 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261153AbVHFTqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 15:46:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Andrey Panin <pazke@donpac.ru>,
       linux-visws-devel@lists.sourceforge.net
Subject: [PATCH] i386 visws: Add machine_shutdown and emergency_restart
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 06 Aug 2005 13:45:10 -0600
Message-ID: <m1pssqyhmh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another x86 subarchitecture bit I missed.  This adds both
machine_emergency_restart missed in my reboot fixes and
machine_shutdown needed for kexec support.
---

 arch/i386/mach-visws/reboot.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

17837594fc082e8ec464b2633df8965fbdc107bd
diff --git a/arch/i386/mach-visws/reboot.c b/arch/i386/mach-visws/reboot.c
--- a/arch/i386/mach-visws/reboot.c
+++ b/arch/i386/mach-visws/reboot.c
@@ -9,12 +9,15 @@
 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
 
-void machine_restart(char * __unused)
+void machine_shutdown(void)
 {
 #ifdef CONFIG_SMP
 	smp_send_stop();
 #endif
+}
 
+void machine_emergency_restart(void)
+{
 	/*
 	 * Visual Workstations restart after this
 	 * register is poked on the PIIX4
@@ -22,6 +25,12 @@ void machine_restart(char * __unused)
 	outb(PIIX4_RESET_VAL, PIIX4_RESET_PORT);
 }
 
+void machine_restart(char * __unused)
+{
+	machine_shutdown();
+	machine_emergency_restart();
+}
+
 void machine_power_off(void)
 {
 	unsigned short pm_status;
