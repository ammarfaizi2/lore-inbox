Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267334AbTAVFzF>; Wed, 22 Jan 2003 00:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbTAVFzF>; Wed, 22 Jan 2003 00:55:05 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:32493 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267334AbTAVFzD>; Wed, 22 Jan 2003 00:55:03 -0500
To: Andrey Panin <pazke@orbita1.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq handling code consolidation (v850 part)
References: <20030121104551.GJ7183@pazke> <20030121110520.GA7246@pazke>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 22 Jan 2003 15:04:06 +0900
In-Reply-To: <20030121110520.GA7246@pazke>
Message-ID: <buohec190vd.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Andrey Panin <pazke@orbita1.ru> writes:
> This patch contains v850 specific changes for irq handling 
> code consolidation. Totally untested.

Works fine for me, with a small change:



--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=irq-merge-v850-2.5.59-upd.patch
Content-Description: Update for patch-irq-v850-2.5.59

diff -up linux-2.5.59-uc0/arch/v850/kernel/irq.c.~1~ linux-2.5.59-uc0/arch/v850/kernel/irq.c
--- linux-2.5.59-uc0/arch/v850/kernel/irq.c.~1~	2003-01-22 14:25:01.000000000 +0900
+++ linux-2.5.59-uc0/arch/v850/kernel/irq.c	2003-01-22 14:40:30.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/irq.c -- High-level interrupt handling
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *  Copyright (C) 1994-2000  Ralf Baechle
  *  Copyright (C) 1992  Linus Torvalds
  *
@@ -25,7 +25,7 @@
 
 #include <asm/system.h>
 
-volatile unsigned long spurious_count;
+extern atomic_t irq_err_count;
 
 /*
  * Generic, controller-independent functions:
@@ -71,7 +71,7 @@ int show_interrupts(struct seq_file *p, 
 			seq_printf(p, ", %s", action->name);
 		seq_putc(p, '\n');
 	}
-	seq_printf(p, "ERR: %10lu\n", irq_err_count);
+	seq_printf(p, "ERR: %10d\n", atomic_read(&irq_err_count));
 	return 0;
 }
 

--=-=-=



[Can someone pick this up?  It seems like a nice straight-forward
cleanup that doesn't change any functionality, and deletes a buttload of
duplicated code.]

-Miles
-- 
Fast, small, soon; pick any 2.

--=-=-=--
