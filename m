Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbVKISii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbVKISii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbVKISi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:38:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:33181 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751493AbVKISiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:38:06 -0500
Date: Wed, 9 Nov 2005 10:37:00 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       netdev@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, herbert@gondor.apana.org.au,
       phillips@istop.com
Subject: [patch 07/11] NET: Fix zero-size datagram reception
Message-ID: <20051109183700.GH3670@kroah.com>
References: <20051109182205.294803000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-zero-size-datagram-reception.patch"
In-Reply-To: <20051109183614.GA3670@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

The recent rewrite of skb_copy_datagram_iovec broke the reception of
zero-size datagrams.  This patch fixes it.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/core/datagram.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-2.6.14.1.orig/net/core/datagram.c
+++ linux-2.6.14.1/net/core/datagram.c
@@ -213,6 +213,10 @@ int skb_copy_datagram_iovec(const struct
 {
 	int i, err, fraglen, end = 0;
 	struct sk_buff *next = skb_shinfo(skb)->frag_list;
+
+	if (!len)
+		return 0;
+
 next_skb:
 	fraglen = skb_headlen(skb);
 	i = -1;

--
