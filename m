Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbVCVEUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbVCVEUa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVCVEQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:16:08 -0500
Received: from fmr24.intel.com ([143.183.121.16]:12416 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262355AbVCVEFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:05:50 -0500
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
From: Len Brown <len.brown@intel.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, rjw@sisk.pl,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1111461253.18927.15.camel@sli10-desk.sh.intel.com>
References: <20050322013535.GA1421@elf.ucw.cz>
	 <1111461253.18927.15.camel@sli10-desk.sh.intel.com>
Content-Type: multipart/mixed; boundary="=-vffztkBHwd26xnw6H4Ro"
Organization: 
Message-Id: <1111464268.17329.27.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Mar 2005 23:04:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vffztkBHwd26xnw6H4Ro
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Will this do it for the moment?

If so, lets use it until Pavel's flag-day is over -- when we'll send an
updated patch.

thanks,
-Len



--=-vffztkBHwd26xnw6H4Ro
Content-Disposition: attachment; filename=acpi_pci_choose_state_tbd.patch
Content-Type: text/plain; name=acpi_pci_choose_state_tbd.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/pci/pci-acpi.c 1.4 vs edited =====
--- 1.4/drivers/pci/pci-acpi.c	2005-03-03 04:28:23 -05:00
+++ edited/drivers/pci/pci-acpi.c	2005-03-21 22:59:39 -05:00
@@ -237,19 +237,8 @@
 
 static int acpi_pci_choose_state(struct pci_dev *pdev, pm_message_t state)
 {
-	char dstate_str[] = "_S0D";
-	acpi_status status;
-	unsigned long val;
-	struct device *dev = &pdev->dev;
+	/* TBD */
 
-	/* Fixme: the check is wrong after pm_message_t is a struct */
-	if ((state >= PM_SUSPEND_MAX) || !DEVICE_ACPI_HANDLE(dev))
-		return -EINVAL;
-	dstate_str[2] += state;	/* _S1D, _S2D, _S3D, _S4D */
-	status = acpi_evaluate_integer(DEVICE_ACPI_HANDLE(dev), dstate_str,
-		NULL, &val);
-	if (ACPI_SUCCESS(status))
-		return val;
 	return -ENODEV;
 }
 

--=-vffztkBHwd26xnw6H4Ro--

