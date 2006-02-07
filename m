Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWBGWMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWBGWMA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWBGWL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:11:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10003 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030194AbWBGWL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:11:59 -0500
Date: Tue, 7 Feb 2006 23:11:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: tony.luck@intel.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] IA64_GENERIC shouldn't select other stuff
Message-ID: <20060207221157.GA3524@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IA64_GENERIC shouldn't select other stuff.

select'ing ACPI without select'ing PCI had broken ACPI in the past (the 
current workaround is that ACPI select's PCI).

Select'ing NUMA means that the illegal configuration NUMA=y, FLATMEM=y 
is possible.

The generic setting might be required in some places, but select'ing 
some options like NUMA while not select'ing some other similar 
important options like PCI doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm5-ia64/arch/ia64/Kconfig.old	2006-02-07 23:07:29.000000000 +0100
+++ linux-2.6.16-rc1-mm5-ia64/arch/ia64/Kconfig	2006-02-07 23:07:55.000000000 +0100
@@ -72,9 +72,6 @@
 
 config IA64_GENERIC
 	bool "generic"
-	select ACPI
-	select NUMA
-	select ACPI_NUMA
 	help
 	  This selects the system type of your hardware.  A "generic" kernel
 	  will run on any supported IA-64 system.  However, if you configure

