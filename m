Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129555AbQKJE6O>; Thu, 9 Nov 2000 23:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129786AbQKJE6F>; Thu, 9 Nov 2000 23:58:05 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:17417 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129555AbQKJE54>; Thu, 9 Nov 2000 23:57:56 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: John Kacur <jkacur@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: test11-pre2 compile error undefined reference to `bust_spinlocks' 
In-Reply-To: Your message of "Fri, 10 Nov 2000 00:32:49 CDT."
             <3A0B8881.F444DF5@home.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Nov 2000 15:57:37 +1100
Message-ID: <23327.973832257@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000 00:32:49 -0500, 
John Kacur <jkacur@home.com> wrote:
>When attempting to compile test11-pre2, I get the following compile
>error.
>
>arch/i386/mm/mm.o: In function `do_page_fault':
>arch/i386/mm/mm.o(.text+0x781): undefined reference to `bust_spinlocks'
>make: *** [vmlinux] Error 1

Index: 0-test11-pre2.1/arch/i386/kernel/traps.c
--- 0-test11-pre2.1/arch/i386/kernel/traps.c Fri, 10 Nov 2000 13:10:37 +1100 kaos (linux-2.4/A/c/1_traps.c 1.1.2.2.1.1.2.1.2.3.1.2.3.1.1.2 644)
+++ 0-test11-pre2.1(w)/arch/i386/kernel/traps.c Fri, 10 Nov 2000 15:56:54 +1100 kaos (linux-2.4/A/c/1_traps.c 1.1.2.2.1.1.2.1.2.3.1.2.3.1.1.2 644)
@@ -382,6 +382,17 @@ static void unknown_nmi_error(unsigned c
 	printk("Do you have a strange power saving mode enabled?\n");
 }
 
+/*
+ * Unlock any spinlocks which will prevent us from getting the
+ * message out (timerlist_lock is acquired through the
+ * console unblank code)
+ */
+void bust_spinlocks(void)
+{
+	spin_lock_init(&console_lock);
+	spin_lock_init(&timerlist_lock);
+}
+
 #if CONFIG_X86_IO_APIC
 
 int nmi_watchdog = 1;
@@ -396,17 +407,6 @@ __setup("nmi_watchdog=", setup_nmi_watch
 
 extern spinlock_t console_lock, timerlist_lock;
 static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
-
-/*
- * Unlock any spinlocks which will prevent us from getting the
- * message out (timerlist_lock is aquired through the
- * console unblank code)
- */
-void bust_spinlocks(void)
-{
-	spin_lock_init(&console_lock);
-	spin_lock_init(&timerlist_lock);
-}
 
 inline void nmi_watchdog_tick(struct pt_regs * regs)
 {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
