Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVBZOtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVBZOtN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 09:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVBZOtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 09:49:13 -0500
Received: from hera.cwi.nl ([192.16.191.8]:61156 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261190AbVBZOtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 09:49:10 -0500
Date: Sat, 26 Feb 2005 15:49:05 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __initdata in apic.c
Message-ID: <20050226144903.GA17740@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wait_timer_tick refers to the __init functions wait_8254_wraparound
or wait_hpet_tick, hence must be __initdata.

Andries

diff -uprN -X /linux/dontdiff a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	2005-02-26 12:13:28.000000000 +0100
+++ b/arch/i386/kernel/apic.c	2005-02-26 15:59:17.000000000 +0100
@@ -894,7 +894,7 @@ static void __init wait_8254_wraparound(
  * Default initialization for 8254 timers. If we use other timers like HPET,
  * we override this later
  */
-void (*wait_timer_tick)(void) = wait_8254_wraparound;
+void (*wait_timer_tick)(void) __initdata = wait_8254_wraparound;
 
 /*
  * This function sets up the local APIC timer, with a timeout of
