Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263085AbSJBOL3>; Wed, 2 Oct 2002 10:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263086AbSJBOL3>; Wed, 2 Oct 2002 10:11:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:2574 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263085AbSJBOL2>; Wed, 2 Oct 2002 10:11:28 -0400
Date: Wed, 2 Oct 2002 16:16:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Grover <andrew.grover@intel.com>
Subject: ACPI: do not have *two* acpi_power_off
Message-ID: <20021002141656.GB23402@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Having two acpi_power_off functions is extremely confusing... And the
second one does not even power the machine off ;-). Please apply,

								Pavel

diff -ur clean-2.5.35/drivers/acpi/power.c linux-2.5.35/drivers/acpi/power.c
--- clean-2.5.35/drivers/acpi/power.c	2002-09-16 04:18:30.000000000 +0200
+++ linux-2.5.35/drivers/acpi/power.c	2002-10-02 14:50:41.000000000 +0200
@@ -210,7 +210,7 @@
 
 
 static int
-acpi_power_off (
+acpi_power_off_device (
 	acpi_handle		handle)
 {
 	int			result = 0;
@@ -218,7 +218,7 @@
 	struct acpi_device	*device = NULL;
 	struct acpi_power_resource *resource = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_power_off");
+	ACPI_FUNCTION_TRACE("acpi_power_off_device");
 
 	result = acpi_power_get_context(handle, &resource);
 	if (result)
@@ -351,7 +350,7 @@
 	 * Then we dereference all power resources used in the current list.
 	 */
 	for (i=0; i<cl->count; i++) {
-		result = acpi_power_off(cl->handles[i]);
+		result = acpi_power_off_device(cl->handles[i]);
 		if (result)
 			goto end;
 	}

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
