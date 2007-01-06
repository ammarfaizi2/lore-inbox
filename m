Return-Path: <linux-kernel-owner+w=401wt.eu-S1751098AbXAFC2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbXAFC2Y (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbXAFC1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:27:50 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47854 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094AbXAFC1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:27:04 -0500
Message-Id: <20070106022931.148239000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:27:57 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Michael Buesch <mb@bu3sch.de>,
       Johannes Berg <johannes@sipsolutions.net>,
       "John W. Linville" <linville@tuxdriver.com>, dsd@gentoo.org,
       Ulrich Kunitz <kune@deine-taler.de>
Subject: [patch 04/50] ieee80211softmac: Fix mutex_lock at exit of ieee80211_softmac_get_genie
Content-Disposition: inline; filename=ieee80211softmac-fix-mutex_lock-at-exit-of-ieee80211_softmac_get_genie.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Ulrich Kunitz <kune@deine-taler.de>

ieee80211softmac_wx_get_genie locks the associnfo mutex at
function exit. This patch fixes it. The patch is against Linus'
tree (commit af1713e0).

Signed-off-by: Ulrich Kunitz <kune@deine-taler.de>
Signed-off-by: Michael Buesch <mb@bu3sch.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/ieee80211/softmac/ieee80211softmac_wx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.1.orig/net/ieee80211/softmac/ieee80211softmac_wx.c
+++ linux-2.6.19.1/net/ieee80211/softmac/ieee80211softmac_wx.c
@@ -463,7 +463,7 @@ ieee80211softmac_wx_get_genie(struct net
 			err = -E2BIG;
 	}
 	spin_unlock_irqrestore(&mac->lock, flags);
-	mutex_lock(&mac->associnfo.mutex);
+	mutex_unlock(&mac->associnfo.mutex);
 
 	return err;
 }

--
