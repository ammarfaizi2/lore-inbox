Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbTDEWyh (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 17:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTDEWyg (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 17:54:36 -0500
Received: from jalon.able.es ([212.97.163.2]:13280 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id S262708AbTDEWye (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 17:54:34 -0500
Date: Sun, 6 Apr 2003 01:06:00 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] config/dep bugs
Message-ID: <20030405230600.GC12864@werewolf.able.es>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva> <20030405224233.GA12746@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030405224233.GA12746@werewolf.able.es>; from jamagallon@able.es on Sun, Apr 06, 2003 at 00:42:33 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.06, J.A. Magallon wrote:
> 
> On 04.04, Marcelo Tosatti wrote:
> > 
> > So here goes -pre7. Hopefully the last -pre.
> > 

--- linux/drivers/net/Config.in.orig	2003-03-13 23:48:55.000000000 +0100
+++ linux/drivers/net/Config.in	2003-03-13 23:49:33.000000000 +0100
@@ -185,7 +185,7 @@
       dep_tristate '    Davicom DM910x/DM980x support' CONFIG_DM9102 $CONFIG_PCI
       dep_tristate '    EtherExpressPro/100 support (eepro100, original Becker driver)' CONFIG_EEPRO100 $CONFIG_PCI
       if [ "$CONFIG_VISWS" = "y" ]; then
-         define_mbool CONFIG_EEPRO100_PIO y
+         define_bool CONFIG_EEPRO100_PIO y
       else
          dep_mbool '      Use PIO instead of MMIO' CONFIG_EEPRO100_PIO $CONFIG_EEPRO100
       fi  
--- linux/drivers/ide/Config.in.orig	2003-04-05 02:23:30.000000000 +0200
+++ linux/drivers/ide/Config.in	2003-04-05 02:23:43.000000000 +0200
@@ -43,7 +43,7 @@
 	    define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_bool '      ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 #	    dep_bool '      Good-Bad DMA Model-Firmware (WIP)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP
-            dep_tristate '    Pacific Digital ADMA-100 basic support' CONFIG_BLK_DEV_ADMA100
+            dep_tristate '    Pacific Digital ADMA-100 basic support' CONFIG_BLK_DEV_ADMA100 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    ALI M15x3 chipset support' CONFIG_BLK_DEV_ALI15X3 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool    '      ALI M15x3 WDC support (DANGEROUS)' CONFIG_WDC_ALI15X3 $CONFIG_BLK_DEV_ALI15X3



-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Bamboo) for i586
Linux 2.4.21-pre7-jam1 (gcc 3.2.2 (Mandrake Linux 9.2 3.2.2-5mdk))
