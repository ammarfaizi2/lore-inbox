Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVAUWpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVAUWpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVAUWpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:45:06 -0500
Received: from rav-az.mvista.com ([65.200.49.157]:42685 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S262537AbVAUWnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 17:43:53 -0500
Message-ID: <41F18A18.90109@mvista.com>
Date: Fri, 21 Jan 2005 16:02:48 -0700
From: Randy Vinson <rvinson@mvista.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: RESEND: [PATCH][PPC32] Missing call to ioremap in pci_iomap()]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
   The PPC version of pci_iomap seems to be missing a call to ioremap.
This patch corrects that oversight and has been tested on a IBM PPC750FX
Eval board. Please apply. Thanks.

Signed-off-by Randy Vinson <rvinson@mvista.com>


===== arch/ppc/kernel/pci.c 1.48 vs edited =====
--- 1.48/arch/ppc/kernel/pci.c  Wed Oct 20 01:37:05 2004
+++ edited/arch/ppc/kernel/pci.c        Wed Jan 12 11:19:14 2005
@@ -1712,7 +1712,11 @@
         if (flags & IORESOURCE_IO)
                 return ioport_map(start, len);
         if (flags & IORESOURCE_MEM)
-               return (void __iomem *) start;
+               /* Not checking IORESOURCE_CACHEABLE because PPC does
+                * not currently distinguish between ioremap and
+                * ioremap_nocache.
+                */
+               return ioremap(start, len);
         /* What? */
         return NULL;
  }

