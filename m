Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947562AbWLIAHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947562AbWLIAHQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947527AbWLHX7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:59:30 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37472 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947536AbWLHX7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:59:13 -0500
Message-Id: <20061209000041.612132000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:06 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Larry Finger <Larry.Finger@lwfinger.net>,
       maxime@tralhalla.org, Michael Buesch <mb@bu3sch.de>,
       Stefano Brivio <st3@riseup.net>
Subject: [patch 15/32] softmac: fix unbalanced mutex_lock/unlock in ieee80211softmac_wx_set_mlme
Content-Disposition: inline; filename=softmac-fix-unbalanced-mutex_lock-unlock-in-ieee80211softmac_wx_set_mlme.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Maxime Austruy <maxime@tralhalla.org>

Routine ieee80211softmac_wx_set_mlme has one return that fails
to release a mutex acquired at entry.

Signed-off-by: Maxime Austruy <maxime@tralhalla.org>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

John and Chris,

This error was introduced in the 2.6.19-rxX series and must be applied
to 2.6.19-stable and wireless-2.6.

Larry

 net/ieee80211/softmac/ieee80211softmac_wx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.19.orig/net/ieee80211/softmac/ieee80211softmac_wx.c
+++ linux-2.6.19/net/ieee80211/softmac/ieee80211softmac_wx.c
@@ -495,7 +495,8 @@ ieee80211softmac_wx_set_mlme(struct net_
 			printk(KERN_DEBUG PFX "wx_set_mlme: we should know the net here...\n");
 			goto out;
 		}
-		return ieee80211softmac_deauth_req(mac, net, reason);
+		err =  ieee80211softmac_deauth_req(mac, net, reason);
+		goto out;
 	case IW_MLME_DISASSOC:
 		ieee80211softmac_send_disassoc_req(mac, reason);
 		mac->associnfo.associated = 0;

--
