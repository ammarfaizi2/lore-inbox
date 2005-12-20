Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVLTLRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVLTLRn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 06:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVLTLRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 06:17:43 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:4576 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S1750787AbVLTLRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 06:17:42 -0500
Date: Tue, 20 Dec 2005 12:17:28 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.15-rc5-rt2 and Kconfig
In-Reply-To: <20051205174321.GA6191@elte.hu>
Message-Id: <Pine.OSF.4.05.10512201211080.2075-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some strange reason I couldn't get 2.6.15-rc5-rt2 to compile. Kconfig
keeped setting CONFIG_RWSEM_XCHGADD_ALGORITHM=y in my .config even though
I had CONFIG_PREEMPT_RT=y.
I don't know much about Kconfig but to me it is odd that  the
RWSEM_XCHGADD_ALGORITHM option is both in arch/i386/Kconfig and
arch/i386/Kconfig.cpu with different dependencies. 
When I removed it from Kconfig.cpu my problem disappeared and I could
compile. But I have no clue what else this change does to the config
system....

Esben



--- linux-2.6-rt/arch/i386/Kconfig.orig 2005-12-16 22:38:26.000000000 +0100
+++ linux-2.6-rt/arch/i386/Kconfig      2005-12-20 02:11:41.000000000 +0100
@@ -245,7 +245,7 @@
 
 config RWSEM_XCHGADD_ALGORITHM
        bool
-       depends on !RWSEM_GENERIC_SPINLOCK && !PREEMPT_RT
+       depends on !RWSEM_GENERIC_SPINLOCK && !PREEMPT_RT && !M386
        default y
 
 config X86_UP_APIC
--- linux-2.6-rt/arch/i386/Kconfig.cpu.orig 2005-12-1300:02:19.000000000 +0100
+++ linux-2.6-rt/arch/i386/Kconfig.cpu  2005-12-20 02:11:47.000000000 +0100
@@ -229,11 +229,6 @@
        depends on M386
        default y
 
-config RWSEM_XCHGADD_ALGORITHM
-       bool
-       depends on !M386
-       default y
-
 config GENERIC_CALIBRATE_DELAY
        bool
        default y


