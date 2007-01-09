Return-Path: <linux-kernel-owner+w=401wt.eu-S932283AbXAIR2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbXAIR2z (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbXAIR2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:28:55 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:38406 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932242AbXAIR2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:28:53 -0500
X-Sasl-enc: n4MZOcKC+ciHIJlN/DDKPl2a9C+dm/XDVoxfODqHeZzQ 1168363515
Date: Tue, 9 Jan 2007 15:28:45 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Adrian Bunk <bunk@stusta.de>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6.20-rc4 regression] ibm-acpi: bay support disabled
Message-ID: <20070109172845.GA3528@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new one for you, it exists since 2.6.20-rc2.

Subject      : ThinkPad removable bay support disabled unconditionally
References   : http://marc.theaimsgroup.com/?l=linux-acpi&m=116750681901208&w=2
Caused-By    : Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Handled-By   : Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Status       : patch attached

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

ACPI: ibm-acpi: fix Kconfig entries for ibm-acpi bay and dock

Support for ACPI_BAY has not been merged in mainline yet.  Usage of
"depends on FOO=n" fails if FOO is undefined, thus ibm-acpi support
for bay was being made non-available in a kernel that has no other
sort of bay support.

Fix it to use "depends on ! FOO" instead, that does the right thing
when FOO is undefined.  Fix ACPI_IBM_DOCK accordingly as well while
at it, and also improve the help text.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/acpi/Kconfig |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1639998..34cc8d5 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -215,26 +215,29 @@ config ACPI_IBM
 config ACPI_IBM_DOCK
 	bool "Legacy Docking Station Support"
 	depends on ACPI_IBM
-	depends on ACPI_DOCK=n
-	default n
+	depends on ! ACPI_DOCK
+	default y
 	---help---
 	  Allows the ibm_acpi driver to handle docking station events.
 	  This support is obsoleted by CONFIG_HOTPLUG_PCI_ACPI.  It will
 	  allow locking and removing the laptop from the docking station,
 	  but will not properly connect PCI devices.
 
-	  If you are not sure, say N here.
+	  If you are not sure, select ACPI_DOCK instead.
 
 config ACPI_IBM_BAY
 	bool "Legacy Removable Bay Support"
 	depends on ACPI_IBM
-	depends on ACPI_BAY=n
-	default n
+	depends on ! ACPI_BAY
+	default y
 	---help---
 	  Allows the ibm_acpi driver to handle removable bays.
-	  This support is obsoleted by CONFIG_ACPI_BAY.
+	  This support is obsoleted by CONFIG_ACPI_BAY.  It will allow
+	  enabling and disabling devices in the removable bays, but it
+	  will not properly add or remove the devices from the kernel,
+	  which must be done manually by userspace scripts.
 
-	  If you are not sure, say N here.
+	  If you are not sure, select ACPI_BAY instead if it is available.
 
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
-- 
1.4.4.3

