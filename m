Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVCaW0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVCaW0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVCaW0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:26:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63759 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262041AbVCaWZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:25:51 -0500
Date: Fri, 1 Apr 2005 00:25:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Randolph Chung <tausq@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] let SOUND_AD1889 depend on PCI
Message-ID: <20050331222547.GL3185@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling SOUND_AD1889 with PCI=n results in the following compile 
error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
sound/built-in.o(.text+0x24f0c): In function `ad1889_remove':
: undefined reference to `pci_release_region'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


This patch adds the missing dependency on PCI.

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.12-rc1-mm4-full/sound/oss/Kconfig.old	2005-04-01 00:23:11.000000000 +0200
+++ linux-2.6.12-rc1-mm4-full/sound/oss/Kconfig	2005-04-01 00:23:39.000000000 +0200
@@ -556,7 +556,7 @@
 
 config SOUND_AD1889
 	tristate "AD1889 based cards (AD1819 codec) (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && SOUND_OSS
+	depends on EXPERIMENTAL && SOUND_OSS && PCI
 	help
 	  Say M here if you have a sound card based on the Analog Devices
 	  AD1889 chip.

