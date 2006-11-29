Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758354AbWK2WEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758354AbWK2WEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758352AbWK2WEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:04:35 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:62676 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758294AbWK2WEH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:04:07 -0500
Message-Id: <20061129220539.979217000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:27 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Laurent Riffard <laurent.riffard@free.fr>,
       Daniel Drake <dsd@gentoo.org>, John W Linville <linville@tuxdriver.com>
Subject: [patch 16/23] softmac: fix a slab corruption in WEP restricted key association
Content-Disposition: inline; filename=softmac-fix-a-slab-corruption-in-wep-restricted-key-association.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Laurent Riffard <laurent.riffard@free.fr>

Fix a slab corruption in ieee80211softmac_auth(). The size of a buffer
was miscomputed.

see http://bugzilla.kernel.org/show_bug.cgi?id=7245

Acked-by: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/ieee80211/softmac/ieee80211softmac_io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.4.orig/net/ieee80211/softmac/ieee80211softmac_io.c
+++ linux-2.6.18.4/net/ieee80211/softmac/ieee80211softmac_io.c
@@ -304,7 +304,7 @@ ieee80211softmac_auth(struct ieee80211_a
 		2 +		/* Auth Transaction Seq */
 		2 +		/* Status Code */
 		 /* Challenge Text IE */
-		is_shared_response ? 0 : 1 + 1 + net->challenge_len
+		(is_shared_response ? 1 + 1 + net->challenge_len : 0)
 	);
 	if (unlikely((*pkt) == NULL))
 		return 0;

--
