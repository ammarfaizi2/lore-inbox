Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270417AbTGNME1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270423AbTGNME0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:04:26 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35972
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270417AbTGNMDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:03:19 -0400
Date: Mon, 14 Jul 2003 13:17:19 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141217.h6ECHJpD030842@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: allow legacy free hw with no smi cmd port
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/acpi/hardware/hwacpi.c linux.22-pre5-ac1/drivers/acpi/hardware/hwacpi.c
--- linux.22-pre5/drivers/acpi/hardware/hwacpi.c	2003-07-14 12:27:34.000000000 +0100
+++ linux.22-pre5-ac1/drivers/acpi/hardware/hwacpi.c	2003-07-07 16:30:46.000000000 +0100
@@ -208,6 +208,10 @@
 
 	ACPI_FUNCTION_TRACE ("hw_get_mode");
 
+	/* If there's no smi_cmd port, then it's ACPI only hw */
+	if (!acpi_gbl_FADT->smi_cmd)
+		return_VALUE (ACPI_SYS_MODE_ACPI);
+
 	status = acpi_get_register (ACPI_BITREG_SCI_ENABLE, &value, ACPI_MTX_LOCK);
 	if (ACPI_FAILURE (status)) {
 		return_VALUE (ACPI_SYS_MODE_LEGACY);
