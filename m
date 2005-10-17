Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVJQWlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVJQWlW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 18:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVJQWkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 18:40:55 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:32195 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932356AbVJQWkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 18:40:53 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [PATCH 2/4] swsusp: clean up resume error path
Date: Mon, 17 Oct 2005 23:50:04 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200510172336.53194.rjw@sisk.pl>
In-Reply-To: <200510172336.53194.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510172350.05415.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch removes an incorrect call to restore_highmem() from
the resume error path (there's no saved highmem in that case) and makes
swsusp touch the softlockup watchdog if there's no error (currently it only
touches the watchdog if an error occurs).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc4-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/kernel/power/swsusp.c	2005-10-17 23:28:34.000000000 +0200
+++ linux-2.6.14-rc4-mm1/kernel/power/swsusp.c	2005-10-17 23:28:47.000000000 +0200
@@ -604,6 +604,7 @@
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	restore_highmem();
+	touch_softlockup_watchdog();
 	device_power_up();
 	local_irq_enable();
 	return error;
@@ -628,7 +629,6 @@
 	 */
 	swsusp_free();
 	restore_processor_state();
-	restore_highmem();
 	touch_softlockup_watchdog();
 	device_power_up();
 	local_irq_enable();

