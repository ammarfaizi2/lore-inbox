Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267108AbTGGRqJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 13:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267119AbTGGRqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 13:46:09 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:30889 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S267108AbTGGRp5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 13:45:57 -0400
Subject: Re: Linux 2.4.22-pre3-ac1
From: Steven Cole <elenstev@mesatop.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030707170047.GC13102@louise.pinerecords.com>
References: <200307071634.h67GYZo06861@devserv.devel.redhat.com>
	 <20030707170047.GC13102@louise.pinerecords.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057600778.13991.57.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 07 Jul 2003 11:59:38 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-07 at 11:00, Tomas Szepe wrote:
> > [alan@redhat.com]
> > 
> > Linux 2.4.22-pre3-ac1
> 
> arch/i386/kernel/kernel.o: In function `setup_ioapic_ids_from_mpc':
> arch/i386/kernel/kernel.o(.text.init+0x92b0): undefined reference to `xapic_support'
> arch/i386/kernel/kernel.o(.text.init+0x94e5): undefined reference to `xapic_support'
> make: *** [vmlinux] Error 1
> 
> $ find . -type f|xargs grep apic_sup
> ./arch/i386/kernel/io_apic.c:extern unsigned int xapic_support;
> ./arch/i386/kernel/io_apic.c:           if (!xapic_support && 
> ./arch/i386/kernel/io_apic.c:           if (!xapic_support &&
> Binary file ./arch/i386/kernel/io_apic.o matches
> Binary file ./arch/i386/kernel/kernel.o matches
> $
> 
> ooops

>From the -not-a-real-fix- department, and only for the terminally
impatient, this gets 2.4.22-pre3-ac1 up and running on SMP.

Steven

--- linux-2.4.22-pre3-ac1/arch/i386/kernel/io_apic.c.orig	Mon Jul  7 11:06:36 2003
+++ linux-2.4.22-pre3-ac1/arch/i386/kernel/io_apic.c	Mon Jul  7 11:25:07 2003
@@ -44,7 +44,6 @@
 
 unsigned int int_dest_addr_mode = APIC_DEST_LOGICAL;
 unsigned char int_delivery_mode = dest_LowestPrio;
-extern unsigned int xapic_support;
 
 /*
  * # of IRQ routing registers
@@ -1208,8 +1207,7 @@
 		
 		old_id = mp_ioapics[apic].mpc_apicid;
 
-		if (!xapic_support && 
-		    (mp_ioapics[apic].mpc_apicid >= apic_broadcast_id)) {
+		if ((mp_ioapics[apic].mpc_apicid >= apic_broadcast_id)) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC table!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
@@ -1223,8 +1221,7 @@
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
 		 * I/O APIC IDs no longer have any meaning for xAPICs and SAPICs.
 		 */
-		if (!xapic_support &&
-		    (clustered_apic_mode != CLUSTERED_APIC_XAPIC) &&
+		if ((clustered_apic_mode != CLUSTERED_APIC_XAPIC) &&
 		    (phys_id_present_map & (1 << mp_ioapics[apic].mpc_apicid))) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);



