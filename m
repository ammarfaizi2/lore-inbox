Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270575AbTGNMKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270559AbTGNMJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:09:04 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39044
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270570AbTGNMHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:07:25 -0400
Date: Mon, 14 Jul 2003 13:21:21 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141221.h6ECLLDM030866@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: make pcmcica devices report pcmcia bus info in gdrvinfo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/net/pcmcia/3c574_cs.c linux.22-pre5-ac1/drivers/net/pcmcia/3c574_cs.c
--- linux.22-pre5/drivers/net/pcmcia/3c574_cs.c	2003-07-14 12:26:42.000000000 +0100
+++ linux.22-pre5-ac1/drivers/net/pcmcia/3c574_cs.c	2003-06-29 16:09:55.000000000 +0100
@@ -1202,6 +1202,7 @@
 	case ETHTOOL_GDRVINFO: {
 		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
 		strncpy(info.driver, "3c574_cs", sizeof(info.driver)-1);
+		sprintf(info.bus_info, "PCMCIA 0x%lx", dev->base_addr);
 		if (copy_to_user(useraddr, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/net/pcmcia/axnet_cs.c linux.22-pre5-ac1/drivers/net/pcmcia/axnet_cs.c
--- linux.22-pre5/drivers/net/pcmcia/axnet_cs.c	2003-07-14 12:26:42.000000000 +0100
+++ linux.22-pre5-ac1/drivers/net/pcmcia/axnet_cs.c	2003-06-29 16:09:56.000000000 +0100
@@ -833,6 +833,7 @@
 	case ETHTOOL_GDRVINFO: {
 		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
 		strncpy(info.driver, "axnet_cs", sizeof(info.driver)-1);
+		sprintf(info.bus_info, "PCMCIA 0x%lx", dev->base_addr);
 		if (copy_to_user(useraddr, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/net/pcmcia/ibmtr_cs.c linux.22-pre5-ac1/drivers/net/pcmcia/ibmtr_cs.c
--- linux.22-pre5/drivers/net/pcmcia/ibmtr_cs.c	2003-07-14 12:26:42.000000000 +0100
+++ linux.22-pre5-ac1/drivers/net/pcmcia/ibmtr_cs.c	2003-06-29 16:09:56.000000000 +0100
@@ -177,6 +177,7 @@
 	case ETHTOOL_GDRVINFO: {
 		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
 		strncpy(info.driver, "ibmtr_cs", sizeof(info.driver)-1);
+		sprintf(info.bus_info, "PCMCIA 0x%lx", dev->base_addr);
 		if (copy_to_user(useraddr, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/net/pcmcia/pcnet_cs.c linux.22-pre5-ac1/drivers/net/pcmcia/pcnet_cs.c
--- linux.22-pre5/drivers/net/pcmcia/pcnet_cs.c	2003-07-14 12:26:42.000000000 +0100
+++ linux.22-pre5-ac1/drivers/net/pcmcia/pcnet_cs.c	2003-06-29 16:09:55.000000000 +0100
@@ -1226,6 +1226,7 @@
 	case ETHTOOL_GDRVINFO: {
 		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
 		strncpy(info.driver, "pcnet_cs", sizeof(info.driver)-1);
+		sprintf(info.bus_info, "PCMCIA 0x%lx", dev->base_addr);
 		if (copy_to_user(useraddr, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/net/pcmcia/ray_cs.c linux.22-pre5-ac1/drivers/net/pcmcia/ray_cs.c
--- linux.22-pre5/drivers/net/pcmcia/ray_cs.c	2003-07-14 12:26:42.000000000 +0100
+++ linux.22-pre5-ac1/drivers/net/pcmcia/ray_cs.c	2003-06-29 16:09:55.000000000 +0100
@@ -1247,6 +1247,7 @@
 	case ETHTOOL_GDRVINFO: {
 		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
 		strncpy(info.driver, "ray_cs", sizeof(info.driver)-1);
+		sprintf(info.bus_info, "PCMCIA 0x%lx", dev->base_addr);
 		if (copy_to_user(useraddr, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/net/pcmcia/smc91c92_cs.c linux.22-pre5-ac1/drivers/net/pcmcia/smc91c92_cs.c
--- linux.22-pre5/drivers/net/pcmcia/smc91c92_cs.c	2003-07-14 12:26:42.000000000 +0100
+++ linux.22-pre5-ac1/drivers/net/pcmcia/smc91c92_cs.c	2003-06-29 16:09:55.000000000 +0100
@@ -2161,6 +2161,7 @@
 	struct ethtool_drvinfo info = { ETHTOOL_GDRVINFO };
 	strcpy(info.driver, DRV_NAME);
 	strcpy(info.version, DRV_VERSION);
+	sprintf(info.bus_info, "PCMCIA 0x%lx", dev->base_addr);
 	if (copy_to_user(useraddr, &info, sizeof(info)))
 	    return -EFAULT;
 	return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/net/pcmcia/wavelan_cs.c linux.22-pre5-ac1/drivers/net/pcmcia/wavelan_cs.c
--- linux.22-pre5/drivers/net/pcmcia/wavelan_cs.c	2003-07-14 12:26:42.000000000 +0100
+++ linux.22-pre5-ac1/drivers/net/pcmcia/wavelan_cs.c	2003-06-29 16:09:55.000000000 +0100
@@ -1902,6 +1902,7 @@
 	case ETHTOOL_GDRVINFO: {
 		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
 		strncpy(info.driver, "wavelan_cs", sizeof(info.driver)-1);
+		sprintf(info.bus_info, "PCMCIA 0x%lx", dev->base_addr);
 		if (copy_to_user(useraddr, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/net/pcmcia/xirc2ps_cs.c linux.22-pre5-ac1/drivers/net/pcmcia/xirc2ps_cs.c
--- linux.22-pre5/drivers/net/pcmcia/xirc2ps_cs.c	2003-07-14 12:26:42.000000000 +0100
+++ linux.22-pre5-ac1/drivers/net/pcmcia/xirc2ps_cs.c	2003-06-29 16:09:55.000000000 +0100
@@ -1733,6 +1733,7 @@
 	case ETHTOOL_GDRVINFO: {
 		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
 		strncpy(info.driver, "xirc2ps_cs", sizeof(info.driver)-1);
+		sprintf(info.bus_info, "PCMCIA 0x%lx", dev->base_addr);
 		if (copy_to_user(useraddr, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
