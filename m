Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWA3JIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWA3JIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWA3JIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:08:13 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:10181
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932149AbWA3JIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:08:12 -0500
Message-Id: <43DDE5A1.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 30 Jan 2006 10:08:33 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] prevent nested panic from soft lockup detection
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartA0823381.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartA0823381.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: Jan Beulich <jbeulich@novell.com>

Suppress triggering a nested panic due to soft lockup detection.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>



--=__PartA0823381.0__=
Content-Type: text/plain; name="linux-2.6.16-rc1-panic-softlockup.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.16-rc1-panic-softlockup.patch"

From: Jan Beulich <jbeulich@novell.com>

Suppress triggering a nested panic due to soft lockup detection.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc1/kernel/panic.c 2.6.16-rc1-panic-softlockup/kernel/panic.c
--- /home/jbeulich/tmp/linux-2.6.16-rc1/kernel/panic.c	2006-01-27 15:10:49.000000000 +0100
+++ 2.6.16-rc1-panic-softlockup/kernel/panic.c	2006-01-25 09:55:53.000000000 +0100
@@ -107,6 +107,7 @@ NORET_TYPE void panic(const char * fmt, 
 		printk(KERN_EMERG "Rebooting in %d seconds..",panic_timeout);
 		for (i = 0; i < panic_timeout*1000; ) {
 			touch_nmi_watchdog();
+			touch_softlockup_watchdog();
 			i += panic_blink(i);
 			mdelay(1);
 			i++;
@@ -130,6 +131,7 @@ NORET_TYPE void panic(const char * fmt, 
 #endif
 	local_irq_enable();
 	for (i = 0;;) {
+		touch_softlockup_watchdog();
 		i += panic_blink(i);
 		mdelay(1);
 		i++;

--=__PartA0823381.0__=--
