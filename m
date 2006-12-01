Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162142AbWLAWfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162142AbWLAWfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 17:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162140AbWLAWfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 17:35:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36877 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1162139AbWLAWfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 17:35:16 -0500
Date: Fri, 1 Dec 2006 23:35:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: tim@cyberelk.net
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove drivers/block/paride/jumbo
Message-ID: <20061201223521.GK11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's remove this pre-historic paride building script.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/block/paride/jumbo |   70 -------------------------------------
 1 file changed, 70 deletions(-)

--- linux-2.6.19-rc6-mm2/drivers/block/paride/jumbo	2006-09-20 05:42:06.000000000 +0200
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,70 +0,0 @@
-#!/bin/sh
-#
-# This script can be used to build "jumbo" modules that contain the
-# base PARIDE support, one protocol module and one high-level driver.
-#
-echo -n "High level driver [pcd] : "
-read X
-HLD=${X:-pcd}
-#
-echo -n "Protocol module [bpck] : "
-read X
-PROTO=${X:-bpck}
-#
-echo -n "Use MODVERSIONS [y] ? "
-read X
-UMODV=${X:-y}
-#
-echo -n "For SMP kernel [n] ? "
-read X
-USMP=${X:-n}
-#
-echo -n "Support PARPORT [n] ? "
-read X
-UPARP=${X:-n}
-#
-echo
-#
-case $USMP in
-	y* | Y* ) FSMP="-DCONFIG_SMP"
-		  ;;
-	*)	  FSMP=""
-		  ;;
-esac
-#
-MODI="-include ../../../include/linux/modversions.h"
-#
-case $UMODV in
-	y* | Y* ) FMODV="-DMODVERSIONS $MODI"
-		  ;;
-	*)	  FMODV=""
-		  ;;
-esac
-#
-case $UPARP in
-	y* | Y* ) FPARP="-DCONFIG_PARPORT"
-		  ;;
-	*)	  FPARP=""
-		  ;;
-esac
-#
-TARG=$HLD-$PROTO.o
-FPROTO=-DCONFIG_PARIDE_`echo "$PROTO" | tr [a-z] [A-Z]`
-FK="-D__KERNEL__ -I ../../../include"
-FLCH=-D_LINUX_CONFIG_H
-#
-echo cc $FK $FSMP $FLCH $FPARP $FPROTO $FMODV -Wall -O2 -o Jb.o -c paride.c
-cc $FK $FSMP $FLCH $FPARP $FPROTO $FMODV -Wall -O2 -o Jb.o -c paride.c
-#
-echo cc $FK $FSMP $FMODV -Wall -O2 -o Jp.o -c $PROTO.c
-cc $FK $FSMP $FMODV -Wall -O2 -o Jp.o -c $PROTO.c
-#
-echo cc $FK $FSMP $FMODV -DMODULE -DPARIDE_JUMBO -Wall -O2 -o Jd.o -c $HLD.c
-cc $FK $FSMP $FMODV -DMODULE -DPARIDE_JUMBO -Wall -O2 -o Jd.o -c $HLD.c
-#
-echo ld -r -o $TARG Jp.o Jb.o Jd.o
-ld -r -o $TARG Jp.o Jb.o Jd.o
-#
-#
-rm Jp.o Jb.o Jd.o
-#
