Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVCaWZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVCaWZY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVCaWZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:25:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62223 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262027AbVCaWX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:23:27 -0500
Date: Fri, 1 Apr 2005 00:23:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Scott_Kilau@digi.com,
       wendyx@us.ltcfwd.linux.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] let SERIAL_JSM depend on PCI
Message-ID: <20050331222325.GK3185@stusta.de>
References: <20050331022554.735a1118.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331022554.735a1118.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling SERIAL_JSM with PCI=n results in the following compile error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x132800): In function `jsm_remove_one':
: undefined reference to `pci_release_regions'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Since this driver is only for PCi boards, this patch adds a dependency 
on PCI.

Since I noticed that the Kconfig entry used whitespace instead of tabs, 
I corrected this, too.

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.12-rc1-mm4-full/drivers/serial/Kconfig.old	2005-04-01 00:16:07.000000000 +0200
+++ linux-2.6.12-rc1-mm4-full/drivers/serial/Kconfig	2005-04-01 00:19:15.000000000 +0200
@@ -828,18 +828,19 @@
 	  a console on a serial port, say Y.  Otherwise, say N.
 
 config SERIAL_JSM
-        tristate "Digi International NEO PCI Support"
-        select SERIAL_CORE
-        help
-          This is a driver for Digi International's Neo series
-          of cards which provide multiple serial ports. You would need
-          something like this to connect more than two modems to your Linux
-          box, for instance in order to become a dial-in server. This driver
-          supports PCI boards only.
-          If you have a card like this, say Y here and read the file
-          <file:Documentation/jsm.txt>.
+	tristate "Digi International NEO PCI Support"
+	depends on PCI
+	select SERIAL_CORE
+	help
+	  This is a driver for Digi International's Neo series
+	  of cards which provide multiple serial ports. You would need
+	  something like this to connect more than two modems to your Linux
+	  box, for instance in order to become a dial-in server. This driver
+	  supports PCI boards only.
+	  If you have a card like this, say Y here and read the file
+	  <file:Documentation/jsm.txt>.
 
-          To compile this driver as a module, choose M here: the
-          module will be called jsm.
+	  To compile this driver as a module, choose M here: the
+	  module will be called jsm.
 
 endmenu
