Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbTFLItE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 04:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264789AbTFLItE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 04:49:04 -0400
Received: from [81.80.245.157] ([81.80.245.157]:59063 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S264788AbTFLItB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 04:49:01 -0400
Date: Thu, 12 Jun 2003 11:02:53 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Export 'acpi_disabled' symbol to modules...
Message-ID: <20030612090253.GB6337@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	acpi-devel@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The ACPI subsystem can be today (from a driver point of view) in 
three configurations: not compiled (CONFIG_ACPI=n), compiled and 
running or compiled and disabled (with acpi=off).

A driver which wants to use some ACPI exported routines (in my
case it's the sonypi driver which wants to use ec_read/ec_write),
needs to know exactly what the ACPI state is.

The only way to do this today (from what I've seen) is to do:

#ifdef CONFIG_ACPI
	if (!acpi_disabled)
		return ec_write(addr, value);
#endif
	return my_ec_emulated_write(...);

This way on doing things needs however that the 'acpi_disabled' 
variable be exported to modules.

Please apply the attached patch or advise on a better way to know
if ACPI is enabled or not (patch generated against the today 2.5 BK
tree).

Thanks,

Stelian.

===== arch/i386/kernel/setup.c 1.84 vs edited =====
--- 1.84/arch/i386/kernel/setup.c	Sun Jun  8 00:17:53 2003
+++ edited/arch/i386/kernel/setup.c	Tue Jun 10 10:02:00 2003
@@ -61,7 +61,8 @@
 unsigned long mmu_cr4_features;
 EXPORT_SYMBOL_GPL(mmu_cr4_features);
 
-int acpi_disabled __initdata = 0;
+int acpi_disabled;
+EXPORT_SYMBOL(acpi_disabled);
 
 int MCA_bus;
 /* for MCA, but anyone else can use it if they want */

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
