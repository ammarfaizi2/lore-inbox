Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758583AbWK2BWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758583AbWK2BWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 20:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758590AbWK2BWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 20:22:08 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:49845 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1758583AbWK2BWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 20:22:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=p3SKJNgGY9sjSXmdGKyPrUbGyMIWNuVtU6+MHPBL6suKx/O00Q0d6LmpVc1yOZslgS1M9SDLOdbNJkNZAXUyjZHevBeno+y9jNq+jylICNIII03SM0QKV8TrqQqZzVQkEvafGUp6J9ZZhhP0TMUYg5xActp4hHmpUNaVHqsSZ+o=
Date: Wed, 29 Nov 2006 09:18:25 +0000
From: Hu Gang <linuxbest@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Karsten Wiese <fzu@wemgehoertderstaat.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.19-rc6-rt8
Message-ID: <20061129091825.5438cfb9@localhost>
In-Reply-To: <20061127094927.GA7339@elte.hu>
References: <20061127094927.GA7339@elte.hu>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006 10:49:27 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> i have released the 2.6.19-rc6-rt8 tree, which can be downloaded from 
> the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/

attached patch to making it compile and works in my PowerBook G4. 


Index: linux-2.6.19-rc6-rt5/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.19-rc6-rt5.orig/arch/powerpc/kernel/time.c	2006-11-28 22:13:54.000000000 +0000
+++ linux-2.6.19-rc6-rt5/arch/powerpc/kernel/time.c	2006-11-28 22:15:48.000000000 +0000
@@ -507,7 +507,7 @@
 		if (per_cpu(last_jiffy, cpu) >= tb_next_jiffy) {
 			tb_last_jiffy = tb_next_jiffy;
 			do_timer(1);
-			timer_recalc_offset(tb_last_jiffy);
+			/*timer_recalc_offset(tb_last_jiffy);*/
 			timer_check_rtc();
 		}
 		write_sequnlock(&xtime_lock);
Index: linux-2.6.19-rc6-rt5/include/asm-powerpc/semaphore.h
===================================================================
--- linux-2.6.19-rc6-rt5.orig/include/asm-powerpc/semaphore.h	2006-11-28 22:13:54.000000000 +0000
+++ linux-2.6.19-rc6-rt5/include/asm-powerpc/semaphore.h	2006-11-28 22:15:48.000000000 +0000
@@ -10,7 +10,7 @@
 
 #ifdef __KERNEL__
 
-#include <linux/config.h>
+/*#include <linux/config.h>*/
 #include <asm/atomic.h>
 #include <asm/system.h>
 #include <linux/wait.h>
Index: linux-2.6.19-rc6-rt5/mm/page_alloc.c
===================================================================
--- linux-2.6.19-rc6-rt5.orig/mm/page_alloc.c	2006-11-28 22:13:54.000000000 +0000
+++ linux-2.6.19-rc6-rt5/mm/page_alloc.c	2006-11-28 22:15:48.000000000 +0000
@@ -2800,7 +2800,9 @@
 
 void __init page_alloc_init(void)
 {
+#ifdef CONFIG_HOTPLUG_CPU
 	hotcpu_notifier(page_alloc_cpu_notify, 0);
+#endif
 }
 
 /*
