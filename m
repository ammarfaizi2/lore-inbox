Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWDUEpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWDUEpE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWDUEot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:57473 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932241AbWDUEoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:08 -0400
Date: Thu, 20 Apr 2006 21:39:01 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       netdev-core@vger.kernel.org, yoshfuji@linux-ipv6.org,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 11/22] IPV6: XFRM: Dont use old copy of pointer after pskb_may_pull().
Message-ID: <20060421043901.GL12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ipv6-xfrm-don-t-use-old-copy-of-pointer-after-pskb_may_pull.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IPV6] XFRM: Don't use old copy of pointer after pskb_may_pull().

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

---
 net/ipv6/xfrm6_policy.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.16.9.orig/net/ipv6/xfrm6_policy.c
+++ linux-2.6.16.9/net/ipv6/xfrm6_policy.c
@@ -193,7 +193,7 @@ _decode_session6(struct sk_buff *skb, st
 {
 	u16 offset = sizeof(struct ipv6hdr);
 	struct ipv6hdr *hdr = skb->nh.ipv6h;
-	struct ipv6_opt_hdr *exthdr = (struct ipv6_opt_hdr*)(skb->nh.raw + offset);
+	struct ipv6_opt_hdr *exthdr;
 	u8 nexthdr = skb->nh.ipv6h->nexthdr;
 
 	memset(fl, 0, sizeof(struct flowi));
@@ -201,6 +201,8 @@ _decode_session6(struct sk_buff *skb, st
 	ipv6_addr_copy(&fl->fl6_src, &hdr->saddr);
 
 	while (pskb_may_pull(skb, skb->nh.raw + offset + 1 - skb->data)) {
+		exthdr = (struct ipv6_opt_hdr*)(skb->nh.raw + offset);
+
 		switch (nexthdr) {
 		case NEXTHDR_ROUTING:
 		case NEXTHDR_HOP:

--
