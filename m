Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312634AbSDXV6k>; Wed, 24 Apr 2002 17:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312638AbSDXV6j>; Wed, 24 Apr 2002 17:58:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:45807 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S312634AbSDXV6j>; Wed, 24 Apr 2002 17:58:39 -0400
Date: Thu, 25 Apr 2002 00:02:43 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@tethys.fachschaften.tu-muenchen.de
To: linux.nics@intel.com, <akpm@zip.com.au>, <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch] fix e100 compile error in kernel 2.5.10
Message-ID: <Pine.NEB.4.44.0204242355120.293-100000@tethys.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when trying to compile the driver for Intel's E100 statically into kernel
2.5.10 the final linking fails with the following error:

<--  snip  -->

...
        net/network.o \
        --end-group \
        -o vmlinux
drivers/net/net.o: In function `e100_diag_config_loopback':
drivers/net/net.o(.text+0x5063): undefined reference to `e100_phy_reset'
make: *** [vmlinux] Error 1

<--  snip  -->

The following patch should fix it (e100_diag_config_loopback is not
__devexit but it calls e100_phy_reset that was __devexit).

--- drivers/net/e100/e100_phy.c.old	Wed Apr 24 23:45:52 2002
+++ drivers/net/e100/e100_phy.c	Wed Apr 24 23:46:08 2002
@@ -873,7 +873,7 @@
 	e100_set_fc(bdp);
 }

-void __devexit
+void
 e100_phy_reset(struct e100_private *bdp)
 {
 	u16 ctrl_reg;

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

