Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263247AbTCNGGa>; Fri, 14 Mar 2003 01:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263249AbTCNGGa>; Fri, 14 Mar 2003 01:06:30 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:10552
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263247AbTCNGG3>; Fri, 14 Mar 2003 01:06:29 -0500
Date: Fri, 14 Mar 2003 01:13:37 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrey Panin <pazke@orbita1.ru>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] irq handling code consolidation (i386 part)
In-Reply-To: <20030313132449.GH1393@pazke>
Message-ID: <Pine.LNX.4.50.0303140057580.17112-100000@montezuma.mastecende.com>
References: <20030313132449.GH1393@pazke>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Mar 2003, Andrey Panin wrote:

> Hi,
> 
> irq handling consolidation continues !
> 
> i386 specific patch attached. Compiled and WorksForMe(tm)

I'm still going through a few tests but here are some compile fixes for 
some configurations i was trying.

ccache gcc -Wp,-MD,kernel/.irq.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -g -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i586 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=irq -DKBUILD_MODNAME=irq -c -o kernel/irq.o kernel/irq.c

kernel/irq.c: In function `no_irq_ack':
kernel/irq.c:84: warning: implicit declaration of function `ack_APIC_irq'

CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

Index: linux-2.5.64-unwashed/include/asm/hw_irq.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/include/asm-i386/hw_irq.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 hw_irq.h
--- linux-2.5.64-unwashed/include/asm/hw_irq.h	14 Mar 2003 05:56:40 -0000	1.1.1.2
+++ linux-2.5.64-unwashed/include/asm/hw_irq.h	14 Mar 2003 06:07:48 -0000
@@ -16,6 +16,7 @@
 #include <linux/profile.h>
 #include <asm/atomic.h>
 #include <asm/irq.h>
+#include <asm/apic.h>
 
 /*
  * Various low-level irq details needed by irq.c, process.c,
