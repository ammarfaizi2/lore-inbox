Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277420AbRJEP2t>; Fri, 5 Oct 2001 11:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277414AbRJEP21>; Fri, 5 Oct 2001 11:28:27 -0400
Received: from ultra02.rbg.informatik.tu-darmstadt.de ([130.83.9.52]:10493
	"EHLO mail.rbg.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id <S277413AbRJEP2X>; Fri, 5 Oct 2001 11:28:23 -0400
Date: Fri, 5 Oct 2001 17:26:52 +0200
From: Philipp Matthias Hahn <pmhahn@informatik.tu-darmstadt.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FIX] Compiler error on linux-2.4.11-pre4/arch/i386/kernel/mpparse.c
Message-ID: <20011005172652.C3260@walker.iti.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML!

patch-2.4.11-pre4 adds the following lines to include/acm-i386/smp.h:90
+#ifndef clustered_apic_mode
+ #ifdef CONFIG_MULTIQUAD
+  #define clustered_apic_mode (1)
+  #define esr_disable (1)
+ #else /* !CONFIG_MULTIQUAD */
+  #define clustered_apic_mode (0)
+  #define esr_disable (0)
+ #endif /* CONFIG_MULTIQUAD */
+#endif

which don't get included when compiling for non-SMP. Move those lines up
before
line 37 with "#ifdef CONFIG_SMP" and compiling should work again.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
