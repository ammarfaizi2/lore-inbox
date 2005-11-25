Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbVKYDxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbVKYDxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 22:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbVKYDxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 22:53:54 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:970 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751401AbVKYDxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 22:53:53 -0500
Date: Fri, 25 Nov 2005 09:23:18 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] memorize where 8259 is connected fix
Message-ID: <20051125035318.GA3796@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o A minor fix to the patch which remembers the location of where i8259
  is connected. Now counter i has been replaced by apic. counter i is having
  some junk value which was leading to non-detection of i8259 connected to
  IOAPIC.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---


diff -puN arch/x86_64/kernel/io_apic.c~kexec-memorize-where-i8259-connected-fix arch/x86_64/kernel/io_apic.c
--- linux-2.6.15-rc2-mm1-1M/arch/x86_64/kernel/io_apic.c~kexec-memorize-where-i8259-connected-fix	2005-11-24 05:49:44.000000000 -0800
+++ linux-2.6.15-rc2-mm1-1M-root/arch/x86_64/kernel/io_apic.c	2005-11-24 05:50:22.000000000 -0800
@@ -1240,7 +1240,7 @@ static void __init enable_IO_APIC(void)
 	for(apic = 0; apic < nr_ioapics; apic++) {
 		int pin;
 		/* See if any of the pins is in ExtINT mode */
-		for(pin = 0; pin < nr_ioapic_registers[i]; pin++) {
+		for(pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
 			struct IO_APIC_route_entry entry;
 			spin_lock_irqsave(&ioapic_lock, flags);
 			*(((int *)&entry) + 0) = io_apic_read(apic, 0x10 + 2 * pin);
diff -puN arch/i386/kernel/io_apic.c~kexec-memorize-where-i8259-connected-fix arch/i386/kernel/io_apic.c
--- linux-2.6.15-rc2-mm1-1M/arch/i386/kernel/io_apic.c~kexec-memorize-where-i8259-connected-fix	2005-11-24 05:50:38.000000000 -0800
+++ linux-2.6.15-rc2-mm1-1M-root/arch/i386/kernel/io_apic.c	2005-11-24 05:50:55.000000000 -0800
@@ -1649,7 +1649,7 @@ static void __init enable_IO_APIC(void)
 	for(apic = 0; apic < nr_ioapics; apic++) {
 		int pin;
 		/* See if any of the pins is in ExtINT mode */
-		for(pin = 0; pin < nr_ioapic_registers[i]; pin++) {
+		for(pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
 			struct IO_APIC_route_entry entry;
 			spin_lock_irqsave(&ioapic_lock, flags);
 			*(((int *)&entry) + 0) = io_apic_read(apic, 0x10 + 2 * pin);
_
