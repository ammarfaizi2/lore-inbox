Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVG0TyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVG0TyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 15:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVG0Tw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 15:52:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25097 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262043AbVG0TvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 15:51:11 -0400
Date: Wed, 27 Jul 2005 21:51:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, jkmaline@cc.hut.fi, hostap@shmoo.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [-mm patch] include/net/ieee80211.h must #include <linux/wireless.h>
Message-ID: <20050727195100.GA29092@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc found an (although perhaps harmless) bug:

<--  snip  -->

...
  CC      net/ieee80211/ieee80211_crypt.o
In file included from net/ieee80211/ieee80211_crypt.c:21:
include/net/ieee80211.h:26:5: warning: "WIRELESS_EXT" is not defined
  CC      net/ieee80211/ieee80211_crypt_wep.o
In file included from net/ieee80211/ieee80211_crypt_wep.c:20:
include/net/ieee80211.h:26:5: warning: "WIRELESS_EXT" is not defined
  CC      net/ieee80211/ieee80211_crypt_ccmp.o
  CC      net/ieee80211/ieee80211_crypt_tkip.o
In file included from net/ieee80211/ieee80211_crypt_tkip.c:23:
include/net/ieee80211.h:26:5: warning: "WIRELESS_EXT" is not defined
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 22 Jul 2005

--- linux-2.6.13-rc3-mm1-full/include/net/ieee80211.h.old	2005-07-22 18:37:57.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/include/net/ieee80211.h	2005-07-22 18:38:10.000000000 +0200
@@ -22,6 +22,7 @@
 #define IEEE80211_H
 #include <linux/if_ether.h> /* ETH_ALEN */
 #include <linux/kernel.h>   /* ARRAY_SIZE */
+#include <linux/wireless.h>
 
 #if WIRELESS_EXT < 17
 #define IW_QUAL_QUAL_INVALID   0x10

