Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751862AbWCRFjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbWCRFjD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 00:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWCRFjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 00:39:02 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751862AbWCRFjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 00:39:00 -0500
Date: Fri, 17 Mar 2006 21:36:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: [patch] Mark cyc2ns_scale readmostly
Message-Id: <20060317213604.3a97aaeb.akpm@osdl.org>
In-Reply-To: <20060317210858.GA3666@localhost.localdomain>
References: <20060317210858.GA3666@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> This variable is rarely written to.  Mark the variable accordingly
>

I dropped all John's timekeeping patches today - he's redoing everything. 
So I've reworked this against mainline.

x86 actually has two cyc2ns_scale's.

 arch/i386/kernel/timers/timer_hpet.c |    2 +-
 arch/i386/kernel/timers/timer_tsc.c  |    2 +-
 arch/x86_64/kernel/time.c            |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/i386/kernel/timers/timer_hpet.c~mark-cyc2ns_scale-readmostly arch/i386/kernel/timers/timer_hpet.c
--- devel/arch/i386/kernel/timers/timer_hpet.c~mark-cyc2ns_scale-readmostly	2006-03-17 21:34:19.000000000 -0800
+++ devel-akpm/arch/i386/kernel/timers/timer_hpet.c	2006-03-17 21:34:19.000000000 -0800
@@ -46,7 +46,7 @@ static seqlock_t monotonic_lock = SEQLOC
  *
  *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
  */
-static unsigned long cyc2ns_scale;
+static unsigned long cyc2ns_scale __read_mostly;
 #define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
 
 static inline void set_cyc2ns_scale(unsigned long cpu_khz)
diff -puN arch/i386/kernel/timers/timer_tsc.c~mark-cyc2ns_scale-readmostly arch/i386/kernel/timers/timer_tsc.c
--- devel/arch/i386/kernel/timers/timer_tsc.c~mark-cyc2ns_scale-readmostly	2006-03-17 21:34:19.000000000 -0800
+++ devel-akpm/arch/i386/kernel/timers/timer_tsc.c	2006-03-17 21:34:19.000000000 -0800
@@ -74,7 +74,7 @@ late_initcall(start_lost_tick_compensati
  *
  *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
  */
-static unsigned long cyc2ns_scale; 
+static unsigned long cyc2ns_scale __read_mostly;
 #define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
 
 static inline void set_cyc2ns_scale(unsigned long cpu_khz)
diff -puN arch/x86_64/kernel/time.c~mark-cyc2ns_scale-readmostly arch/x86_64/kernel/time.c
--- devel/arch/x86_64/kernel/time.c~mark-cyc2ns_scale-readmostly	2006-03-17 21:34:19.000000000 -0800
+++ devel-akpm/arch/x86_64/kernel/time.c	2006-03-17 21:34:19.000000000 -0800
@@ -477,7 +477,7 @@ static irqreturn_t timer_interrupt(int i
 	return IRQ_HANDLED;
 }
 
-static unsigned int cyc2ns_scale;
+static unsigned int cyc2ns_scale __read_mostly;
 #define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
 
 static inline void set_cyc2ns_scale(unsigned long cpu_khz)
_

