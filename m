Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVA3AWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVA3AWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 19:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVA3AWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 19:22:04 -0500
Received: from alg138.algor.co.uk ([62.254.210.138]:63203 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261618AbVA3AVr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 19:21:47 -0500
Date: Sun, 30 Jan 2005 00:15:55 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH] Fix SERIAL_TXX9 dependencies
Message-ID: <20050130001555.GA3648@linux-mips.org>
References: <20050129131134.75dacb41.akpm@osdl.org> <20050129231255.GA3185@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129231255.GA3185@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ask for SERIAL_TXX9 only on those devices that actually have one.

 arch/mips/Kconfig      |    2 ++
 drivers/serial/Kconfig |    6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6.11-rc2/drivers/serial/Kconfig
===================================================================
--- linux-2.6.11-rc2.orig/drivers/serial/Kconfig	2005-01-29 03:18:00.000000000 +0100
+++ linux-2.6.11-rc2/drivers/serial/Kconfig	2005-01-30 01:10:46.426853785 +0100
@@ -794,8 +794,12 @@
 
 config SERIAL_TXX9
 	bool "TMPTX39XX/49XX SIO support"
-	depends on MIPS || PCI
+	depends HAS_TXX9_SERIAL
 	select SERIAL_CORE
+	default y
+
+config HAS_TXX9_SERIAL
+	bool
 
 config SERIAL_TXX9_CONSOLE
 	bool "TMPTX39XX/49XX SIO Console support"
Index: linux-2.6.11-rc2/arch/mips/Kconfig
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/Kconfig	2005-01-30 00:45:48.808734334 +0100
+++ linux-2.6.11-rc2/arch/mips/Kconfig	2005-01-30 01:00:55.533811631 +0100
@@ -848,6 +848,7 @@
 	bool "Support for Toshiba TBTX49[23]7 board"
 	depends on MIPS32
 	select DMA_NONCOHERENT
+	select HAS_TXX9_SERIAL
 	select HW_HAS_PCI
 	select I8259
 	select ISA
@@ -970,6 +971,7 @@
 config MIPS_TX3927
 	bool
 	depends on TOSHIBA_JMR3927
+	select HAS_TXX9_SERIAL
 	default y
 
 config PCI_MARVELL
