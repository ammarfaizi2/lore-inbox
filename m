Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbVIKKMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVIKKMi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 06:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVIKKMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 06:12:38 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:61638 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S964859AbVIKKMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 06:12:37 -0400
Message-ID: <43240313.10607@free.fr>
Date: Sun, 11 Sep 2005 12:12:35 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: acpi-devel@lists.sourceforge.net
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <ambx1@neo.rr.com>,
       linux-kernel@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH - Resend] PNPACPI: clean blacklist
Content-Type: multipart/mixed;
 boundary="------------020200030207080403050009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020200030207080403050009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch clean the blacklist and should be applied after "only parse
device that have CRS method" patch:
Battery, Button, Fan don't have a CRS and should be removed.
PCI root, PIC, Timer are in pnpbios and are harmless.


Please comment and consider for inclusion.

Thanks,

Matthieu


--------------020200030207080403050009
Content-Type: text/x-patch;
 name="pnpacpi_clean_blacklist.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpacpi_clean_blacklist.patch"

Index: linux-2.6.13rc/drivers/pnp/pnpacpi/core.c
===================================================================
--- linux-2.6.13rc.orig/drivers/pnp/pnpacpi/core.c	2005-08-28 19:26:35.000000000 +0200
+++ linux-2.6.13rc/drivers/pnp/pnpacpi/core.c	2005-08-28 19:34:30.000000000 +0200
@@ -27,15 +27,15 @@
 
 static int num = 0;
 
+/* We need only to blacklist device that have already an acpi driver that
+ * can't use pnp layer. We don't need to blacklist device that are directly 
+ * used by the kernel (PIC, Timer, ...), as it is harmless and there were
+ * already present in pnpbios. Finaly only devices that have a CRS method
+ * need to be in this list.
+ */
 static char __initdata excluded_id_list[] =
-	"PNP0C0A," /* Battery */
-	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
 	"PNP0C09," /* EC */
-	"PNP0C0B," /* Fan */
-	"PNP0A03," /* PCI root */
 	"PNP0C0F," /* Link device */
-	"PNP0000," /* PIC */
-	"PNP0100," /* Timer */
 	;
 static inline int is_exclusive_device(struct acpi_device *dev)
 {


--------------020200030207080403050009--
