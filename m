Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbTE0BYp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTE0BYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:24:44 -0400
Received: from mail.gmx.net ([213.165.65.60]:43950 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262486AbTE0BYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:24:42 -0400
Message-ID: <3ED2C16D.6090904@gmx.net>
Date: Tue, 27 May 2003 03:37:49 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE config correctness (was: Linux 2.4.21-rc4)
References: <Pine.LNX.4.55L.0305261734320.21581@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0305261734320.21581@freak.distro.conectiva>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070600010802030708070504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070600010802030708070504
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> Hi,
> 
> Here goes -rc4, hopefully fixing all problems now.
> 
> rc5 will only be released in case of REALLY bad problems.

Not really a bad problem, but CONFIG_PDC202XX_BURST should be selectable
even if CONFIG_BLK_DEV_PDC202XX_OLD=m
You decide if this goes into 2.4.21. I do not feel strongly about it.

>   o Cset exclude: c-d.hailfinger.kernel.2003@gmx.net|ChangeSet|20030526190224|33683
>   o Really fix xconfig breakage

My fix for the xconfig breakage also included this IDE config fix. When
you excluded the cset, it got lost.

Attached is the diff on top of your tree.


Regards,
Carl-Daniel

--------------070600010802030708070504
Content-Type: text/plain;
 name="ide-special-udma-feature.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-special-udma-feature.diff"

===== drivers/ide/Config.in 1.31 vs edited =====
--- 1.31/drivers/ide/Config.in	Mon May 26 21:38:00 2003
+++ edited/drivers/ide/Config.in	Mon May 26 23:20:49 2003
@@ -63,7 +63,7 @@
 	    dep_tristate '    NS87415 chipset support' CONFIG_BLK_DEV_NS87415 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL
 	    dep_tristate '    PROMISE PDC202{46|62|65|67} support' CONFIG_BLK_DEV_PDC202XX_OLD $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_bool     '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX_OLD $CONFI_BLK_DEV_IDEDMA_PCI
+	    dep_mbool    '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX_OLD $CONFI_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    PROMISE PDC202{68|69|70|71|75|76|77} support' CONFIG_BLK_DEV_PDC202XX_NEW $CONFIG_BLK_DEV_IDEDMA_PCI
 		# FIXME - probably wants to be one for old and for new
 if [ "$CONFIG_BLK_DEV_PDC202XX_OLD" = "y" -o "$CONFIG_BLK_DEV_PDC202XX_OLD" = "m" -o "$CONFIG_BLK_DEV_PDC202XX_NEW" = "y" -o "$CONFIG_BLK_DEV_PDC202XX_NEW" = "m" ]; then

--------------070600010802030708070504--

