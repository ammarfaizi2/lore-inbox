Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbULHDC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbULHDC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 22:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbULHDC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 22:02:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57096 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262021AbULHDCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 22:02:43 -0500
Date: Wed, 8 Dec 2004 04:02:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, zaitcev@redhat.com
Cc: linux-usb-devel@lists.sourceforge.net
Subject: [2.4 patch] USB_ETH{,_RNDIS} EXPERIMENTAL dependencies
Message-ID: <20041208030238.GO5496@stusta.de>
References: <20041205165908.GA25139@thune.sonic.net> <20041208025248.GN5496@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208025248.GN5496@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Castle <dalgoda@ix.netcom.com> noted that USB_ETH and USB_ETH_RNDIS 
in 2.4 are marked as "(EXPERIMENTAL)", but don't depend on EXPERIMENTAL.


The patch below removes the "(EXPERIMENTAL)" string from USB_ETH and 
lets USB_ETH_RNDIS depend on EXPERIMENTAL.

This is similar to the dependencies 2.6 .


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.4.29-pre1-full/drivers/usb/gadget/Config.in.old	2004-12-08 03:55:32.000000000 +0100
+++ linux-2.4.29-pre1-full/drivers/usb/gadget/Config.in	2004-12-08 03:56:53.000000000 +0100
@@ -52,9 +52,9 @@
   comment 'USB Gadget Drivers'
 
   dep_tristate '  Gadget Zero (DEVELOPMENT)' CONFIG_USB_ZERO $CONFIG_USB_GADGET_CONTROLLER
-  dep_tristate '  Ethernet Gadget (EXPERIMENTAL)' CONFIG_USB_ETH $CONFIG_USB_GADGET_CONTROLLER $CONFIG_NET
+  dep_tristate '  Ethernet Gadget' CONFIG_USB_ETH $CONFIG_USB_GADGET_CONTROLLER $CONFIG_NET
   if [ "$CONFIG_USB_ETH" = "y" -o "$CONFIG_USB_ETH" = "m" ] ; then
-    bool       '    RNDIS support (EXPERIMENTAL)' CONFIG_USB_ETH_RNDIS
+    dep_bool       '    RNDIS support (EXPERIMENTAL)' CONFIG_USB_ETH_RNDIS $CONFIG_EXPERIMENTAL
   fi
   dep_tristate '  File-backed Storage Gadget (DEVELOPMENT)' CONFIG_USB_FILE_STORAGE $CONFIG_USB_GADGET_CONTROLLER
   dep_mbool '    File-backed Storage Gadget test mode' CONFIG_USB_FILE_STORAGE_TEST $CONFIG_USB_FILE_STORAGE
