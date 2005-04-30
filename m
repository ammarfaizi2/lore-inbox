Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVD3JlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVD3JlU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 05:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVD3JlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 05:41:20 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:38286 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261172AbVD3JlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 05:41:12 -0400
Message-ID: <4273529C.4060000@ens-lyon.org>
Date: Sat, 30 Apr 2005 11:40:44 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1
References: <20050429231653.32d2f091.akpm@osdl.org>
In-Reply-To: <20050429231653.32d2f091.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050102030008050305070902"
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050102030008050305070902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

CONFIG_X86_MCE_INTEL=y doesn't compile on my Compaq Evo
(except when CONFIG_SMP is set).
I had to include asm/apic.h in mce_intel.c to fix it.
Patch attached.

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Regards,
Brice


   CC      arch/i386/kernel/cpu/mcheck/mce_intel.o
arch/i386/kernel/cpu/mcheck/mce_intel.c: In function 
`smp_thermal_interrupt':
arch/i386/kernel/cpu/mcheck/mce_intel.c:25: warning: implicit 
declaration of function `ack_APIC_irq'
arch/i386/kernel/cpu/mcheck/mce_intel.c: In function `intel_init_thermal':
arch/i386/kernel/cpu/mcheck/mce_intel.c:67: warning: implicit 
declaration of function `apic_read'
arch/i386/kernel/cpu/mcheck/mce_intel.c:67: error: `APIC_LVTTHMR' 
undeclared (first use in this function)
arch/i386/kernel/cpu/mcheck/mce_intel.c:67: error: (Each undeclared 
identifier is reported only once
arch/i386/kernel/cpu/mcheck/mce_intel.c:67: error: for each function it 
appears in.)
arch/i386/kernel/cpu/mcheck/mce_intel.c:68: error: `APIC_DM_SMI' 
undeclared (first use in this function)
arch/i386/kernel/cpu/mcheck/mce_intel.c:77: error: `APIC_VECTOR_MASK' 
undeclared (first use in this function)
arch/i386/kernel/cpu/mcheck/mce_intel.c:85: error: `APIC_DM_FIXED' 
undeclared (first use in this function)
arch/i386/kernel/cpu/mcheck/mce_intel.c:85: error: `APIC_LVT_MASKED' 
undeclared (first use in this function)
arch/i386/kernel/cpu/mcheck/mce_intel.c:86: warning: implicit 
declaration of function `apic_write_around'
make[3]: *** [arch/i386/kernel/cpu/mcheck/mce_intel.o] Error 1
make[2]: *** [arch/i386/kernel/cpu/mcheck] Error 2
make[1]: *** [arch/i386/kernel/cpu] Error 2
make: *** [arch/i386/kernel] Error 2

--------------050102030008050305070902
Content-Type: text/x-patch;
 name="include_apic_in_intel_mce.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="include_apic_in_intel_mce.patch"

--- arch/i386/kernel/cpu/mcheck/mce_intel.c.old	2005-04-30 11:36:56.000000000 +0200
+++ arch/i386/kernel/cpu/mcheck/mce_intel.c	2005-04-30 11:36:19.000000000 +0200
@@ -9,6 +9,7 @@
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/hw_irq.h>
+#include <asm/apic.h>
 #include "mce.h"
 
 static DEFINE_PER_CPU(unsigned long, next_check);

--------------050102030008050305070902--
