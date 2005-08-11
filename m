Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVHKUYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVHKUYt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVHKUYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:24:48 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:4773 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932432AbVHKUYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:24:47 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Thu, 11 Aug 2005 14:24:43 -0600
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-ia64@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508111424.43150.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
around in I/O port space.  Poking at things that don't exist causes MCAs
on HP ia64 systems.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-vga/drivers/ide/Kconfig
===================================================================
--- work-vga.orig/drivers/ide/Kconfig	2005-08-10 14:57:47.000000000 -0600
+++ work-vga/drivers/ide/Kconfig	2005-08-10 14:58:02.000000000 -0600
@@ -276,6 +276,7 @@
 
 config IDE_GENERIC
 	tristate "generic/default IDE chipset support"
+	depends on !IA64
 	default y
 	help
 	  If unsure, say Y.
