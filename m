Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264209AbTKTEl4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 23:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTKTEl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 23:41:56 -0500
Received: from fmr03.intel.com ([143.183.121.5]:37517 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S264209AbTKTElx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 23:41:53 -0500
Subject: [BKPATCH] ACPI 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1069303294.2855.161.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 19 Nov 2003 23:41:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.6.0

	The world will not stop revolving if these wait till 2.6.1,
	but it will make 2.6.0 easier to support if they're included.

	3 bug fixes -- all are in 2.4:

	1390: adds cmdline to allow manual over-ride if out policy
		of forcing the ACPI SCI to level triggered is wrong.

		If we don't apply, some folks with no ACPI events
		will need to patch.

	1177: makes print_IO_APIC() output useful instead of garbage.

		If we don't apply, then we need to send this patch
		to anybody who has an IO-APIC mode interrupt issue
		in ACPI mode.

	1434: 1-line panic fix
		BIOS with correct ACPI table check-sums but garbled
		data can cause panic immediately after loading with
		no kernel output unless this is fixed.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.0-test9/acpi-20031002-2.6.0-test9.diff.gz

This will update the following files:

 Documentation/kernel-parameters.txt |    5 ++
 arch/i386/kernel/acpi/boot.c        |   53 ++++++++++++++++++++----
 arch/i386/kernel/dmi_scan.c         |    1 
 arch/i386/kernel/io_apic.c          |   10 +---
 arch/i386/kernel/mpparse.c          |    4 +
 arch/x86_64/kernel/acpi/boot.c      |   53 ++++++++++++++++++++----
 arch/x86_64/kernel/io_apic.c        |    8 +--
 arch/x86_64/kernel/mpparse.c        |    2 
 drivers/acpi/bus.c                  |    4 -
 9 files changed, 112 insertions(+), 28 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (03/11/18 1.1453)
   [ACPI] "acpi_pic_sci=edge" in case platform requires Edge Triggered
SCI
   http://bugzilla.kernel.org/show_bug.cgi?id=1390

<len.brown@intel.com> (03/11/18 1.1452)
   [ACPI] print_IO_APIC() only after it is programmed
   http://bugzilla.kernel.org/show_bug.cgi?id=1177

<len.brown@intel.com> (03/11/07 1.1414.1.7)
   [ACPI] In ACPI mode, delay print_IO_APIC() to make its output valid.
   http://bugzilla.kernel.org/show_bug.cgi?id=1177

<len.brown@intel.com> (03/11/07 1.1414.1.6)
   [ACPI] If ACPI is disabled by DMI BIOS date, then
   turn it off completely, including table parsing for HT.
   This avoids a crash due to ancient garbled tables.
   acpi=force is available to over-ride this default.
   http://bugzilla.kernel.org/show_bug.cgi?id=1434




