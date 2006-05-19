Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWESDk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWESDk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 23:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWESDk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 23:40:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45559 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932213AbWESDkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 23:40:55 -0400
Date: Thu, 18 May 2006 23:40:54 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH][RESEND]   Compile warning in arch/i386/kernel/setup.c
To: linux-kernel@vger.kernel.org
Message-id: <446D3E46.7080707@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_A4/i3lqiVrevqKNkXyJg8Q)"
User-Agent: Thunderbird 1.5 (X11/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_A4/i3lqiVrevqKNkXyJg8Q)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Hi,

    I got an "implicit function declaration" warning because check_acpi_pci() depends on CONFIG_ACPI, NOT on CONFIG_X86_IO_APIC.

    The following patch fixes this warning and applies to kernel 2.6.16.16.

Regards,

Stephane.


--Boundary_(ID_A4/i3lqiVrevqKNkXyJg8Q)
Content-type: text/x-patch; CHARSET=US-ASCII; name=kernel.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=kernel.patch

--- linux-2.6.16.16/arch/i386/kernel/setup.c	2006-05-18 11:34:10.000000000 -0400
+++ linux-2.6.16.16-fixed/arch/i386/kernel/setup.c	2006-05-18 11:51:46.000000000 -0400
@@ -1599,11 +1599,9 @@
 	if (efi_enabled)
 		efi_map_memmap();
 
-#ifdef CONFIG_X86_IO_APIC
+#ifdef CONFIG_ACPI
 	check_acpi_pci();	/* Checks more than just ACPI actually */
-#endif
 
-#ifdef CONFIG_ACPI
 	/*
 	 * Parse the ACPI tables for possible boot-time SMP configuration.
 	 */

--Boundary_(ID_A4/i3lqiVrevqKNkXyJg8Q)--
