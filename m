Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVFXQWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVFXQWX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 12:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVFXQWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 12:22:23 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:10640 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262256AbVFXQWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 12:22:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type;
        b=o8+9mdHTf3vsIydMHiw0ft4jfjywGAZ5pe4vBFvNmZYVM2h5eZqCLTsGecv3tfLh8qr5a6qEv/lWMMIOqghUUhWf/sQYQni1sq+ocJrIg4ewo1h5Yesb0mGMHLwODnkRAOB56uftWBX2JrDr0GA83cd7iTXumtL5kZbx17OFY2E=
Message-ID: <42BC41C4.7010501@gmail.com>
Date: Fri, 24 Jun 2005 20:24:20 +0300
From: Pasha Zubkov <pasha.zubkov@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050310)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.12.1 & disabled CONFIG_PCI
Content-Type: multipart/mixed;
 boundary="------------060302040109080907090504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060302040109080907090504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

If CONFIG_PCI disabled then kernel can't compile properly.

This is an error:
--
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `pnpacpi_allocated_resource':
rsparser.c:(.text+0x31955): undefined reference to
`pcibios_penalize_isa_irq'
make[1]: *** [.tmp_vmlinux1] Error 1
--

This is a small patch for ./drivers/pnp/pnpacpi/rsparser.c

--------------060302040109080907090504
Content-Type: text/plain;
 name="rsparser.c_undefined_reference.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rsparser.c_undefined_reference.diff"

--- linux-2.6.12.1/drivers/pnp/pnpacpi/rsparser.c	2005-06-24 20:12:26.000000000 +0300
+++ /usr/src/linux-2.6.12.1/drivers/pnp/pnpacpi/rsparser.c	2005-06-24 20:03:32.000000000 +0300
@@ -20,7 +20,13 @@
  */
 #include <linux/kernel.h>
 #include <linux/acpi.h>
+
+#ifdef CONFIG_PCI
 #include <linux/pci.h>
+#else
+inline void pcibios_penalize_isa_irq(int irq) {}
+#endif /* CONFIG_PCI */
+
 #include "pnpacpi.h"
 
 #ifdef CONFIG_IA64

--------------060302040109080907090504--
