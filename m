Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbTAWNUN>; Thu, 23 Jan 2003 08:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbTAWNUN>; Thu, 23 Jan 2003 08:20:13 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:29360 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S265177AbTAWNUM>; Thu, 23 Jan 2003 08:20:12 -0500
Date: Thu, 23 Jan 2003 14:29:14 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ducrot Bruno <ducrot@poupinou.org>
Subject: [PATCH 2.4-bk] make sonypi use ec_read/ec_write from ACPI patch
Message-ID: <20030123142914.A4308@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ducrot Bruno <ducrot@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch avoids a conflict between the sonypi driver and the 
latest ACPI patch, by letting sonypi use the ACPI provided 
functions ec_read/ec_write.

A variant of this patch (without the conditional testing of the 
ACPI version) is already used in the 2.5 kernel.

Credits for the patch go to Ducrot Bruno.

Marcelo, Alan, please apply this to your trees.

Thanks,

Stelian.

===== drivers/char/sonypi.h 1.13 vs edited =====
--- 1.13/drivers/char/sonypi.h	Thu Jan  9 13:46:12 2003
+++ edited/drivers/char/sonypi.h	Thu Jan 23 14:19:57 2003
@@ -363,6 +363,14 @@
 		printk(KERN_WARNING "sonypi command failed at %s : %s (line %d)\n", __FILE__, __FUNCTION__, __LINE__); \
 }
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#if (ACPI_CA_VERSION > 0x20021121)
+#define USE_ACPI
+#endif
+#endif /* CONFIG_ACPI */
+
+#ifndef USE_ACPI
 extern int verbose;
 
 static inline int ec_write(u8 addr, u8 value) {
@@ -385,6 +393,7 @@
 	*value = inb_p(SONYPI_DATA_IOPORT);
 	return 0;
 }
+#endif /* ! USE_ACPI */
 
 #endif /* __KERNEL__ */
 
-- 
Stelian Pop <stelian@popies.net>
