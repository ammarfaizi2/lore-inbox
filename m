Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWGJSb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWGJSb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422749AbWGJSb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:31:57 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27657 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422651AbWGJSb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:31:56 -0400
Date: Mon, 10 Jul 2006 20:31:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: marcel@holtmann.org, maxk@qualcomm.com
Cc: bluez-devel@lists.sourceforge.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux390@de.ibm.com
Subject: [2.6 patch] let BT_HIDP depend on INPUT
Message-ID: <20060710183154.GD13938@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch let's BT_HIDP depend on instead of select INPUT.

This fixes the following warning during an s390 build:

<--  snip  -->

...
net/bluetooth/hidp/Kconfig:4:warning: 'select' used by config symbol 'BT_HIDP' refer to undefined symbol 'INPUT'
...

<--  snip  -->

A dependency on INPUT also implies !S390 (and therefore makes the 
explicit dependency obsolete) since INPUT is not available on s390.

The practical difference should be nearly zero, since INPUT is always 
set to y unless EMBEDDED=y (or S390=y).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc1-mm1-full/net/bluetooth/hidp/Kconfig.old	2006-07-10 16:51:59.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/net/bluetooth/hidp/Kconfig	2006-07-10 16:52:52.000000000 +0200
@@ -1,7 +1,6 @@
 config BT_HIDP
 	tristate "HIDP protocol support"
-	depends on BT && BT_L2CAP && (BROKEN || !S390)
-	select INPUT
+	depends on INPUT && BT && BT_L2CAP
 	help
 	  HIDP (Human Interface Device Protocol) is a transport layer
 	  for HID reports.  HIDP is required for the Bluetooth Human

