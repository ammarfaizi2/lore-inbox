Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265420AbTFWWQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbTFWWQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:16:06 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:13268 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S265420AbTFWWPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:15:33 -0400
Date: Tue, 24 Jun 2003 00:29:36 +0200 (MEST)
Message-Id: <200306232229.h5NMTaJU013801@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH][2.5.73] enable local APIC on P4
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current local APIC code refuses to enable the local APIC
on a P4 if the BIOS booted us with the local APIC disabled.
This patch removes this unnecessary restriction. Please apply.

Most P4 machines do boot with the local APIC enabled, but
Keith Owens reported that the P4 based Compaq Evo N800v
disables the local APIC, even though the machine actually
works if Linux enables it.

It is possible that some P4 machines with broken BIOSen
were saved by our refusal to enable the local APIC. We
can handle them via the DMI blacklist rules instead.

/Mikael

--- linux-2.5.73/arch/i386/kernel/apic.c.~1~	2003-06-17 12:51:19.000000000 +0200
+++ linux-2.5.73/arch/i386/kernel/apic.c	2003-06-23 23:00:20.000000000 +0200
@@ -616,7 +616,7 @@
 		goto no_apic;
 	case X86_VENDOR_INTEL:
 		if (boot_cpu_data.x86 == 6 ||
-		    (boot_cpu_data.x86 == 15 && cpu_has_apic) ||
+		    boot_cpu_data.x86 == 15 ||
 		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
 			break;
 		goto no_apic;
