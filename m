Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317184AbSFFVAo>; Thu, 6 Jun 2002 17:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSFFU7r>; Thu, 6 Jun 2002 16:59:47 -0400
Received: from users.ccur.com ([208.248.32.211]:16195 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S317176AbSFFU7N>;
	Thu, 6 Jun 2002 16:59:13 -0400
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200206062059.UAA14586@rudolph.ccur.com>
Subject: [PATCH] 2.4.19-pre10 bug in disable_APIC_timer
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Thu, 6 Jun 2002 16:59:02 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
 This one bit me when I actually started using the (relatively) new
services disable_APIC_timer() and enable_APIC_timer().  Enable_APIC_timer()
is coded correctly; this patch fixes the bug in the disable service.

Please apply.  Patch is against 2.4.19-pre10.

Joe


--- linux/arch/i386/kernel/apic.c.orig	Thu Jun  6 15:21:26 2002
+++ linux/arch/i386/kernel/apic.c	Thu Jun  6 15:24:05 2002
@@ -941,7 +941,7 @@
 	smp_call_function(setup_APIC_timer, (void *)calibration_result, 1, 1);
 }
 
-void __init disable_APIC_timer(void)
+void disable_APIC_timer(void)
 {
 	if (using_apic_timer) {
 		unsigned long v;

