Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270628AbTHET3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270629AbTHET3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:29:22 -0400
Received: from zero.aec.at ([193.170.194.10]:44550 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S270628AbTHET3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:29:21 -0400
Date: Tue, 5 Aug 2003 21:29:08 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Export touch_nmi_watchdog
Message-ID: <20030805192908.GA19867@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sometimes drivers do long things with interrupt off and the NMI watchdog
triggers quickly. This mostly happens in error handling. It would be 
better to fix the drivers to sleep in this case, but it's not always
possible or too much work.

This patch exports touch_nmi_watchdog so that they can at least be 
fixed to not trigger the watchdog.

Matches a similar patch for x86-64.

-Andi

diff -burpN -X ../KDIFX linux/arch/i386/kernel/nmi.c linux-2.6.0test2-amd64/arch/i386/kernel/nmi.c
--- linux/arch/i386/kernel/nmi.c	2003-07-18 02:40:03.000000000 +0200
+++ linux-2.6.0test2-work/arch/i386/kernel/nmi.c	2003-08-03 12:13:48.000000000 +0200
@@ -455,3 +455,4 @@ EXPORT_SYMBOL(disable_lapic_nmi_watchdog
 EXPORT_SYMBOL(enable_lapic_nmi_watchdog);
 EXPORT_SYMBOL(disable_timer_nmi_watchdog);
 EXPORT_SYMBOL(enable_timer_nmi_watchdog);
+EXPORT_SYMBOL(touch_nmi_watchdog);
