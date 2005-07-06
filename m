Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVGFCWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVGFCWB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVGFCUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:20:48 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:55704 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262046AbVGFCTQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:16 -0400
Subject: [PATCH] [2/48] Suspend2 2.1.9.8 for 2.6.12: 300-reboot-handler-hook.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:39 +1000
Message-Id: <11206164392618@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 301-proc-acpi-sleep-activate-hook.patch-old/drivers/acpi/sleep/proc.c 301-proc-acpi-sleep-activate-hook.patch-new/drivers/acpi/sleep/proc.c
--- 301-proc-acpi-sleep-activate-hook.patch-old/drivers/acpi/sleep/proc.c	2005-06-20 11:46:50.000000000 +1000
+++ 301-proc-acpi-sleep-activate-hook.patch-new/drivers/acpi/sleep/proc.c	2005-07-04 23:14:18.000000000 +1000
@@ -68,6 +68,17 @@ acpi_system_write_sleep (
 		goto Done;
 	}
 	state = simple_strtoul(str, NULL, 0);
+#ifdef CONFIG_SUSPEND2
+	/* 
+	 * I used to put this after the CONFIG_SOFTWARE_SUSPEND
+	 * test, but people who compile in suspend2 usually want
+	 * to use it instead of swsusp.   --NC
+	 */
+	if (state == 4) {
+		suspend2_try_suspend();
+		goto Done;
+	}
+#endif
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	if (state == 4) {
 		error = software_suspend();

