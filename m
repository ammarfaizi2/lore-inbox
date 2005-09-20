Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbVITSvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbVITSvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVITSvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:51:05 -0400
Received: from ppp-62-11-78-183.dialup.tiscali.it ([62.11.78.183]:19904 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965072AbVITSvB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:51:01 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 3/3] HostAP: fix Kbuild warning
Date: Tue, 20 Sep 2005 20:48:54 +0200
To: akpm@osdl.org
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Message-Id: <20050920184853.15031.29856.stgit@zion.home.lan>
In-Reply-To: <20050920184810.15031.14521.stgit@zion.home.lan>
References: <20050920184810.15031.14521.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The dependency on NET_RADIO is useless, because we select already it indirectly,
through IEEE80211.

The "recursive dependency" warning is actually IMHO partially wrong in this
context (we don't have a recursive dependency, but we *do* have recursion in the
code, for the way we recurse on "select" dependencies), but fixing it properly
doesn't seem easy (and I've not the time for this).

CC: Roman Zippel <zippel@linux-m68k.org>, <kbuild-devel@lists.sourceforge.net>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 drivers/net/wireless/hostap/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/wireless/hostap/Kconfig b/drivers/net/wireless/hostap/Kconfig
--- a/drivers/net/wireless/hostap/Kconfig
+++ b/drivers/net/wireless/hostap/Kconfig
@@ -1,6 +1,6 @@
 config HOSTAP
 	tristate "IEEE 802.11 for Host AP (Prism2/2.5/3 and WEP/TKIP/CCMP)"
-	depends on NET_RADIO
+	#Dependency on NET_RADIO is implied by selecting IEEE80211 -> NET_RADIO.
 	select IEEE80211
 	select IEEE80211_CRYPT_WEP
 	---help---

