Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWGQQde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWGQQde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWGQQde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:33:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:6844 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750979AbWGQQdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:16 -0400
Date: Mon, 17 Jul 2006 09:28:16 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       linux-netdev <netdev@vger.kernel.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Toralf Foerster <toralf.foerster@gmx.de>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 29/45] ieee80211: TKIP requires CRC32
Message-ID: <20060717162816.GD4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ieee80211-tkip-requires-crc32.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
ieee80211_crypt_tkip will not work without CRC32.

  LD      .tmp_vmlinux1
net/built-in.o: In function `ieee80211_tkip_encrypt':
net/ieee80211/ieee80211_crypt_tkip.c:349: undefined reference to `crc32_le'

Reported by Toralf Foerster <toralf.foerster@gmx.de>

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ieee80211/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.17.6.orig/net/ieee80211/Kconfig
+++ linux-2.6.17.6/net/ieee80211/Kconfig
@@ -58,6 +58,7 @@ config IEEE80211_CRYPT_TKIP
 	depends on IEEE80211 && NET_RADIO
 	select CRYPTO
 	select CRYPTO_MICHAEL_MIC
+	select CRC32
 	---help---
 	Include software based cipher suites in support of IEEE 802.11i
 	(aka TGi, WPA, WPA2, WPA-PSK, etc.) for use with TKIP enabled

--
