Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTICPsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTICPsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:48:37 -0400
Received: from rrzd2.rz.uni-regensburg.de ([132.199.1.12]:58001 "EHLO
	rrzd2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S262361AbTICPsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:48:35 -0400
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx
	doesn't work
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
Reply-To: christian.guggenberger@physik.uni-regensburg.de
To: linux-kernel@vger.kernel.org, dth@ncc1701.cistron.net,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
Content-Type: text/plain
Message-Id: <1062604114.626.4.camel@bonnie79>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 17:48:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Some days ago a patch for 2.6 has been posted on bugzilla, (see some of the 
>>last entries of Bug #10).
>>This one got IO-APIC + ACPI working for the first time in a year on my EPOX 
>>8k5a3+.
>>(via-rhine, usb , sound )
>>Please try !

>You mean this one? (so small, probably no-one minds)

yep, this one. 
please cc me next time, cause I'm not subcribed.

Christian


diff -uNr linux-2.6.0-test4-bk2.orig/drivers/acpi/pci_link.c linux-2.6.0-test4-bk2/drivers/acpi/pci_link.c
--- linux-2.6.0-test4-bk2.orig/drivers/acpi/pci_link.c	2003-08-23 01:52:08.000000000 +0200
+++ linux-2.6.0-test4-bk2/drivers/acpi/pci_link.c	2003-08-30 10:05:20.514059029 +0200
@@ -360,6 +360,8 @@
 		return_VALUE(-ENODEV);
 	}
 
+
+#ifdef DONT_REMOVE_CHECK
 	/* Make sure the active IRQ is the one we requested. */
 	result = acpi_pci_link_get_current(link);
 	if (result) {
@@ -375,6 +377,10 @@
 		return_VALUE(-ENODEV);
 	}
 
+#else
+        link->irq.active = irq;
+#endif
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Set IRQ %d\n", link->irq.active));
 	
 	return_VALUE(0);

