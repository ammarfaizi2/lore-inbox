Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263055AbTC1RBQ>; Fri, 28 Mar 2003 12:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263057AbTC1RBQ>; Fri, 28 Mar 2003 12:01:16 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:64507
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263055AbTC1RBP>; Fri, 28 Mar 2003 12:01:15 -0500
Date: Fri, 28 Mar 2003 12:08:48 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Greg Copeland <gtcopeland@earthlink.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.65 7880 SCSI bug
In-Reply-To: <1048867005.2304.4.camel@mouse.copelandconsulting.net>
Message-ID: <Pine.LNX.4.50.0303281146360.2884-100000@montezuma.mastecende.com>
References: <1048867005.2304.4.camel@mouse.copelandconsulting.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003, Greg Copeland wrote:

> I have an Asus P2L97-DS motherboard.  It has two PII-333 in it.  I'm
> using the onboard SCSI interface, which is a 7880 (U).  I have 5-SCSI
> drives (combination of wide and narrow), a SCSI CDROM and a SCSI tape
> drive.  The drives have ID's 0-6 while the interface has ID 7.
> 
> When attempting to boot 2.5.65 or 2.5.64, neither is able to get past
> SCSI initialization.  It simply loops and never completes a boot cycle. 
> I have tried both the "newer" Adaptec AIC7xxx Fast -> U160 support (New
> Driver) and the older Adaptec AIC7xxx support (old driver).  Both
> experience the same behavior.
> 
> I'm currently running 2.4.19 and this system has been working, more or
> less as is, since the mid 2.2-days.

Could you try booting with the following combinations of kernel 
parameters and report back.

1) "noapic"
2) "maxcpus=1"
3) "noirqbalance" with the appended patch.

Note that this didn't do anything for me either, my current workaround 
until i find out what's wrong is booting with noapic.

Index: linux-2.5.66/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.66/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.5.66/arch/i386/kernel/io_apic.c	24 Mar 2003 23:40:27 -0000	1.1.1.1
+++ linux-2.5.66/arch/i386/kernel/io_apic.c	28 Mar 2003 16:48:41 -0000
@@ -1143,7 +1143,7 @@ void __init setup_IO_APIC_irqs(void)
 		entry.delivery_mode = INT_DELIVERY_MODE;
 		entry.dest_mode = INT_DEST_MODE;
 		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = TARGET_CPUS;
+		entry.dest.logical.logical_dest = 1; /* TARGET_CPUS; */
 
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {
-- 
function.linuxpower.ca
