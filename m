Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTEZTwm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 15:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTEZTwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 15:52:41 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:53220 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262179AbTEZTwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 15:52:40 -0400
Date: Mon, 26 May 2003 16:43:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: xconfig fix for rc4
Message-ID: <Pine.LNX.4.55L.0305261643140.21581@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not sure if this fix is correct. xconfig now works so I'm shipping it.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1225  -> 1.1226
#	drivers/ide/Config.in	1.30    -> 1.31
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/26	marcelo@freak.distro.conectiva	1.1226
#   Really fix xconfig breakage
# --------------------------------------------
#
diff -Nru a/drivers/ide/Config.in b/drivers/ide/Config.in
--- a/drivers/ide/Config.in	Mon May 26 16:43:12 2003
+++ b/drivers/ide/Config.in	Mon May 26 16:43:12 2003
@@ -66,7 +66,9 @@
 	    dep_bool     '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX_OLD $CONFI_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    PROMISE PDC202{68|69|70|71|75|76|77} support' CONFIG_BLK_DEV_PDC202XX_NEW $CONFIG_BLK_DEV_IDEDMA_PCI
 		# FIXME - probably wants to be one for old and for new
-	    dep_bool     '    Special FastTrak Feature' CONFIG_PDC202XX_FORCE
+if [ "$CONFIG_BLK_DEV_PDC202XX_OLD" = "y" -o "$CONFIG_BLK_DEV_PDC202XX_OLD" = "m" -o "$CONFIG_BLK_DEV_PDC202XX_NEW" = "y" -o "$CONFIG_BLK_DEV_PDC202XX_NEW" = "m" ]; then
+	    bool     '    Special FastTrak Feature' CONFIG_PDC202XX_FORCE
+fi
 	    dep_tristate '    RZ1000 chipset bugfix/support' CONFIG_BLK_DEV_RZ1000 $CONFIG_X86
 	    dep_tristate '    SCx200 chipset support' CONFIG_BLK_DEV_SC1200 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    ServerWorks OSB4/CSB5/CSB6 chipsets support' CONFIG_BLK_DEV_SVWKS $CONFIG_BLK_DEV_IDEDMA_PCI
