Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbTFTVwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTFTVwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:52:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:29587 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264937AbTFTVwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:52:32 -0400
Date: Fri, 20 Jun 2003 15:06:31 -0700
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH TRIVIAL 2.5.72] Remove check_region() from ipmi_kcs_intf.c
Message-ID: <20030620220631.GB2063@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the defunct check_*_region() calls.  The init_one_kcs()
call does the heavy lifting of getting the region via calls to the correct
request_*_region() function.

--
Bob Miller                                      Email: rem@osdl.org
Open Source Development Lab                     Phone: 503.626.2455 Ext. 17

diff -Nru a/drivers/char/ipmi/ipmi_kcs_intf.c b/drivers/char/ipmi/ipmi_kcs_intf.c
--- a/drivers/char/ipmi/ipmi_kcs_intf.c	Fri Jun 20 13:57:08 2003
+++ b/drivers/char/ipmi/ipmi_kcs_intf.c	Fri Jun 20 13:57:08 2003
@@ -1104,24 +1104,14 @@
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
