Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbTDRCyC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 22:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbTDRCyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 22:54:02 -0400
Received: from siaag2ab.compuserve.com ([149.174.40.132]:50430 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262778AbTDRCyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 22:54:00 -0400
Date: Thu, 17 Apr 2003 23:03:26 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: x86 IO-APIC and IRQ questions
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304172305_MC3-1-34EB-3657@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:


>  And why are the IRQ entry points (in 2.4.20) not 16-byte aligned?
> Up until IRQ0x0b everything is OK because the actual stubs are only
> 7+1 bytes long, but after that the jmp instruction needs a 32-bit
> offset and they are 10+2 bytes.  This puts IRQ #15 and #19 four
> bytes from the end of a 16-byte cache line, and their first
> instructions are 5 bytes long.


 This should help:


--- linux-2.4.20aa1/arch/i386/kernel/i8259.c	Tue Sep 18 02:03:09 2001
+++ linux-2.4.20irq/arch/i386/kernel/i8259.c	Thu Apr 17 22:22:12 2003
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


--
 Chuck
