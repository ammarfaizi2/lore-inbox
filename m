Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbWGNW64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbWGNW64 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 18:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWGNW64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 18:58:56 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:13271 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030435AbWGNW6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 18:58:55 -0400
Date: Fri, 14 Jul 2006 18:51:41 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] ieee80211: TKIP requires CRC32
To: linux-netdev <netdev@vger.kernel.org>
Cc: Toralf Foerster <toralf.foerster@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       linux-stable <stable@kernel.org>, Andrew Morton <akpm@osdl.org>
Message-ID: <200607141855_MC3-1-C4FF-BD1B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ieee80211_crypt_tkip will not work without CRC32.

  LD      .tmp_vmlinux1
net/built-in.o: In function `ieee80211_tkip_encrypt':
net/ieee80211/ieee80211_crypt_tkip.c:349: undefined reference to `crc32_le'

Reported by Toralf Foerster <toralf.foerster@gmx.de>

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.18-rc1-32.orig/net/ieee80211/Kconfig
+++ 2.6.18-rc1-32/net/ieee80211/Kconfig
@@ -58,6 +58,7 @@ config IEEE80211_CRYPT_TKIP
 	depends on IEEE80211 && NET_RADIO
 	select CRYPTO
 	select CRYPTO_MICHAEL_MIC
+	select CRC32
 	---help---
 	Include software based cipher suites in support of IEEE 802.11i
 	(aka TGi, WPA, WPA2, WPA-PSK, etc.) for use with TKIP enabled
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
