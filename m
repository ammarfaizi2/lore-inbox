Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTDRLRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 07:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTDRLRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 07:17:55 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:50937 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S263023AbTDRLRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 07:17:53 -0400
Date: Fri, 18 Apr 2003 07:25:47 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH][2.4] Move common_irq() code to a better place
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304180729_MC3-1-34EE-CBE9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch moves the common_irq() code to after the first 16
interrupt handler stubs, allowing the first 29 or so stubs to pack
better into cache lines. (I sent it to l-k already but didn't label it
as a patch.)

--- linux-2.4.20aa1/arch/i386/kernel/i8259.c    Tue Sep 18 02:03:09 2001
+++ linux-2.4.20irq/arch/i386/kernel/i8259.c    Thu Apr 17 22:22:12 2003
@ -35,8 +35,6 @
  * interrupt-controller happy.
  */
 
-BUILD_COMMON_IRQ()
-
 #define BI(x,y) \
        BUILD_IRQ(x##y)
 
@ -52,6 +50,8 @
  */
 BUILD_16_IRQS(0x0)
 
+BUILD_COMMON_IRQ()
+
 #ifdef CONFIG_X86_IO_APIC
 /*
  * The IO-APIC gives us many more interrupt sources. Most of these 


------
 Chuck
