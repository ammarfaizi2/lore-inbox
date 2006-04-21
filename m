Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWDUEts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWDUEts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWDUEoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:39297 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932232AbWDUEoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:00 -0400
Date: Thu, 20 Apr 2006 21:38:12 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Artem B. Bityutskiy" <dedekind@yandex.ru>, dwmw2@infradead.org,
       Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 07/22] MTD_NAND_SHARPSL and MTD_NAND_NANDSIM should be tristates
Message-ID: <20060421043812.GH12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="mtd_nand_sharpsl-and-mtd_nand_nandsim-should-be-tristate-s.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MTD_NAND=m and MTD_NAND_SHARPSL=y or MTD_NAND_NANDSIM=y are illegal
combinations that mustn't be allowed.

This patch fixes this bug by making MTD_NAND_SHARPSL and MTD_NAND_NANDSIM
tristate's.

Additionally, it fixes some whitespace damage at these options.

This patch was already included in Linus' tree.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/mtd/nand/Kconfig |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- linux-2.6.16.9.orig/drivers/mtd/nand/Kconfig
+++ linux-2.6.16.9/drivers/mtd/nand/Kconfig
@@ -178,17 +178,16 @@ config MTD_NAND_DISKONCHIP_BBTWRITE
 	  Even if you leave this disabled, you can enable BBT writes at module
 	  load time (assuming you build diskonchip as a module) with the module
 	  parameter "inftl_bbt_write=1".
-	  
- config MTD_NAND_SHARPSL
- 	bool "Support for NAND Flash on Sharp SL Series (C7xx + others)"
- 	depends on MTD_NAND && ARCH_PXA
- 
- config MTD_NAND_NANDSIM
- 	bool "Support for NAND Flash Simulator"
- 	depends on MTD_NAND && MTD_PARTITIONS
 
+config MTD_NAND_SHARPSL
+	tristate "Support for NAND Flash on Sharp SL Series (C7xx + others)"
+	depends on MTD_NAND && ARCH_PXA
+
+config MTD_NAND_NANDSIM
+	tristate "Support for NAND Flash Simulator"
+	depends on MTD_NAND && MTD_PARTITIONS
 	help
 	  The simulator may simulate verious NAND flash chips for the
 	  MTD nand layer.
- 
+
 endmenu

--
