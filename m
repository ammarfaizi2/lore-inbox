Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161453AbWJKVRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161453AbWJKVRl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161466AbWJKVQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:16:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:13475 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161368AbWJKVI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:08:58 -0400
Date: Wed, 11 Oct 2006 14:08:09 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 51/67] IPV6: bh_lock_sock_nested on tcp_v6_rcv
Message-ID: <20061011210809.GZ16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ipv6-bh_lock_sock_nested-on-tcp_v6_rcv.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Fabio Olive Leite <fleite@redhat.com>

A while ago Ingo patched tcp_v4_rcv on net/ipv4/tcp_ipv4.c to use
bh_lock_sock_nested and silence a lock validator warning. This fixed
it for IPv4, but recently I saw a report of the same warning on IPv6.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv6/tcp_ipv6.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.orig/net/ipv6/tcp_ipv6.c
+++ linux-2.6.18/net/ipv6/tcp_ipv6.c
@@ -1228,7 +1228,7 @@ process:
 
 	skb->dev = NULL;
 
-	bh_lock_sock(sk);
+	bh_lock_sock_nested(sk);
 	ret = 0;
 	if (!sock_owned_by_user(sk)) {
 #ifdef CONFIG_NET_DMA

--
