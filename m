Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbTFYSLS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbTFYSLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:11:17 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:22144 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S264902AbTFYSLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:11:14 -0400
Date: Wed, 25 Jun 2003 22:23:05 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [2.4] current bk ipmi build fix
Message-ID: <20030625182304.GA12492@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Not that I really have the hardware, but it breaks my "allyesconfig" build.
   So here is this compile fix for ipmi driver in current 2.4 bk tree.
   (I see that Alan have some similarly named fix in his tree and
    actually there is whole new version of the driver on the net somewhere,
    but it is unclear when it is planned to be pushed to 2.4 tree,
    so I'd better post this now ;) ).

Bye,
    Oleg
===== drivers/char/ipmi/ipmi_kcs_intf.c 1.3 vs edited =====
--- 1.3/drivers/char/ipmi/ipmi_kcs_intf.c	Sat May 24 01:12:48 2003
+++ edited/drivers/char/ipmi/ipmi_kcs_intf.c	Wed Jun 25 22:09:39 2003
@@ -1032,9 +1032,9 @@
 
 #include <linux/acpi.h>
 /* A real hack, but everything's not there yet in 2.4. */
-#define COMPILER_DEPENDENT_UINT64 unsigned long
-#include <../drivers/acpi/include/acpi.h>
-#include <../drivers/acpi/include/actypes.h>
+#include <acpi/acpi.h>
+#include <acpi/actypes.h>
+#include <acpi/actbl.h>
 
 struct SPMITable {
 	s8	Signature[4];
@@ -1059,7 +1059,7 @@
 static unsigned long acpi_find_bmc(void)
 {
 	acpi_status       status;
-	acpi_table_header *spmi;
+	struct acpi_table_header *spmi;
 	static unsigned long io_base = 0;
 
 	if (io_base != 0)
