Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267232AbTAAORM>; Wed, 1 Jan 2003 09:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267235AbTAAORM>; Wed, 1 Jan 2003 09:17:12 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:2239 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267232AbTAAORL>; Wed, 1 Jan 2003 09:17:11 -0500
Date: Wed, 1 Jan 2003 15:25:35 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] only show the tokenring submenu if tokenring is selected
Message-ID: <20030101142535.GJ14184@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial: This is a follow-up to your "Gigabit Ethernet submenu" precedent.

Only show the tokenring submenu if the tokenring entry is selected.

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/drivers/net/tokenring/Kconfig b/drivers/net/tokenring/Kconfig
--- a/drivers/net/tokenring/Kconfig	2002-12-08 20:06:34.000000000 +0100
+++ b/drivers/net/tokenring/Kconfig	2003-01-01 15:23:10.000000000 +0100
@@ -2,13 +2,10 @@
 # Token Ring driver configuration
 #
 
-menu "Token Ring devices (depends on LLC=y)"
-	depends on NETDEVICES
-
 # So far, we only have PCI, ISA, and MCA token ring devices
 config TR
-	bool "Token Ring driver support"
-	depends on (PCI || ISA || MCA) && LLC=y
+	depends on (PCI || ISA || MCA) && NETDEVICES && LLC=y
+	bool "Token Ring driver support (depends on LLC=y)"
 	help
 	  Token Ring is IBM's way of communication on a local network; the
 	  rest of the world uses Ethernet. To participate on a Token Ring
@@ -19,6 +16,9 @@
 	  from <http://www.linuxdoc.org/docs.html#howto>. Most people can
 	  say N here.
 
+menu "Token Ring devices"
+	depends on TR
+
 config IBMTR
 	tristate "IBM Tropic chipset based adapter support"
 	depends on TR && (ISA || MCA)
