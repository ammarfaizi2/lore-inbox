Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272483AbTHJHsh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 03:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272487AbTHJHsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 03:48:37 -0400
Received: from dsl093-079-232.sfo2.dsl.speakeasy.net ([66.93.79.232]:36739
	"EHLO hamachi.dyndns.org") by vger.kernel.org with ESMTP
	id S272483AbTHJHsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 03:48:31 -0400
Date: Sun, 10 Aug 2003 00:47:53 -0700
From: Steven Ihde <sihde@cs.nospam4me.stanford.edu>
To: linux-kernel@vger.kernel.org
Cc: shemminger@osdl.org
Subject: [PATCH 2.6.0-test3] ppp_generic.c: fix PPP compression
Message-ID: <20030810074753.GB21625@hamachi.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

A typo in ppp_generic.c broke handling of CCP_CONFACK messages and
thus PPP compression.... this one-liner fixes it (worked for me,
anyway).  Patch is against 2.6.0-test3.

Thanks,

Steven Ihde (remove "nospam4me." to reply)

diff -Naur a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
--- a/drivers/net/ppp_generic.c	2003-08-09 04:41:36.000000000 +0000
+++ b/drivers/net/ppp_generic.c	2003-08-10 07:44:20.000000000 +0000
@@ -2073,7 +2073,7 @@
 	case CCP_CONFACK:
 		if ((ppp->flags & (SC_CCP_OPEN | SC_CCP_UP)) != SC_CCP_OPEN)
 			break;
-		if (!pskb_may_pull(skb, len = CCP_LENGTH(dp)) + 2)
+		if (!pskb_may_pull(skb, (len = CCP_LENGTH(dp)) + 2))
 			return;		/* too short */
 		dp += CCP_HDRLEN;
 		len -= CCP_HDRLEN;
