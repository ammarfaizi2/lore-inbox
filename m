Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVALSFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVALSFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVALSFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:05:51 -0500
Received: from rav-az.mvista.com ([65.200.49.157]:18526 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261286AbVALSFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:05:37 -0500
Message-ID: <41E56B2B.1040407@mvista.com>
Date: Wed, 12 Jan 2005 11:23:39 -0700
From: Randy Vinson <rvinson@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Missing call to ioremap in pci_iomap()
Content-Type: text/plain; charset=us-ascii; format=flowed
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

