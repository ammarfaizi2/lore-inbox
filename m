Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263242AbTCNECa>; Thu, 13 Mar 2003 23:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263243AbTCNECa>; Thu, 13 Mar 2003 23:02:30 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:23534 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S263242AbTCNEC2>; Thu, 13 Mar 2003 23:02:28 -0500
To: Andrey Panin <pazke@orbita1.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] irq handling code consolidation (v850 part)
References: <20030313132923.GI1393@pazke>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 14 Mar 2003 13:13:01 +0900
In-Reply-To: <20030313132923.GI1393@pazke>
Message-ID: <buohea6k2lu.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin <pazke@orbita1.ru> writes:
> irq handling code consolidation continues.
> v850 specific patch attached. Untested.

Works great on the v850.

Here's a small v850 tweak that you might add to your patch (fixes one
printf warning, removes an unused variable):


diff -up linux-2.5.64-moo/arch/v850/kernel/irq.c.\~1\~ linux-2.5.64-moo/arch/v850/kernel/irq.c
--- linux-2.5.64-moo/arch/v850/kernel/irq.c.~1~	2003-03-14 10:39:25.000000000 +0900
+++ linux-2.5.64-moo/arch/v850/kernel/irq.c	2003-03-14 10:50:41.000000000 +0900
@@ -27,8 +27,6 @@
 
 extern atomic_t irq_err_count;
 
-volatile unsigned long spurious_count;
-
 /*
  * Generic, controller-independent functions:
  */
@@ -73,7 +71,9 @@ int show_interrupts(struct seq_file *p, 
 			seq_printf(p, ", %s", action->name);
 		seq_putc(p, '\n');
 	}
-	seq_printf(p, "ERR: %10lu\n", atomic_read(&irq_err_count));
+
+	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
+
 	return 0;
 }
 

Thanks,

-Miles
-- 
Fast, small, soon; pick any 2.
