Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277975AbRJWQuS>; Tue, 23 Oct 2001 12:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277970AbRJWQuI>; Tue, 23 Oct 2001 12:50:08 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:24815 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S277975AbRJWQuA>;
	Tue, 23 Oct 2001 12:50:00 -0400
Date: Tue, 23 Oct 2001 18:50:29 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200110231650.SAA01244@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] fix UP_APIC compile in 2.4.12-ac6
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

2.4.12-ac6 still doesn't compile if CONFIG_X86_UP_APIC=y but
CONFIG_X86_UP_IOAPIC=n. The patch below fixes this.

/Mikael

--- linux-2.4.12-ac6/arch/i386/kernel/mpparse.c.~1~	Tue Oct 23 16:50:42 2001
+++ linux-2.4.12-ac6/arch/i386/kernel/mpparse.c	Tue Oct 23 17:33:08 2001
@@ -118,7 +118,11 @@
 	return n;
 }
 
+#ifdef CONFIG_X86_IO_APIC
 extern int have_acpi_tables;	/* set by acpitable.c */
+#else
+#define have_acpi_tables (0)
+#endif
 
 void __init MP_processor_info (struct mpc_config_processor *m)
 {
