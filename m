Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbUKXNFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbUKXNFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbUKXNCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:02:03 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:35732 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262642AbUKXNBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:01:07 -0500
Subject: Suspend 2 merge: 8/51: /proc/acpi/sleep hook.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101293562.5805.214.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:57:25 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same thing as the previous patch, but for /proc/acpi/sleep.

diff -ruN 301-proc-acpi-sleep-activate-hook-old/drivers/acpi/sleep/proc.c 301-proc-acpi-sleep-activate-hook-new/drivers/acpi/sleep/proc.c
--- 301-proc-acpi-sleep-activate-hook-old/drivers/acpi/sleep/proc.c	2004-11-03 21:54:15.000000000 +1100
+++ 301-proc-acpi-sleep-activate-hook-new/drivers/acpi/sleep/proc.c	2004-11-05 21:35:42.000000000 +1100
@@ -68,6 +68,17 @@
 		goto Done;
 	}
 	state = simple_strtoul(str, NULL, 0);
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+	/* 
+	 * I used to put this after the CONFIG_SOFTWARE_SUSPEND
+	 * test, but people who compile in suspend2 usually want
+	 * to use it instead of swsusp.   --NC
+	 */
+	if (state == 4) {
+		suspend_try_suspend();
+		goto Done;
+	}
+#endif
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	if (state == 4) {
 		software_suspend();


