Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUDHCSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 22:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUDHCSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 22:18:24 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:39349 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261440AbUDHCSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 22:18:11 -0400
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Ia64 Linux <linux-ia64@vger.kernel.org>
Date: Thu, 8 Apr 2004 12:18:09 +1000
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [patch] trivial acpi/Kconfig
Message-ID: <20040408021809.GB8140@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ia64 when NUMA and SMP are selected, smpboot.c
expects ACPI_NUMA to be configured also or the
build fails due to:
http://linux.bkbits.net:8080/linux-2.5/diffs/arch/ia64/kernel/smpboot.c@1.20?nav=index.html|src/|src/arch|src/arch/ia64|src/arch/ia64/kernel|hist/arch/ia64/kernel/smpboot.c

I am not sure why our autobuild has suddenly started
to fail
(http://www.gelato.unsw.edu.au/kerncomp/)
though it is due to ACPI_NUMA not being set.
The attached patch should help when
configuring NUMA and SMP ia64 machines and
was generated against 2.6.5-bk 


Darren

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1783  -> 1.1784 
#	drivers/acpi/Kconfig	1.31    -> 1.32   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/04/08	dsw@quasar.(none)	1.1784
# Update Kconfig to default ACPI_NUMA to y
# if NUMA and SMP are selected 
# --------------------------------------------
#
diff -Nru a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig	Thu Apr  8 11:03:14 2004
+++ b/drivers/acpi/Kconfig	Thu Apr  8 11:03:14 2004
@@ -144,7 +144,7 @@
 	depends on ACPI_INTERPRETER
 	depends on NUMA
 	depends on IA64
-	default y if IA64_GENERIC || IA64_SGI_SN2
+	default y if IA64_GENERIC || IA64_SGI_SN2 || SMP
 
 config ACPI_ASUS
         tristate "ASUS/Medion Laptop Extras"



--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
