Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTHTXz0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 19:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbTHTXz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 19:55:26 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:25804 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S262349AbTHTXzW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 19:55:22 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [ACPI] RE: [patch] 2.4.x ACPI updates
Date: Wed, 20 Aug 2003 19:55:13 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC96@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] RE: [patch] 2.4.x ACPI updates
Thread-Index: AcNnb+8SF0RNI6rVRteZSnHlXs+ddQAAJGFA
From: "Brown, Len" <len.brown@intel.com>
To: =?iso-8859-1?Q?S=E9rgio_Monteiro_Basto?= <sergiomb@netcabo.pt>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "Jeff Garzik" <jgarzik@pobox.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "J.A. Magallon" <jamagallon@able.es>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <acpi-devel@sourceforge.net>,
       "Patrick Mochel" <mochel@osdl.org>
X-OriginalArrivalTime: 20 Aug 2003 23:55:15.0316 (UTC) FILETIME=[8051EB40:01C36776]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, broke this in 2.6 also -- apparently neglected to test that change w/o CONFIG_SMP...

Patrick suggested a cleaner way to do this code using fewer #ifdefs, so I'll try that out this evening.  Until that arrives, you can just nuke that line and the "noapic" flag will revert to being broken in ACPI mode like it was before this week.

Thanks,
-Len

===== arch/i386/kernel/setup.c 1.91 vs edited =====
--- 1.91/arch/i386/kernel/setup.c	Sat Aug 16 00:28:34 2003
+++ edited/arch/i386/kernel/setup.c	Wed Aug 20 19:48:21 2003
@@ -545,7 +545,7 @@
 
 		/* disable IO-APIC */
 		else if (!memcmp(from, "noapic", 6)) {
-			skip_ioapic_setup = 1;
+//			skip_ioapic_setup = 1;
 		}
 #endif
