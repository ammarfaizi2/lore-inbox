Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbVD2VFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVD2VFD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbVD2VEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:04:07 -0400
Received: from amistad.itbs.cz ([81.0.238.226]:16 "EHLO amistad.itbs.cz")
	by vger.kernel.org with ESMTP id S262979AbVD2VAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:00:43 -0400
Message-ID: <20050429230350.qid9o7yht3qckkg8@mail.hosting123.cz>
Date: Fri, 29 Apr 2005 23:03:50 +0200
From: jermar@itbs.cz
To: len.brown@intel.com
Cc: torvalds@osdl.org, aul.s.diefenbaugh@intel.com, jun.nakajima@intel.com,
       linux-kernel@vger.kernel.org
Subject: PATCH: acpi_find_rsdp() diverges from ACPI specification
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found out that acpi_find_rsdp() tries to find the RSDP structure in an area
bit larger than the ACPI specification wants. The right interval should start
at 0xe0000 and end at 0xfffff. The search area is thus 128K+1B large.

Given the semantics of acpi_scan_rsdp(), the second argument should therefore be
the size, not the end address.

Should there be any comments, please email me directly as I don't regularily
read LKM.

Please, apply.

Jakub

--- linux-2.6.11.7/arch/i386/kernel/acpi/boot.c 2005-04-07 20:58:17.000000000
+0200
+++ linux-2.6.11.7-acpi-patch/arch/i386/kernel/acpi/boot.c      2005-04-29
21:39:08.000000000 +0200
@@ -644,7 +644,7 @@ acpi_find_rsdp (void)
         */
        rsdp_phys = acpi_scan_rsdp (0, 0x400);
        if (!rsdp_phys)
-               rsdp_phys = acpi_scan_rsdp (0xE0000, 0xFFFFF);
+               rsdp_phys = acpi_scan_rsdp (0xE0000, 128*1024 + 1);

        return rsdp_phys;
 }

Signed-off-by: Jakub Jermar <jermar@itbs.cz>


----------------------------------------------------------------
Powered by http://www.hosting123.cz
