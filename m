Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVHCHCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVHCHCR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 03:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVHCHCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 03:02:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262046AbVHCHB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 03:01:59 -0400
Date: Wed, 3 Aug 2005 00:01:27 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: [09/13] [XFRM]: Fix possible overflow of sock->sk_policy
Message-ID: <20050803070127.GX7762@shell0.pdx.osdl.net>
References: <20050803064439.GO7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803064439.GO7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[XFRM]: Fix possible overflow of sock->sk_policy

Spotted by, and original patch by, Balazs Scheidler.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/xfrm/xfrm_user.c |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2.6.12.3.orig/net/xfrm/xfrm_user.c	2005-07-28 11:17:01.000000000 -0700
+++ linux-2.6.12.3/net/xfrm/xfrm_user.c	2005-07-28 11:17:18.000000000 -0700
@@ -1180,6 +1180,9 @@
 	if (nr > XFRM_MAX_DEPTH)
 		return NULL;
 
+	if (p->dir > XFRM_POLICY_OUT)
+		return NULL;
+
 	xp = xfrm_policy_alloc(GFP_KERNEL);
 	if (xp == NULL) {
 		*dir = -ENOBUFS;
