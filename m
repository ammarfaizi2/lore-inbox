Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTE0WWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTE0WWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:22:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:17254 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264330AbTE0WWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:22:47 -0400
Message-ID: <3ED3E84B.9020505@gmx.net>
Date: Wed, 28 May 2003 00:35:55 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE config correctness (was: Linux 2.4.21-rc5)
References: <Pine.LNX.4.55L.0305271640320.9487@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0305271640320.9487@freak.distro.conectiva>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020106090401020604080109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020106090401020604080109
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> Summary of changes from v2.4.21-rc4 to v2.4.21-rc5
> ============================================
> 
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
>   o 1: (trivial) Fix the formatting of your ide hack

Darn. Everytime I send a patch for drivers/ide/Config.in, someone beats
me to it and my patch causes a conflict. This time with one more bugfix
for the same line.

Fixes:
CONFIG_PDC202XX_BURST was not selectable if CONFIG_BLK_DEV_PDC202XX_OLD=m

CONFIG_PDC202XX_BURST depended on CONFI_BLK_DEV_IDEDMA_PCI, which is a typo.

Please apply,

Carl-Daniel

--------------020106090401020604080109
Content-Type: text/plain;
 name="ide-special-udma-feature2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-special-udma-feature2.diff"

===== drivers/ide/Config.in 1.32 vs edited =====
--- 1.32/drivers/ide/Config.in	Tue May 27 15:24:35 2003
+++ edited/drivers/ide/Config.in	Wed May 28 00:28:21 2003
@@ -63,7 +63,7 @@
 	    dep_tristate '    NS87415 chipset support' CONFIG_BLK_DEV_NS87415 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL
 	    dep_tristate '    PROMISE PDC202{46|62|65|67} support' CONFIG_BLK_DEV_PDC202XX_OLD $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_bool     '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX_OLD $CONFI_BLK_DEV_IDEDMA_PCI
+	    dep_mbool    '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX_OLD $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    PROMISE PDC202{68|69|70|71|75|76|77} support' CONFIG_BLK_DEV_PDC202XX_NEW $CONFIG_BLK_DEV_IDEDMA_PCI
 	    if [ "$CONFIG_BLK_DEV_PDC202XX_OLD" = "y" -o "$CONFIG_BLK_DEV_PDC202XX_OLD" = "m" -o "$CONFIG_BLK_DEV_PDC202XX_NEW" = "y" -o "$CONFIG_BLK_DEV_PDC202XX_NEW" = "m" ]; then
 	        bool     '    Special FastTrak Feature' CONFIG_PDC202XX_FORCE

--------------020106090401020604080109--

