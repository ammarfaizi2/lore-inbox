Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279349AbRJWKGP>; Tue, 23 Oct 2001 06:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279351AbRJWKGF>; Tue, 23 Oct 2001 06:06:05 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:27174 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S279349AbRJWKF6>; Tue, 23 Oct 2001 06:05:58 -0400
Date: Tue, 23 Oct 2001 12:06:29 +0200 (MEST)
From: Armin Schindler <mac@melware.de>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: bug in do_slow_gettimeoffset with i386 ?
Message-ID: <Pine.LNX.4.31.0110231156070.18825-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after detecting problems with the do_gettimeofday() function in
my interrupt handler on a 486 (no TSC), where sometimes this
functions returns a value in the past, the following patch made
it work again, it is against 2.4.3.

I noticed that the added outb_p() line is in for mips architechture
and in kernels 2.2 for i386, but not in any 2.4. Was it removed by
purpose ?

Armin


--- arch/i386/kernel/time.c_orig  Mon Aug  6 12:06:53 2001
+++ arch/i386/kernel/time.c      Mon Oct 22 08:04:29 2001
@@ -204,6 +206,7 @@
                         * This is tricky when I/O APICs are used;
                         * see do_timer_interrupt().
                         */
+                       outb_p(0x0A,0x20);
                        i = inb(0x20);
                        spin_unlock(&i8259A_lock);

