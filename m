Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbTLaOIl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 09:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264974AbTLaOIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 09:08:41 -0500
Received: from gizmo05ps.bigpond.com ([144.140.71.15]:28078 "HELO
	gizmo05ps.bigpond.com") by vger.kernel.org with SMTP
	id S264971AbTLaOI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 09:08:28 -0500
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-rc1 compile error
Date: Thu, 1 Jan 2004 01:09:12 +1100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401010109.12005.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While "make bzImage", it showed these error messages:
  CC      arch/x86_64/kernel/io_apic.o
arch/x86_64/kernel/io_apic.c:1215: error: redefinition of 
`disable_edge_ioapic_irq'
include/asm/io_apic.h:178: error: `disable_edge_ioapic_irq' previously defined 
here
arch/x86_64/kernel/io_apic.c:1259: error: redefinition of 
`end_edge_ioapic_irq'
include/asm/io_apic.h:180: error: `end_edge_ioapic_irq' previously defined 
here
arch/x86_64/kernel/io_apic.c:1346: error: redefinition of 
`mask_and_ack_level_ioapic_irq'
include/asm/io_apic.h:179: error: `mask_and_ack_level_ioapic_irq' previously 
defined here
make[1]: *** [arch/x86_64/kernel/io_apic.o] Error 1
make: *** [arch/x86_64/kernel] Error 2

I applied this patch (I do not know, it could be wrong):
--- 2.6.1-rc1/arch/x86_64/kernel/io_apic.c.orig 2004-01-01 00:56:40.534040872 
+1100
+++ 2.6.1-rc1/arch/x86_64/kernel/io_apic.c      2004-01-01 00:57:46.491013888 
+1100
@@ -1212,7 +1212,6 @@
  */
 #define enable_edge_ioapic_irq unmask_IO_APIC_irq

-static void disable_edge_ioapic_irq (unsigned int irq) { /* nothing */ }

 /*
  * Starting up a edge-triggered IO-APIC interrupt is
@@ -1256,7 +1255,6 @@
        ack_APIC_irq();
 }

-static void end_edge_ioapic_irq (unsigned int i) { /* nothing */ }


 /*
@@ -1343,7 +1341,6 @@
        }
 }

-static void mask_and_ack_level_ioapic_irq (unsigned int irq) { /* nothing */ 
}

 static void set_ioapic_affinity (unsigned int irq, cpumask_t mask)
 {


Then it compiled the io_apic.c and progressed (maybe a lot). But it failed and 
showed this error message:
  LD      .tmp_vmlinux1
arch/i386/pci/built-in.o(.text+0xc6e): In function `pcibios_lookup_irq':
: undefined reference to `can_request_irq'
make: *** [.tmp_vmlinux1] Error 1

Please feel free to send me patches, I am happy to test and report. BTW I see 
the same behaviour with 2.6.1-rc1-mm1 too.

Thanks
Hari
harisri@bigpond.com

PS: I am hoping for a good 2.6.1 (out of the box) for x86-64

