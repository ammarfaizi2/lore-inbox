Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265496AbRF1DQQ>; Wed, 27 Jun 2001 23:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265500AbRF1DQF>; Wed, 27 Jun 2001 23:16:05 -0400
Received: from mail.mesatop.com ([208.164.122.9]:3845 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S265496AbRF1DP7>;
	Wed, 27 Jun 2001 23:15:59 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.6-pre6 fix drivers/net/Config.in error
Date: Wed, 27 Jun 2001 21:09:03 -0600
X-Mailer: KMail [version 1.2]
Cc: torvalds@transmeta.com
MIME-Version: 1.0
Message-Id: <01062721090303.01154@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this error for 2.4.6-pre6 for make xconfig

drivers/net/Config.in: 145: can't handle dep_bool/dep_mbool/dep_tristate condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.6-pre6/scripts'
make: *** [xconfig] Error 2

This may be the proper fix.
Steven

--- linux/drivers/net/Config.in.original	Wed Jun 27 20:39:50 2001
+++ linux/drivers/net/Config.in	Wed Jun 27 20:41:28 2001
@@ -142,7 +142,7 @@
       tristate '  NE/2 (ne2000 MCA version) support' CONFIG_NE2_MCA
       tristate '  IBM LAN Adapter/A support' CONFIG_IBMLANA
    fi
-   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI
+   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI $CONFIG_PCI
    if [ "$CONFIG_NET_PCI" = "y" ]; then
       dep_tristate '    AMD PCnet32 PCI support' CONFIG_PCNET32 $CONFIG_PCI
       dep_tristate '    Adaptec Starfire support (EXPERIMENTAL)' CONFIG_ADAPTEC_STARFIRE $CONFIG_PCI $CONFIG_EXPERIMENTAL
