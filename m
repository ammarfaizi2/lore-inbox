Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947515AbWLHX50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947515AbWLHX50 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 18:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947517AbWLHX50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:57:26 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:60319 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947515AbWLHX5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:57:25 -0500
Message-Id: <20061208235836.202043000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:57:53 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Larry Finger <Larry.Finger@lwfinger.net>,
       Michael Buesch <mb@bu3sch.de>
Subject: [patch 02/32] softmac: remove netif_tx_disable when scanning
Content-Disposition: inline; filename=softmac-remove-netif_tx_disable-when-scanning.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Michael Buesch <mb@bu3sch.de>

In the scan section of ieee80211softmac, network transmits are disabled.
When SoftMAC re-enables transmits, it may override the wishes of a driver
that may have very good reasons for disabling transmits. At least one failure
in bcm43xx can be traced to this problem. In addition, several unexplained
problems may arise from the unexpected enabling of transmits.

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/ieee80211/softmac/ieee80211softmac_scan.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.19.orig/net/ieee80211/softmac/ieee80211softmac_scan.c
+++ linux-2.6.19/net/ieee80211/softmac/ieee80211softmac_scan.c
@@ -47,7 +47,6 @@ ieee80211softmac_start_scan(struct ieee8
 	sm->scanning = 1;
 	spin_unlock_irqrestore(&sm->lock, flags);
 
-	netif_tx_disable(sm->ieee->dev);
 	ret = sm->start_scan(sm->dev);
 	if (ret) {
 		spin_lock_irqsave(&sm->lock, flags);
@@ -248,7 +247,6 @@ void ieee80211softmac_scan_finished(stru
 		if (net)
 			sm->set_channel(sm->dev, net->channel);
 	}
-	netif_wake_queue(sm->ieee->dev);
 	ieee80211softmac_call_events(sm, IEEE80211SOFTMAC_EVENT_SCAN_FINISHED, NULL);
 }
 EXPORT_SYMBOL_GPL(ieee80211softmac_scan_finished);

--
