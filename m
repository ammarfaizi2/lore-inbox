Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUCHWAj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUCHWAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:00:39 -0500
Received: from hc652af67.dhcp.vt.edu ([198.82.175.103]:34688 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261232AbUCHWAd (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:00:33 -0500
Message-Id: <200403082200.i28M0F2k009714@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc2-mm1 
In-reply-to: Your message of "Sun, 07 Mar 2004 22:32:21 PST."
             <20040307223221.0f2db02e.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040307223221.0f2db02e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Mar 2004 17:00:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Mar 2004 22:32:21 PST, Andrew Morton <akpm@osdl.org>  said:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc2/2.6.4
-rc2-mm1/

> Changes since 2.6.4-rc1-mm2:
> 
> 
>  linus.patch

The Linus patch apparently has a half-done fix - it does it in smp.c but not
in io_apic.c - so building non-SMP we get:

arch/i386/kernel/io_apic.c:703: error: conflicting types for 'send_IPI_self'
include/asm/hw_irq.h:54: error: previous declaration of 'send_IPI_self' was here
arch/i386/kernel/io_apic.c:703: error: conflicting types for 'send_IPI_self'
include/asm/hw_irq.h:54: error: previous declaration of 'send_IPI_self' was here

Fix:

--- linux-2.6.4-rc2-mm1/arch/i386/kernel/io_apic.c.akpm	2004-03-08 16:53:02.337724358 -0500
+++ linux-2.6.4-rc2-mm1/arch/i386/kernel/io_apic.c	2004-03-08 16:53:20.950171060 -0500
@@ -699,7 +699,7 @@
 #endif /* CONFIG_IRQBALANCE */
 
 #ifndef CONFIG_SMP
-void send_IPI_self(int vector)
+void fastcall send_IPI_self(int vector)
 {
 	unsigned int cfg;
 

