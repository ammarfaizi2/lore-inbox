Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030573AbWBHQI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030573AbWBHQI4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030564AbWBHQIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:08:55 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:37828 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S1030573AbWBHQIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:08:55 -0500
From: Jan Beulich <jbeulich@novell.com>
To: linux-kernel@vger.kernel.org
Subject: prevent recursive panic from softlockup watchdog
Date: Wed, 8 Feb 2006 17:09:07 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081709.07114.jbeulich@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Beulich <jbeulich@novell.com>

When panic_timeout is zero, suppress triggering a nested panic due to soft
lockup detection.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc2/kernel/panic.c 2.6.16-rc2-panic-softlockup/kernel/panic.c
--- /home/jbeulich/tmp/linux-2.6.16-rc2/kernel/panic.c	2006-02-06 11:02:54.000000000 +0100
+++ 2.6.16-rc2-panic-softlockup/kernel/panic.c	2006-01-25 09:55:53.000000000 +0100
@@ -130,6 +130,7 @@ NORET_TYPE void panic(const char * fmt, 
 #endif
 	local_irq_enable();
 	for (i = 0;;) {
+		touch_softlockup_watchdog();
 		i += panic_blink(i);
 		mdelay(1);
 		i++;

