Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932824AbWAFSpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbWAFSpW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932854AbWAFSpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:45:22 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:37322 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S932824AbWAFSpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:45:21 -0500
Date: Fri, 06 Jan 2006 19:45:09 +0100
From: Jan Spitalnik <lkml@spitalnik.net>
Subject: [PATCH] Disable swsusp on CONFIG_HIGHMEM64
To: linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>
Message-id: <200601061945.09466.lkml@spitalnik.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_IVUiE2uGvXaksXBa4MDF6w)"
User-Agent: KMail/1.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_IVUiE2uGvXaksXBa4MDF6w)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

Hello,

suspending to disk is not supported on CONFIG_HIGHMEM64G setups 
(http://suspend2.net/features). Also suspend to ram doesn't work. This patch 
fixes Kconfig to disallow such combination. I'm not 100% sure about the 
ACPI_SLEEP part, as it might be disabling some working setup - but i think 
that s2r and s2d are the only acpi sleeps allowed, no?

Bye,
	spity

PS: I didn't know that this is not supported so I had some nice oops after 
resume (from ram) and s2d didn't resume at all :-)

-- 
Jan Spitalnik
jan@spitalnik.net

--Boundary_(ID_IVUiE2uGvXaksXBa4MDF6w)
Content-type: text/x-diff; charset=us-ascii; name=swsusp-vs-higmem64.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=swsusp-vs-higmem64.patch

diff --exclude=CVS --exclude=.svn -up --new-file --recursive linux-2.6.old/drivers/acpi/Kconfig linux-2.6/drivers/acpi/Kconfig
--- linux-2.6.old/drivers/acpi/Kconfig	2006-01-06 18:58:10.000000000 +0100
+++ linux-2.6/drivers/acpi/Kconfig	2006-01-06 19:07:34.000000000 +0100
@@ -46,7 +46,7 @@ if ACPI
 
 config ACPI_SLEEP
 	bool "Sleep States"
-	depends on X86 && (!SMP || SUSPEND_SMP)
+	depends on X86 && (!SMP || SUSPEND_SMP) && !HIGHMEM64G
 	depends on PM
 	default y
 	---help---
diff --exclude=CVS --exclude=.svn -up --new-file --recursive linux-2.6.old/kernel/power/Kconfig linux-2.6/kernel/power/Kconfig
--- linux-2.6.old/kernel/power/Kconfig	2006-01-06 18:58:28.000000000 +0100
+++ linux-2.6/kernel/power/Kconfig	2006-01-06 19:07:43.000000000 +0100
@@ -38,7 +38,7 @@ config PM_DEBUG
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FVR || PPC32) && !SMP)
+	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP) && !HIGHMEM64G) || ((FVR || PPC32) && !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.

--Boundary_(ID_IVUiE2uGvXaksXBa4MDF6w)--
