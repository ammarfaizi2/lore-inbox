Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266023AbUEUWXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbUEUWXo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266045AbUEUWXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:23:44 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:14348 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S266023AbUEUWXm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:23:42 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: [PATCH][2.4.26 x86_64] fix ACPI PRT entry handling
Date: Fri, 21 May 2004 15:23:22 -0700
Message-ID: <D621AA393FEB2544B1370005D36B875A05765F86@mail-sc-12.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4.26 x86_64] fix ACPI PRT entry handling
Thread-Index: AcQ/gjuF9mVcvVzTQtqMQRPEzymuVg==
From: "Andy Currid" <acurrid@nvidia.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes a PCI interrupt routing bug that shows up when running
on x86_64 with ACPI and IOAPIC functionality enabled. Without this patch
in place, the code attempts to route all configurable PCI interrupts to
IRQ 0.

Regards

Andy
--
Andy Currid, NVIDIA Corporation 
acurrid@nvidia.com   408 566 6743

--
diff -Nupr linux-2.4.26/arch/x86_64/kernel/mpparse.c
linux-2.4.26-patch/arch/x86_64/kernel/mpparse.c
--- linux-2.4.26/arch/x86_64/kernel/mpparse.c	2004-05-21
06:39:40.000000000 -0700
+++ linux-2.4.26-patch/arch/x86_64/kernel/mpparse.c	2004-05-21
06:39:33.000000000 -0700
@@ -942,8 +942,6 @@ void __init mp_parse_prt (void)
 			irq = entry->link.index;
 		}
 
-		irq = entry->link.index;
-
   		/* Don't set up the ACPI SCI because it's already set up
*/
                 if (acpi_fadt.sci_int == irq) {
                          entry->irq = irq; /*we still need to set
entry's irq*/
