Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266815AbSKOWJm>; Fri, 15 Nov 2002 17:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266818AbSKOWJm>; Fri, 15 Nov 2002 17:09:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:32393 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266815AbSKOWJk>;
	Fri, 15 Nov 2002 17:09:40 -0500
Message-ID: <3DD5723E.CED7AE1A@digeo.com>
Date: Fri, 15 Nov 2002 14:16:30 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Justin A <ja6447@albany.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47-ac4 panic on boot.
References: <200211150059.51743.ja6447@albany.edu> <200211150254.25306.ja6447@albany.edu> <3DD4B01F.B3C1DCDC@digeo.com> <200211151712.11347.ja6447@albany.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 22:16:30.0391 (UTC) FILETIME=[A5F39C70:01C28CF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin A wrote:
> 
> .config crashes, it oopses as soon as pnp starts, then 2 seconds later the
> previous oops comes up and it panics.

Irritating when it does that.  Here's a little patch which should
stop the machine dead after the first ooops, prevent stuff from
scrolling off the screen.

This, with the missing touch_nmi_watchdog() would be a handy
kernel boot option, perhaps.


--- 25/arch/i386/kernel/traps.c~noscroll	Tue Nov 12 13:13:24 2002
+++ 25-akpm/arch/i386/kernel/traps.c	Tue Nov 12 13:14:16 2002
@@ -84,7 +84,7 @@ asmlinkage void alignment_check(void);
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void machine_check(void);
 
-static int kstack_depth_to_print = 24;
+static int kstack_depth_to_print = 10;
 
 
 /*
@@ -246,6 +246,9 @@ bad:
 			printk("%02x ", c);
 		}
 	}
+	local_irq_disable();
+	for ( ; ; )
+		;
 	printk("\n");
 }	
 

_
