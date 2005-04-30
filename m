Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVD3Lwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVD3Lwx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 07:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVD3Lwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 07:52:53 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7690 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261201AbVD3Lwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 07:52:51 -0400
Date: Sat, 30 Apr 2005 13:52:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, venza@brownhat.org, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [-mm patch] SIS900 must select MII
Message-ID: <20050430115249.GA3654@stusta.de>
References: <20050429231653.32d2f091.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429231653.32d2f091.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error caused by bk-netdev:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x98528): In function `sis900_get_settings':
: undefined reference to `mii_ethtool_gset'
drivers/built-in.o(.text+0x98538): In function `sis900_set_settings':
: undefined reference to `mii_ethtool_sset'
drivers/built-in.o(.text+0x98517): In function `sis900_get_link':
: undefined reference to `mii_link_ok'
drivers/built-in.o(.text+0x98547): In function `sis900_nway_reset':
: undefined reference to `mii_nway_restart'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>


--- linux-2.6.12-rc3-mm1/drivers/net/Kconfig.old	2005-04-30 13:47:25.000000000 +0200
+++ linux-2.6.12-rc3-mm1/drivers/net/Kconfig	2005-04-30 13:47:48.000000000 +0200
@@ -1543,8 +1543,9 @@
 config SIS900
 	tristate "SiS 900/7016 PCI Fast Ethernet Adapter support"
 	depends on NET_PCI && PCI
 	select CRC32
+	select MII
 	---help---
 	  This is a driver for the Fast Ethernet PCI network cards based on
 	  the SiS 900 and SiS 7016 chips. The SiS 900 core is also embedded in
 	  SiS 630 and SiS 540 chipsets.  If you have one of those, say Y and

