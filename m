Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947541AbWLIACB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947541AbWLIACB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947545AbWLIABg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:01:36 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37617 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947540AbWLIABW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:01:22 -0500
Message-Id: <20061209000114.308422000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:10 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, Patrick McHardy <kaber@trash.net>
Subject: [patch 19/32] XFRM: Use output device disable_xfrm for forwarded packets
Content-Disposition: inline; filename=xfrm-use-output-device-disable_xfrm-for-forwarded-packets.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Patrick McHardy <kaber@trash.net>

Currently the behaviour of disable_xfrm is inconsistent between
locally generated and forwarded packets. For locally generated
packets disable_xfrm disables the policy lookup if it is set on
the output device, for forwarded traffic however it looks at the
input device. This makes it impossible to disable xfrm on all
devices but a dummy device and use normal routing to direct
traffic to that device.

Always use the output device when checking disable_xfrm.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
commit 9be2b4e36fb04bbc968693ef95a75acc17cf2931
Author: Patrick McHardy <kaber@trash.net>
Date:   Mon Dec 4 19:59:00 2006 -0800

 net/ipv4/route.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.orig/net/ipv4/route.c
+++ linux-2.6.19/net/ipv4/route.c
@@ -1784,7 +1784,7 @@ static inline int __mkroute_input(struct
 #endif
 	if (in_dev->cnf.no_policy)
 		rth->u.dst.flags |= DST_NOPOLICY;
-	if (in_dev->cnf.no_xfrm)
+	if (out_dev->cnf.no_xfrm)
 		rth->u.dst.flags |= DST_NOXFRM;
 	rth->fl.fl4_dst	= daddr;
 	rth->rt_dst	= daddr;

--
