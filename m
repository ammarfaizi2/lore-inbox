Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269202AbUICVTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269202AbUICVTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 17:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269801AbUICVTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 17:19:04 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:36020 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S269202AbUICVNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 17:13:39 -0400
Date: Fri, 3 Sep 2004 22:13:11 +0100
From: Dave Jones <davej@redhat.com>
To: len.brown@intel.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Pointer dereference before NULL check in ACPI thermal driver.
Message-ID: <20040903211311.GX26419@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, len.brown@intel.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again, found with coverity's checker.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.8/drivers/acpi/thermal.c~	2004-09-03 22:11:22.630428496 +0100
+++ linux-2.6.8/drivers/acpi/thermal.c	2004-09-03 22:11:44.392120216 +0100
@@ -659,7 +659,7 @@
 	struct acpi_thermal	*tz = (struct acpi_thermal *) data;
 	unsigned long		sleep_time = 0;
 	int			i = 0;
-	struct acpi_thermal_state state = tz->state;
+	struct acpi_thermal_state state;
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_check");
 
@@ -668,6 +668,8 @@
 		return_VOID;
 	}
 
+	state = tz->state;
+
 	result = acpi_thermal_get_temperature(tz);
 	if (result)
 		return_VOID;
