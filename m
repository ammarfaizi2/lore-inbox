Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265349AbUGDCU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265349AbUGDCU5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 22:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265348AbUGDCU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 22:20:57 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:56296 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265331AbUGDCUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 22:20:34 -0400
Date: Sat, 3 Jul 2004 19:19:06 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org, David Mosberger <davidm@hpl.hp.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       bjorn.helgaas@hp.com
Cc: Matt Tolentino <matthew.e.tolentino@intel.com>,
       Russell King <rmk@arm.linux.org.uk>, Paul Jackson <pj@sgi.com>
Message-Id: <20040704021907.32029.98969.47514@sam.engr.sgi.com>
Subject: [patch] Fix ia64 UPF_RESOURCES pcdp.c 2.6.7-mm5 build
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like someone removed UPF_RESOURCES in remove-upf_resources.patch
in parallel with someone adding drivers/firmware/pcdp.c that references
UPF_RESOURCES.

In any event, trying to build a defconfig ia64 2.6.7-mm5 (which includes
CONFIG_SERIAL_8250=y in the .config) fails with:

=================================
  CC      drivers/firmware/pcdp.o
drivers/firmware/pcdp.c: In function `setup_serial_console':
drivers/firmware/pcdp.c:100: error: `UPF_RESOURCES' undeclared (first use in this function)
=================================

The following patch fixes this build error.

Someone with a certified clue needs to sign off on this.
I'm just typing blindly.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 267mm5cpusetv4ia64/drivers/firmware/pcdp.c
===================================================================
--- 267mm5cpusetv4ia64.orig/drivers/firmware/pcdp.c	2004-07-03 16:52:20.000000000 -0700
+++ 267mm5cpusetv4ia64/drivers/firmware/pcdp.c	2004-07-03 16:52:34.000000000 -0700
@@ -97,7 +97,7 @@ setup_serial_console(int rev, struct pcd
 		default:  port.type = PORT_UNKNOWN; break;
 	}
 
-	port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_RESOURCES;
+	port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
 
 	if (uart_irq_supported(rev, uart)) {
 		port.irq = acpi_register_gsi(uart->gsi,

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
