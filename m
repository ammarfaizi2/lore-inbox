Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbSKZMNH>; Tue, 26 Nov 2002 07:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbSKZMNH>; Tue, 26 Nov 2002 07:13:07 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20442 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264657AbSKZMNG>; Tue, 26 Nov 2002 07:13:06 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200211261220.gAQCKBt07952@devserv.devel.redhat.com>
Subject: PATCH: fix sis_apic fix (was Re: Linux 2.5.49-ac1)
To: szepe@pinerecords.com (Tomas Szepe)
Date: Tue, 26 Nov 2002 07:20:11 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20021126115614.GK29196@louise.pinerecords.com> from "Tomas Szepe" at Nov 26, 2002 12:56:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Your tree is corrupt, looks like flipped bits (its gone from 'a' to ^A)
> 
> Naah, that's just me pasting text into joe and forgetting to fix it up
> afterwards. :)

Seems I screwed up that bit of the merge and pulled in the prototype not
final sis_apic bits. Apply this on top

--- include/asm-i386/io_apic.h~ 2002-11-26 12:39:26.000000000 +0000
+++ include/asm-i386/io_apic.h  2002-11-26 12:42:17.000000000 +0000
@@ -125,7 +125,8 @@
  */
 static inline void io_apic_modify(unsigned int apic, unsigned int
reg, unsigned int value)
 {
-       if(apic_sis_bug)
+       extern int sis_apic_bug;
+       if(sis_apic_bug)
                *IO_APIC_BASE(apic) = reg;
        *(IO_APIC_BASE(apic)+4) = value;
 }
--- drivers/pci/quirks.c~       2002-11-26 12:43:57.000000000 +0000
+++ drivers/pci/quirks.c        2002-11-26 12:43:57.000000000 +0000
@@ -350,8 +350,9 @@

 static void __init quirk_ioapic_rmw(struct pci_dev *dev)
 {
+       extern int sis_apic_bug;
        if(dev->devfn == 0 && dev->bus->number == 0)
-               apic_sys_bug = 1;
+               sis_apic_bug = 1;
 }
