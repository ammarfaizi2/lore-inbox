Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbTELOgD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 10:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTELOgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 10:36:03 -0400
Received: from mail.ccur.com ([208.248.32.212]:9737 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S262142AbTELOgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 10:36:02 -0400
Date: Mon, 12 May 2003 10:48:25 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] 2.4.21-rc1 fix to drivers/ide/Config.in
Message-ID: <20030512144824.GA31088@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
 On April 1 Marcello accepted a patch to ide/drivers/Config.in that breaks
'make xconfig'.  The error is on line 46, where a new dep_tristate
variable was defined without the conditional value that dep_tristate
requires.  Apparently 'make config', 'make oldconfig', etc are able to
handle this syntax error somehow but 'make xconfig' cannot.

The attached patch is my guess as to what the conditional should be.
Could you verify that it is correct and let Marcelo know?  Several such
patches have been floated by others to Marcelo in the past but none have
been accepted, possibly because he wants your blessing on changes to
your code made by others.

Thanks,
Joe

--- drivers/ide/Config.in.orig	2003-05-12 10:15:07.000000000 -0400
+++ drivers/ide/Config.in	2003-05-12 10:23:30.000000000 -0400
@@ -43,7 +43,7 @@
 	    define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_bool '      ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 #	    dep_bool '      Good-Bad DMA Model-Firmware (WIP)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP
-            dep_tristate '    Pacific Digital ADMA-100 basic support' CONFIG_BLK_DEV_ADMA100
+            dep_tristate '    Pacific Digital ADMA-100 basic support' CONFIG_BLK_DEV_ADMA100 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    ALI M15x3 chipset support' CONFIG_BLK_DEV_ALI15X3 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool    '      ALI M15x3 WDC support (DANGEROUS)' CONFIG_WDC_ALI15X3 $CONFIG_BLK_DEV_ALI15X3
