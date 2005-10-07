Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbVJGXzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVJGXzP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 19:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVJGXzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 19:55:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:9174 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964919AbVJGXzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 19:55:04 -0400
Date: Fri, 7 Oct 2005 16:54:36 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, davem@davemloft.net
Subject: [patch 3/7] [TCP]: BIC coding bug in Linux 2.6.13
Message-ID: <20051007235436.GD23111@kroah.com>
References: <20051007234348.631583000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="tcp-congestion-control-bug.patch"
In-Reply-To: <20051007235353.GA23111@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>

Please consider this change for 2.6.13-stable   Since BIC is
the default congestion control algorithm, this fix is quite
important.

Missing parenthesis in causes BIC to be slow in increasing congestion
window.

Spotted by Injong Rhee.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/tcp_bic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13.y.orig/net/ipv4/tcp_bic.c
+++ linux-2.6.13.y/net/ipv4/tcp_bic.c
@@ -136,7 +136,7 @@ static inline void bictcp_update(struct 
 		else if (cwnd < ca->last_max_cwnd + max_increment*(BICTCP_B-1))
 			/* slow start */
 			ca->cnt = (cwnd * (BICTCP_B-1))
-				/ cwnd-ca->last_max_cwnd;
+				/ (cwnd - ca->last_max_cwnd);
 		else
 			/* linear increase */
 			ca->cnt = cwnd / max_increment;

--
