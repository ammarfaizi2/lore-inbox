Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUHWTAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUHWTAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267323AbUHWS6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:58:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:13764 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267317AbUHWShI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:08 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286089386@kroah.com>
Date: Mon, 23 Aug 2004 11:34:49 -0700
Message-Id: <1093286089857@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.41, 2004/08/09 14:40:00-07:00, killekulla@rdrz.de

[PATCH] PCI: fix PCI access mode dependences in arch/i386/Kconfig again

While all ACPI stuff is deselected, and PCI access mode is set to "Any",
CONFIG_ACPI_BOOT is going to be set because of CONFIG_PCI_MMCONFIG.

If CONFIG_ACPI_BOOT is not allready set by other stuff, setting PCI access
mode to "Any" shouldn't set CONFIG_PCI_MMCONFIG.  Anyhow, setting PCI
access mode to "MMConfig" should select CONFIG_ACPI_BOOT.

Signed-off-by: Raphael Zimmerer <killekulla@rdrz.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2004-08-23 11:02:44 -07:00
+++ b/arch/i386/Kconfig	2004-08-23 11:02:44 -07:00
@@ -1105,7 +1105,7 @@
 
 config PCI_MMCONFIG
 	bool
-	depends on PCI && (PCI_GOMMCONFIG || (PCI_GOANY && ACPI_BOOT))
+	depends on PCI && (PCI_GOMMCONFIG || (PCI_GOANY && ACPI))
 	select ACPI_BOOT
 	default y
 

