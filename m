Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263268AbTCNH6D>; Fri, 14 Mar 2003 02:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263270AbTCNH6D>; Fri, 14 Mar 2003 02:58:03 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:13369
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263268AbTCNH6C>; Fri, 14 Mar 2003 02:58:02 -0500
Date: Fri, 14 Mar 2003 03:05:31 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrey Panin <pazke@orbita1.ru>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] irq handling code consolidation (i386 part)
In-Reply-To: <Pine.LNX.4.50.0303140157480.17112-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303140304330.17112-100000@montezuma.mastecende.com>
References: <20030313132449.GH1393@pazke>
 <Pine.LNX.4.50.0303140057580.17112-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0303140157480.17112-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one is for UP w/ IOAPIC

arch/i386/kernel/built-in.o: In function `end_level_ioapic_irq':
/build/source/linux-2.5.64-unwashed/include/asm/atomic.h:107: undefined reference to `irq_mis_count'
nm: vmlinux: No such file or directory
make -f scripts/Makefile.build obj=arch/i386/boot arch/i386/boot/bzImage
  ccache gcc -Wp,-MD,arch/i386/boot/.setup.o.d -D__ASSEMBLY__ -D__KERNEL__ 
-Iinclude -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include  
-traditional -DSVGA_MODE=NORMAL_VGA  -D__BIG_KERNEL__  -c -o 
arch/i386/boot/setup.o arch/i386/boot/setup.S

Index: linux-2.5.64-unwashed/arch/i386/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/i386/kernel/irq.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 irq.c
--- linux-2.5.64-unwashed/arch/i386/kernel/irq.c	14 Mar 2003 05:56:30 -0000	1.1.1.2
+++ linux-2.5.64-unwashed/arch/i386/kernel/irq.c	14 Mar 2003 08:02:24 -0000
@@ -10,6 +10,7 @@
 #include <linux/seq_file.h>
 
 #include <asm/atomic.h>
+#include <asm/io_apic.h>	/* for APIC_MISMATCH_DEBUG */
 
 /*
  * Various interrupt controllers we handle: 8259 PIC, SMP IO-APIC,
