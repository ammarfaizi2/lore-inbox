Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264199AbTEWWJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 18:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264200AbTEWWJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 18:09:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:7050 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264199AbTEWWJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 18:09:55 -0400
Message-ID: <3ECE9F40.60101@gmx.net>
Date: Sat, 24 May 2003 00:22:56 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] [2.4.21-rc3] Fix make xconfig breakage
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090402090000000807070109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090402090000000807070109
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Marcelo,

drivers/ide/Config.in has a few bugs which prevent make xconfig from
running at all. The attached fix is ugly, but small and thus appropriate
for -rc4. It has been tested and works for me(TM).

I will send you a more invasive fix to do it right(TM) during 2.4.22-pre
timeframe. For now, please apply the minimal fix below.

Thanks
Carl-Daniel

--------------090402090000000807070109
Content-Type: text/plain;
 name="mimimal-ide-xconfig-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mimimal-ide-xconfig-fix.diff"

===== drivers/ide/Config.in 1.28 vs edited =====
--- 1.28/drivers/ide/Config.in	Fri May 23 10:51:27 2003
+++ edited/drivers/ide/Config.in	Sat May 24 00:09:24 2003
@@ -63,10 +63,12 @@
 	    dep_tristate '    NS87415 chipset support' CONFIG_BLK_DEV_NS87415 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL
 	    dep_tristate '    PROMISE PDC202{46|62|65|67} support' CONFIG_BLK_DEV_PDC202XX_OLD $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_bool     '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX_OLD $CONFI_BLK_DEV_IDEDMA_PCI
+	    dep_mbool    '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX_OLD $CONFI_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    PROMISE PDC202{68|69|70|71|75|76|77} support' CONFIG_BLK_DEV_PDC202XX_NEW $CONFIG_BLK_DEV_IDEDMA_PCI
+	    if [ "$CONFIG_BLK_DEV_PDC202XX_OLD" = "y" -o "$CONFIG_BLK_DEV_PDC202XX_OLD" = "m" -o "$CONFIG_BLK_DEV_PDC202XX_NEW" = "y" -o "$CONFIG_BLK_DEV_PDC202XX_NEW" = "m" ]; then
 		# FIXME - probably wants to be one for old and for new
-	    dep_bool     '    Special FastTrak Feature' CONFIG_PDC202XX_FORCE
+	       dep_mbool '    Special FastTrak Feature' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_IDEDMA_PCI
+	    fi
 	    dep_tristate '    RZ1000 chipset bugfix/support' CONFIG_BLK_DEV_RZ1000 $CONFIG_X86
 	    dep_tristate '    SCx200 chipset support' CONFIG_BLK_DEV_SC1200 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    ServerWorks OSB4/CSB5/CSB6 chipsets support' CONFIG_BLK_DEV_SVWKS $CONFIG_BLK_DEV_IDEDMA_PCI

--------------090402090000000807070109--

