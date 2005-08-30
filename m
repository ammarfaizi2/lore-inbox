Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVISSOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVISSOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVISSOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:14:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14465 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932544AbVISSOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:14:39 -0400
Date: Tue, 30 Aug 2005 17:32:04 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: [PATCH] dereference of uninitialized pointer in zatm
Message-ID: <20050830163204.GJ9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Breakage from [NET]: Kill skb->list
Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-base/drivers/atm/zatm.c current/drivers/atm/zatm.c
--- RC13-base/drivers/atm/zatm.c	2005-08-30 03:24:42.000000000 -0400
+++ current/drivers/atm/zatm.c	2005-08-30 03:25:18.000000000 -0400
@@ -417,9 +417,9 @@
 		chan = (here[3] & uPD98401_AAL5_CHAN) >>
 		    uPD98401_AAL5_CHAN_SHIFT;
 		if (chan < zatm_dev->chans && zatm_dev->rx_map[chan]) {
-			int pos = ZATM_VCC(vcc)->pool;
-
+			int pos;
 			vcc = zatm_dev->rx_map[chan];
+			pos = ZATM_VCC(vcc)->pool;
 			if (skb == zatm_dev->last_free[pos])
 				zatm_dev->last_free[pos] = NULL;
 			skb_unlink(skb, zatm_dev->pool + pos);
