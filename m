Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262629AbSJBVtT>; Wed, 2 Oct 2002 17:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262628AbSJBVtS>; Wed, 2 Oct 2002 17:49:18 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:29437 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262620AbSJBVtP>; Wed, 2 Oct 2002 17:49:15 -0400
Subject: PATCH: move tulip into ethernet 10,100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@mandrakesoft.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 23:02:15 +0100
Message-Id: <1033596135.25475.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/net/Config.in linux.2.5.40-ac1/drivers/net/Config.in
--- linux.2.5.40/drivers/net/Config.in	2002-10-02 21:33:55.000000000 +0100
+++ linux.2.5.40-ac1/drivers/net/Config.in	2002-10-02 22:17:39.000000000 +0100
@@ -108,6 +108,9 @@
       dep_tristate '    NI5210 support' CONFIG_NI52 $CONFIG_ISA
       dep_tristate '    NI6510 support' CONFIG_NI65 $CONFIG_ISA
    fi
+   if [ "$CONFIG_PCI" = "y" -o "$CONFIG_EISA" = "y" -o "$CONFIG_CARDBUS" != "n" ]; then
+      source drivers/net/tulip/Config.in
+   fi
    if [ "$CONFIG_ISA" = "y" -o "$CONFIG_MCA" = "y" ]; then
          dep_tristate '  AT1700/1720 support (EXPERIMENTAL)' CONFIG_AT1700 $CONFIG_EXPERIMENTAL
    fi
@@ -320,9 +326,6 @@
 
 source drivers/net/wan/Config.in
 
-if [ "$CONFIG_PCI" = "y" -o "$CONFIG_EISA" = "y" -o "$CONFIG_CARDBUS" != "n" ]; then
-   source drivers/net/tulip/Config.in
-fi
 if [ "$CONFIG_HOTPLUG" = "y" -a "$CONFIG_PCMCIA" != "n" ]; then
    source drivers/net/pcmcia/Config.in
 fi


