Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTDIGvC (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 02:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbTDIGvB (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 02:51:01 -0400
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:2176 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP id S262865AbTDIGvA (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 02:51:00 -0400
Date: Wed, 9 Apr 2003 16:00:37 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5.67-ac1] i686 SMP box doesn't boot
Message-ID: <20030409070037.GB876@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My i686 SMP box did not boot 2.5.67-ac1.
I guess timer_tsc.c is missing change for monotonic timer.
After appling this patch my box boot normaly.

diff -Nru linux-2.5.67-ac1/arch/i386/kernel/timers/timer_tsc.c linux-2.5.67-ac1-quick-fix/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.5.67-ac1/arch/i386/kernel/timers/timer_tsc.c	2003-04-09 00:34:57.000000000 +0900
+++ linux-2.5.67-ac1-quick-fix/arch/i386/kernel/timers/timer_tsc.c	2003-04-09 14:52:32.000000000 +0900
@@ -121,6 +121,9 @@
 	int countmp;
 	static int count1 = 0;
 	unsigned long long this_offset, last_offset;
+	
+	write_lock(&monotonic_lock);
+	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	/*
 	 * It is important that these two operations happen almost at
 	 * the same time. We do the RDTSC stuff first, since it's
