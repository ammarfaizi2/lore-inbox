Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbULAUKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbULAUKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 15:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbULAUKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 15:10:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:51649 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261427AbULAUKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 15:10:30 -0500
Date: Wed, 1 Dec 2004 11:57:58 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: pazke@donpac.ru
Subject: [PATCH] VISWS: prevent APM
Message-Id: <20041201115758.294585c3.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend)


Prevent X86_VISWS config from building APM support.
APM isn't supported and it won't build if attempted.
Also disable P4THERMAL for VISWS.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 arch/i386/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./arch/i386/Kconfig~visws_noapm ./arch/i386/Kconfig
--- ./arch/i386/Kconfig~visws_noapm	2004-10-11 10:54:31.019559744 -0700
+++ ./arch/i386/Kconfig	2004-10-14 09:52:24.131743344 -0700
@@ -584,7 +584,7 @@ config X86_MCE_NONFATAL
 
 config X86_MCE_P4THERMAL
 	bool "check for P4 thermal throttling interrupt."
-	depends on X86_MCE && (X86_UP_APIC || SMP)
+	depends on X86_MCE && (X86_UP_APIC || SMP) && !X86_VISWS
 	help
 	  Enabling this feature will cause a message to be printed when the P4
 	  enters thermal throttling.
@@ -879,7 +879,7 @@ source kernel/power/Kconfig
 source "drivers/acpi/Kconfig"
 
 menu "APM (Advanced Power Management) BIOS Support"
-depends on PM
+depends on PM && !X86_VISWS
 
 config APM
 	tristate "APM (Advanced Power Management) BIOS support"

---
