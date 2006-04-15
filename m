Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbWDOVuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbWDOVuF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 17:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWDOVuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 17:50:05 -0400
Received: from xenotime.net ([66.160.160.81]:4001 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965154AbWDOVuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 17:50:04 -0400
Date: Sat, 15 Apr 2006 14:52:31 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: sam@ravnborg.org
Subject: some remaining section mismatches
Message-Id: <20060415145231.cbe2e8db.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1.  I don't understand this one.  Can you look at it?

WARNING: drivers/video/macmodes.o - Section mismatch: reference to .init.text:mac_find_mode from __ksymtab between '__ksymtab_mac_find_mode' (at offset 0x0) and '__ksymtab_mac_map_monitor_sense'


2.  This is requires either a whitelist addition or a change to the
struct name in the driver:

WARNING: drivers/scsi/megaraid/megaraid_mbox.o - Section mismatch: reference to .init.text:megaraid_probe_one from .data between 'megaraid_pci_driver_g' (at offset 0x2e0) and 'megaraid_mbox_version'


3.  drivers/char/tpm_infineon.c:

WARNING: drivers/char/tpm/tpm_infineon.o - Section mismatch: reference to .init.text:tpm_inf_pnp_probe from .data between 'tpm_inf_pnp' (at offset 0x18) and 'tpm_inf'
WARNING: drivers/char/tpm/tpm_infineon.o - Section mismatch: reference to .exit.text:tpm_inf_pnp_remove from .data between 'tpm_inf_pnp' (at offset 0x20) and 'tpm_inf'

I don't see a problem here, the driver just isn't using the whitelisted
struct name(s).


4.  drivers/rtc/: rtc-sysfs.c and rtc-test.c:

WARNING: drivers/rtc/rtc-sysfs.o - Section mismatch: reference to .init.text:rtc_sysfs_add_device from .data between 'rtc_sysfs_interface' (at offset 0x18) and 'rtc_attr_group'

This could be OK, hopefully someone can say yes/no.

WARNING: drivers/rtc/rtc-test.o - Section mismatch: reference to .exit.text:test_remove from .data between 'test_drv' (at offset 0x8) and 'dev_attr_irq'

Looks OK, struct name is just not in the whitelist.
Changing the struct name removes the warning.

---
~Randy
