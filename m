Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262945AbUJ0WUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbUJ0WUp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbUJ0WSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:18:02 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:29903 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262918AbUJ0WNG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:13:06 -0400
Subject: 2.6.10-rc4-mm1 hpet compile fix for AMD64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-UFrdo1C6rtXJ/yWsP0uq"
Organization: 
Message-Id: <1098914436.20643.155.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Oct 2004 15:00:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UFrdo1C6rtXJ/yWsP0uq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

Here is the HPET compile fix for AMD64. Without this, you 
get following link error. (without HPET)

arch/x86_64/kernel/built-in.o(.text+0x6426): In function `timer_resume':
arch/x86_64/kernel/time.c:971: undefined reference to `is_hpet_enabled'


Thanks,
Badari



--=-UFrdo1C6rtXJ/yWsP0uq
Content-Disposition: attachment; filename=hpet_compile_fix.patch
Content-Type: text/plain; name=hpet_compile_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux.org/arch/x86_64/kernel/time.c	2004-10-27 15:33:22.369395312 -0700
+++ linux/arch/x86_64/kernel/time.c	2004-10-27 15:36:09.458993832 -0700
@@ -968,8 +968,10 @@ static int timer_resume(struct sys_devic
 	unsigned long flags;
 	unsigned long sec;
 
+#ifdef CONFIG_HPET_EMULATE_RTC
 	if (is_hpet_enabled())
 		hpet_reenable();
+#endif
 
 	sec = get_cmos_time() + clock_cmos_diff;
 	write_seqlock_irqsave(&xtime_lock,flags);

--=-UFrdo1C6rtXJ/yWsP0uq--

