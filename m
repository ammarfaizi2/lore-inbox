Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbTCAGx3>; Sat, 1 Mar 2003 01:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268516AbTCAGx3>; Sat, 1 Mar 2003 01:53:29 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:31320
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266540AbTCAGx2>; Sat, 1 Mar 2003 01:53:28 -0500
Date: Sat, 1 Mar 2003 02:01:44 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Martin Bligh <mbligh@aracnet.com>
Subject: Re: [PATCH][2.5] why noirqbalance doesn't work
In-Reply-To: <Pine.LNX.4.50.0303010109360.1132-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303010153550.2365-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303010109360.1132-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix the noapic case with the patch applied.

Index: linux-2.5.63-DBE/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.63/arch/i386/kernel/io_apic.c,v
retrieving revision 1.2
diff -u -r1.2 io_apic.c
--- linux-2.5.63-DBE/arch/i386/kernel/io_apic.c	1 Mar 2003 06:52:16 -0000	1.2
+++ linux-2.5.63-DBE/arch/i386/kernel/io_apic.c	1 Mar 2003 06:52:25 -0000
@@ -205,6 +205,9 @@
 	unsigned long flags;
 	int apic, pin;
 
+	if (skip_ioapic_setup == 1)
+		return;
+
 	spin_lock_irqsave(&ioapic_lock, flags);
 	for (apic = 0; apic < nr_ioapics; apic++) {
 		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {

-- 
function.linuxpower.ca
