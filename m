Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWAVL5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWAVL5l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 06:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWAVL5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 06:57:41 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:37260 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932418AbWAVL5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 06:57:40 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "John W. Linville" <linville@tuxdriver.com>
Subject: [PATCH] trivial fix
Date: Sun, 22 Jan 2006 13:57:10 +0200
User-Agent: KMail/1.8.2
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jbenc@suse.cz,
       softmac-dev@sipsolutions.net
References: <20060118200616.GC6583@tuxdriver.com>
In-Reply-To: <20060118200616.GC6583@tuxdriver.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WM30Dtv9GsA78a5"
Message-Id: <200601221357.10939.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_WM30Dtv9GsA78a5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch fixes misplaced (). Diffed against wireless-2.6.git

Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
--
vda

--Boundary-00=_WM30Dtv9GsA78a5
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="trivial.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="trivial.patch"

diff -urpN softmac-snapshot/net/ieee80211/ieee80211_rx.c softmac-snapshot.1/net/ieee80211/ieee80211_rx.c
--- softmac-snapshot/net/ieee80211/ieee80211_rx.c	Wed Jan 18 07:27:03 2006
+++ softmac-snapshot.1/net/ieee80211/ieee80211_rx.c	Sun Jan 22 13:12:30 2006
@@ -562,7 +562,7 @@ int ieee80211_rx(struct ieee80211_device
 	/* skb: hdr + (possibly fragmented) plaintext payload */
 	// PR: FIXME: hostap has additional conditions in the "if" below:
 	// ieee->host_decrypt && (fc & IEEE80211_FCTL_PROTECTED) &&
-	if ((frag != 0 || (fc & IEEE80211_FCTL_MOREFRAGS))) {
+	if ((frag != 0) || (fc & IEEE80211_FCTL_MOREFRAGS)) {
 		int flen;
 		struct sk_buff *frag_skb = ieee80211_frag_cache_get(ieee, hdr);
 		IEEE80211_DEBUG_FRAG("Rx Fragment received (%u)\n", frag);

--Boundary-00=_WM30Dtv9GsA78a5--
