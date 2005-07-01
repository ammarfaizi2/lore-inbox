Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263374AbVGAQRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263374AbVGAQRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 12:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbVGAQRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 12:17:55 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:53475 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S263374AbVGAQRx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 12:17:53 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: Ark Linux team
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.13-rc1-mm1 unresolved symbols
Date: Fri, 1 Jul 2005 18:18:17 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JzWxCn3y4oUeHAW"
Message-Id: <200507011818.17828.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_JzWxCn3y4oUeHAW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ipw2200 in 2.6.13-rc1-mm1 makes use of is_broadcast_ether_addr, which was 
removed.

The attached patch restores that function for now.

LLaP
bero

--Boundary-00=_JzWxCn3y4oUeHAW
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.13-rc1-mm1-restore-is_broadcast_ether_addr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.13-rc1-mm1-restore-is_broadcast_ether_addr.patch"

--- linux-2.6.13-rc1/include/net/ieee80211.h.ark	2005-07-01 17:46:22.000000000 +0200
+++ linux-2.6.13-rc1/include/net/ieee80211.h	2005-07-01 17:47:26.000000000 +0200
@@ -627,6 +627,11 @@
 #define MAC_FMT "%02x:%02x:%02x:%02x:%02x:%02x"
 #define MAC_ARG(x) ((u8*)(x))[0],((u8*)(x))[1],((u8*)(x))[2],((u8*)(x))[3],((u8*)(x))[4],((u8*)(x))[5]
 
+extern inline int is_broadcast_ether_addr(const u8 *addr)
+{
+	return ((addr[0] == 0xff) && (addr[1] == 0xff) && (addr[2] == 0xff) &&
+		(addr[3] == 0xff) && (addr[4] == 0xff) && (addr[5] == 0xff));
+}
 
 #define CFG_IEEE80211_RESERVE_FCS (1<<0)
 #define CFG_IEEE80211_COMPUTE_FCS (1<<1)

--Boundary-00=_JzWxCn3y4oUeHAW--
