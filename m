Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVKBAxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVKBAxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVKBAxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:53:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23049 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932113AbVKBAxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:53:20 -0500
Date: Wed, 2 Nov 2005 01:53:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [-mm patch] fix NET_RADIO=n, IEEE80211=y compile
Message-ID: <20051102005316.GC8009@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 01:48:38AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.14-rc4-mm1:
>...
>  git-netdev-all.patch
>...
>  Subsystem trees
>...


<--  snip  -->


This patch fixes the following compile error with CONFIG_NET_RADIO=n and 
CONFIG_IEEE80211=y:

  LD      .tmp_vmlinux1
net/built-in.o: In function `ieee80211_rx':
: undefined reference to `wireless_spy_update'
make: *** [.tmp_vmlinux1] Error 1


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1-full/net/ieee80211/ieee80211_rx.c.old	2005-11-01 22:17:45.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/net/ieee80211/ieee80211_rx.c	2005-11-01 22:17:01.000000000 +0100
@@ -370,6 +370,7 @@
 	/* Put this code here so that we avoid duplicating it in all
 	 * Rx paths. - Jean II */
 #ifdef IW_WIRELESS_SPY		/* defined in iw_handler.h */
+#ifdef CONFIG_NET_RADIO
 	/* If spy monitoring on */
 	if (ieee->spy_data.spy_number > 0) {
 		struct iw_quality wstats;
@@ -396,6 +397,7 @@
 		/* Update spy records */
 		wireless_spy_update(ieee->dev, hdr->addr2, &wstats);
 	}
+#endif				/* CONFIG_NET_RADIO */
 #endif				/* IW_WIRELESS_SPY */
 
 #ifdef NOT_YET

