Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbTFUXkV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 19:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbTFUXkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 19:40:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42472 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264146AbTFUXkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 19:40:16 -0400
Date: Sun, 22 Jun 2003 01:54:18 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Corey Minyard <minyard@mvista.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [2.4 patch] fix IPMI compile with new ACPI
Message-ID: <20030621235417.GH23337@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes the compilation of ipmi_kcs_intf.c in 2.4.22-pre1.

The changes are:
- remove two now unneeded includes (since the files moved there was a 
  compile error, but they are indirectly included via linux/acpi.h)
- remove unneeded COMPILER_DEPENDENT_UINT64; besides that it's
  unneeded it was wrong on 32 bit architectures
- s/acpi_table_header/struct acpi_table_header/

-ac contains a similar patch that differs because it also adds 
#include's for acpi/acpi.h and acpi/actypes.h (indirectly included via 
linux/acpi.h).

cu
Adrian

--- linux-2.4.22-pre1-full/drivers/char/ipmi/ipmi_kcs_intf.c.old	2003-06-22 01:28:28.000000000 +0200
+++ linux-2.4.22-pre1-full/drivers/char/ipmi/ipmi_kcs_intf.c	2003-06-22 01:40:12.000000000 +0200
@@ -1031,10 +1031,6 @@
    from Hewlett-Packard simple bmc.c, a GPL KCS driver. */
 
 #include <linux/acpi.h>
-/* A real hack, but everything's not there yet in 2.4. */
-#define COMPILER_DEPENDENT_UINT64 unsigned long
-#include <../drivers/acpi/include/acpi.h>
-#include <../drivers/acpi/include/actypes.h>
 
 struct SPMITable {
 	s8	Signature[4];
@@ -1059,7 +1055,7 @@
 static unsigned long acpi_find_bmc(void)
 {
 	acpi_status       status;
-	acpi_table_header *spmi;
+	struct acpi_table_header *spmi;
 	static unsigned long io_base = 0;
 
 	if (io_base != 0)
