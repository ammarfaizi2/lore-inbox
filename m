Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbTEBU3A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 16:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbTEBU3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 16:29:00 -0400
Received: from air-2.osdl.org ([65.172.181.6]:14732 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id S263029AbTEBU27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 16:28:59 -0400
Date: Fri, 2 May 2003 13:41:22 -0700
From: Bob Miller <rem@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH 2.5.68] Convert ipmi_kcs_intf.c to remove check_region().
Message-ID: <20030502204122.GA25713@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the now defunct check_mem_region() and check_region() calls.
The driver doesn't use the memory/ioport address between the check_region()
and request_region() calls so it is safe to just remove the check_region()
call.


-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


diff -Nru a/drivers/char/ipmi/ipmi_kcs_intf.c b/drivers/char/ipmi/ipmi_kcs_intf.c
--- a/drivers/char/ipmi/ipmi_kcs_intf.c	Fri May  2 09:52:22 2003
+++ b/drivers/char/ipmi/ipmi_kcs_intf.c	Fri May  2 09:52:22 2003
@@ -1118,24 +1118,14 @@
 	if (kcs_trydefaults) {
 #ifdef CONFIG_ACPI
 		if ((physaddr = acpi_find_bmc())) {
-			if (!check_mem_region(physaddr, 2)) {
-				rv = init_one_kcs(0, 
-						  0, 
-						  physaddr, 
-						  &(kcs_infos[pos]));
-				if (rv == 0)
-					pos++;
-			}
-		}
-#endif
-		if (!check_region(DEFAULT_IO_PORT, 2)) {
-			rv = init_one_kcs(DEFAULT_IO_PORT, 
-					  0, 
-					  0, 
-					  &(kcs_infos[pos]));
+			rv = init_one_kcs(0, 0, physaddr, &(kcs_infos[pos]));
 			if (rv == 0)
 				pos++;
 		}
+#endif
+		rv = init_one_kcs(DEFAULT_IO_PORT, 0, 0, &(kcs_infos[pos]));
+		if (rv == 0)
+			pos++;
 	}
 
 	if (kcs_infos[0] == NULL) {
