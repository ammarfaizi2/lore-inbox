Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136483AbRECJws>; Thu, 3 May 2001 05:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136515AbRECJwi>; Thu, 3 May 2001 05:52:38 -0400
Received: from styx.suse.cz ([213.210.157.162]:46326 "EHLO monk.suse.cz")
	by vger.kernel.org with ESMTP id <S136483AbRECJwb>;
	Thu, 3 May 2001 05:52:31 -0400
Date: Thu, 3 May 2001 11:52:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: i386/kernel/traps.c: doing udelay by hand is ugly
Message-ID: <20010503115220.A30507@monk.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Tiny cleanup in kernel/traps.c: doing mdelay by hand is ugly. Please apply.

							      Pavel

Index: arch/i386/kernel/traps.c
===================================================================
RCS file: /home/cvs/Repository/linux/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 traps.c
--- arch/i386/kernel/traps.c	2001/04/19 20:02:45	1.1.1.2
+++ arch/i386/kernel/traps.c	2001/05/03 08:46:37
@@ -357,16 +350,13 @@
 
 static void io_check_error(unsigned char reason, struct pt_regs * regs)
 {
-	unsigned long i;
-
 	printk("NMI: IOCK error (debug interrupt?)\n");
 	show_registers(regs);
 
 	/* Re-enable the IOCK line, wait for a few seconds */
 	reason = (reason & 0xf) | 8;
 	outb(reason, 0x61);
-	i = 2000;
-	while (--i) udelay(1000);
+	mdelay(2000);
 	reason &= ~8;
 	outb(reason, 0x61);
 }
