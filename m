Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161662AbWAMDVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161662AbWAMDVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161664AbWAMDUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:20:20 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:28291 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161662AbWAMDT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:19:57 -0500
Message-Id: <20060113032243.848998000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:46 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       "Linus Torvalds" <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "Dmitry Mishin" <dim@sw.ru>, "Stanislav Protassov" <st@sw.ru>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       alan@lxorguk.ukuu.org.uk, Kirill Korotaev <dev@openvz.org>
Subject: [PATCH 08/17] [PATCH] netlink oops fix due to incorrect error code
Content-Disposition: inline; filename=netlink-oops-fix-due-to-incorrect-error-code.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fixed oops after failed netlink socket creation.
Wrong parathenses in if() statement caused err to be 1,
instead of negative value.
Trivial fix, not trivial to find though.

Signed-Off-By: Dmitry Mishin <dim@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/netlink/af_netlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.y.orig/net/netlink/af_netlink.c
+++ linux-2.6.15.y/net/netlink/af_netlink.c
@@ -402,7 +402,7 @@ static int netlink_create(struct socket 
 	groups = nl_table[protocol].groups;
 	netlink_unlock_table();
 
-	if ((err = __netlink_create(sock, protocol) < 0))
+	if ((err = __netlink_create(sock, protocol)) < 0)
 		goto out_module;
 
 	nlk = nlk_sk(sock->sk);

--
