Return-Path: <linux-kernel-owner+w=401wt.eu-S1030191AbXAKB37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbXAKB37 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 20:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbXAKB3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 20:29:50 -0500
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:32975 "EHLO
	imf18aec.mail.bellsouth.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751269AbXAKB3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 20:29:46 -0500
X-Greylist: delayed 2991 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jan 2007 20:29:44 EST
Date: Wed, 10 Jan 2007 18:40:51 -0600
From: Jay Cliburn <jacliburn@bellsouth.net>
To: jeff@garzik.org
Cc: shemminger@osdl.org, csnook@redhat.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, atl1-devel@lists.sourceforge.net
Subject: [PATCH 1/4] atl1: Build files for Attansic L1 driver
Message-ID: <20070111004051.GB2624@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jay Cliburn <jacliburn@bellsouth.net>
From: Chris Snook <csnook@redhat.com>

This patch contains the build files for the Attansic L1 gigabit ethernet
adapter driver.

Signed-off-by: Jay Cliburn <jacliburn@bellsouth.net>
Signed-off-by: Chris Snook <csnook@redhat.com>
---

 Kconfig       |   11 +++++++++++
 Makefile      |    1 +
 atl1/Makefile |   30 ++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 8aa8dd0..92a5efe 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2348,6 +2348,17 @@ config QLA3XXX
 	  To compile this driver as a module, choose M here: the module
 	  will be called qla3xxx.
 
+config ATL1
+	tristate "Attansic(R) L1 Gigabit Ethernet support (EXPERIMENTAL)"
+	depends on NET_PCI && PCI && EXPERIMENTAL
+	select CRC32
+	select MII
+	help
+	  This driver supports Attansic L1 gigabit ethernet adapter.
+
+	  To compile this driver as a module, choose M here.  The module
+	  will be called atl1.
+
 endmenu
 
 #
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 4c0d4e5..d0beced 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_IXGB) += ixgb/
 obj-$(CONFIG_CHELSIO_T1) += chelsio/
 obj-$(CONFIG_EHEA) += ehea/
 obj-$(CONFIG_BONDING) += bonding/
+obj-$(CONFIG_ATL1) += atl1/
 obj-$(CONFIG_GIANFAR) += gianfar_driver.o
 
 gianfar_driver-objs := gianfar.o \
diff --git a/drivers/net/atl1/Makefile b/drivers/net/atl1/Makefile
new file mode 100644
index 0000000..1a10b91
--- /dev/null
+++ b/drivers/net/atl1/Makefile
@@ -0,0 +1,30 @@
+################################################################################
+#
+# Attansic L1 gigabit ethernet driver
+# Copyright(c) 2005 - 2006 Attansic Corporation.
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms and conditions of the GNU General Public License,
+# version 2, as published by the Free Software Foundation.
+#
+# This program is distributed in the hope it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# The full GNU General Public License is included in this distribution in
+# the file called "COPYING".
+#
+################################################################################
+
+#
+# Makefile for the Attansic L1 gigabit ethernet driver
+#
+
+obj-$(CONFIG_ATL1) += atl1.o
+
+atl1-objs := atl1_main.o atl1_hw.o atl1_ethtool.o atl1_param.o
