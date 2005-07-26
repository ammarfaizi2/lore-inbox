Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVGZR5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVGZR5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVGZRzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:55:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39815 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261974AbVGZRyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:54:01 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/23] Fix watchdog drivers to call emergency_reboot()
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
	<m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
	<m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
	<m1sly1cvnd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1oe8pcvii.fsf_-_@ebiederm.dsl.xmission.com>
	<m1k6jdcvgk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fyu1cvd7.fsf_-_@ebiederm.dsl.xmission.com>
	<m1br4pcva4.fsf_-_@ebiederm.dsl.xmission.com>
	<m17jfdcv79.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:53:19 -0600
In-Reply-To: <m17jfdcv79.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 11:51:06 -0600")
Message-ID: <m13bq1cv3k.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If a watchdog driver has decided it is time to reboot the system
we know something is wrong and we are in interrupt context
so emergency_reboot() is what we want.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 drivers/char/watchdog/eurotechwdt.c |    2 +-
 drivers/char/watchdog/softdog.c     |    2 +-
 drivers/char/watchdog/wdt.c         |    2 +-
 drivers/char/watchdog/wdt_pci.c     |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

7dda2f8e340a007a29cef304bee65437d09d4738
diff --git a/drivers/char/watchdog/eurotechwdt.c b/drivers/char/watchdog/eurotechwdt.c
--- a/drivers/char/watchdog/eurotechwdt.c
+++ b/drivers/char/watchdog/eurotechwdt.c
@@ -167,7 +167,7 @@ static irqreturn_t eurwdt_interrupt(int 
 	printk(KERN_CRIT "Would Reboot.\n");
 #else
 	printk(KERN_CRIT "Initiating system reboot.\n");
-	machine_restart(NULL);
+	emergency_restart(NULL);
 #endif
 	return IRQ_HANDLED;
 }
diff --git a/drivers/char/watchdog/softdog.c b/drivers/char/watchdog/softdog.c
--- a/drivers/char/watchdog/softdog.c
+++ b/drivers/char/watchdog/softdog.c
@@ -97,7 +97,7 @@ static void watchdog_fire(unsigned long 
 	else
 	{
 		printk(KERN_CRIT PFX "Initiating system reboot.\n");
-		machine_restart(NULL);
+		emergency_restart(NULL);
 		printk(KERN_CRIT PFX "Reboot didn't ?????\n");
 	}
 }
diff --git a/drivers/char/watchdog/wdt.c b/drivers/char/watchdog/wdt.c
--- a/drivers/char/watchdog/wdt.c
+++ b/drivers/char/watchdog/wdt.c
@@ -266,7 +266,7 @@ static irqreturn_t wdt_interrupt(int irq
 		printk(KERN_CRIT "Would Reboot.\n");
 #else
 		printk(KERN_CRIT "Initiating system reboot.\n");
-		machine_restart(NULL);
+		emergency_restart();
 #endif
 #else
 		printk(KERN_CRIT "Reset in 5ms.\n");
diff --git a/drivers/char/watchdog/wdt_pci.c b/drivers/char/watchdog/wdt_pci.c
--- a/drivers/char/watchdog/wdt_pci.c
+++ b/drivers/char/watchdog/wdt_pci.c
@@ -311,7 +311,7 @@ static irqreturn_t wdtpci_interrupt(int 
 		printk(KERN_CRIT PFX "Would Reboot.\n");
 #else
 		printk(KERN_CRIT PFX "Initiating system reboot.\n");
-		machine_restart(NULL);
+		emergency_restart(NULL);
 #endif
 #else
 		printk(KERN_CRIT PFX "Reset in 5ms.\n");
