Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132886AbRDEUNJ>; Thu, 5 Apr 2001 16:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132978AbRDEUMt>; Thu, 5 Apr 2001 16:12:49 -0400
Received: from jffdns01.or.intel.com ([134.134.248.3]:55563 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S132886AbRDEUMm>; Thu, 5 Apr 2001 16:12:42 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE810@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Trever L. Adams'" <trever_Adams@bigfoot.com>,
        linux Kernel <linux-kernel@vger.kernel.org>
Cc: "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RE: 2.4.3 (and possibly 2.4.2) don't enter S5 (ACPI) on shutdown
Date: Thu, 5 Apr 2001 13:11:47 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Trever L. Adams [mailto:trever_Adams@bigfoot.com]
> 2.4.3 no longer shuts down automatically with S5.
> 
> [2.] Full description of the problem/report:
> 
> 2.4.3 no longer shuts down automatically with S5.  I have an Athlon 
> based system using the FIC-SD11 motherboard.  In 2.4.1 and possibly 
> 2.4.2 the system used to shut down just fine.

This is the most likely culprit. Trevor please let me know if this does it:

--- linux/drivers/acpi/hardware/hwsleep.c.orig	Fri Feb  9 11:45:58 2001
+++ linux/drivers/acpi/hardware/hwsleep.c	Thu Apr  5 12:11:54 2001
@@ -179,8 +179,6 @@
 
 	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_a_CONTROL, PM1_acontrol);
 	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_b_CONTROL, PM1_bcontrol);
-	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_CONTROL,
-		(1 << acpi_hw_get_bit_shift (SLP_EN_MASK)));
 
 	enable();


