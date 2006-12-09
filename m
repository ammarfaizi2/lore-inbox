Return-Path: <linux-kernel-owner+w=401wt.eu-S1947565AbWLIACv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947565AbWLIACv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 19:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947549AbWLIACn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:02:43 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37671 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947547AbWLIACV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:02:21 -0500
Message-Id: <20061209000140.767367000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:13 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Samuel Ortiz <samuel@sortiz.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeet Chaudhuri <jeetlinux@yahoo.co.in>
Subject: [patch 22/32] IrDA: Incorrect TTP header reservation
Content-Disposition: inline; filename=irda-incorrect-ttp-header-reservation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Jeet Chaudhuri <jeetlinux@yahoo.co.in>

We must reserve SAR + MAX_HEADER bytes for IrLMP to fit in.
This fixes an oops reported (and fixed) by Jeet Chaudhuri, when max_sdu_size
is greater than 0.

Signed-off-by: Samuel Ortiz <samuel@sortiz.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 net/irda/irttp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.19.orig/net/irda/irttp.c
+++ linux-2.6.19/net/irda/irttp.c
@@ -1099,7 +1099,7 @@ int irttp_connect_request(struct tsap_cb
 			return -ENOMEM;
 
 		/* Reserve space for MUX_CONTROL and LAP header */
-		skb_reserve(tx_skb, TTP_MAX_HEADER);
+		skb_reserve(tx_skb, TTP_MAX_HEADER + TTP_SAR_HEADER);
 	} else {
 		tx_skb = userdata;
 		/*
@@ -1348,7 +1348,7 @@ int irttp_connect_response(struct tsap_c
 			return -ENOMEM;
 
 		/* Reserve space for MUX_CONTROL and LAP header */
-		skb_reserve(tx_skb, TTP_MAX_HEADER);
+		skb_reserve(tx_skb, TTP_MAX_HEADER + TTP_SAR_HEADER);
 	} else {
 		tx_skb = userdata;
 		/*

--
