Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263485AbTICOxg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263492AbTICOxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:53:36 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:28942 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S263485AbTICOxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:53:32 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx doesn't work
Date: Wed, 3 Sep 2003 14:53:31 +0000 (UTC)
Organization: Cistron
Message-ID: <bj4v9b$c48$1@news.cistron.nl>
References: <20030903113737.A3655@pc9391.uni-regensburg.de> <20030903114611.C3655@pc9391.uni-regensburg.de>
X-Trace: ncc1701.cistron.net 1062600811 12424 62.216.30.38 (3 Sep 2003 14:53:31 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Guggenberger  <Christian.Guggenberger@physik.uni-regensburg.de> wrote:
>Some days ago a patch for 2.6 has been posted on bugzilla, (see some of the 
>last entries of Bug #10).
>This one got IO-APIC + ACPI working for the first time in a year on my EPOX 
>8k5a3+.
>(via-rhine, usb , sound )
>Please try !

You mean this one? (so small, probably no-one minds)

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

------------

Danny

-- 
I think so Brain, but why does a forklift 
have to be so big if all it does is lift forks?

