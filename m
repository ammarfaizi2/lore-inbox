Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbVKIFOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbVKIFOT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 00:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbVKIFOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 00:14:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965171AbVKIFOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 00:14:19 -0500
Date: Tue, 8 Nov 2005 21:13:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Linux 2.6.14.1
Message-Id: <20051108211354.546e0163.akpm@osdl.org>
In-Reply-To: <20051109010729.GA22439@kroah.com>
References: <20051109010729.GA22439@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> wrote:
>
> We (the -stable team) are announcing the release of the 2.6.14.1 kernel.

We need the fix for the net-drops-zero-length-udp-messages bug which broke
bind and traceroute.



Begin forwarded message:

Date: Fri, 4 Nov 2005 12:04:53 -0800
From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: git-commits-head@vger.kernel.org
Subject: [NET]: Fix zero-size datagram reception


tree ee282f7fd6e465d7b031d64b9ed7c03233ea94cf
parent c2da8acaf488b8651edfb04ebf3ab089f3a7830f
author Herbert Xu <herbert@gondor.apana.org.au> Wed, 02 Nov 2005 18:55:00 +1100
committer Arnaldo Carvalho de Melo <acme@mandriva.com> Thu, 03 Nov 2005 02:25:04 -0200

[NET]: Fix zero-size datagram reception

The recent rewrite of skb_copy_datagram_iovec broke the reception of
zero-size datagrams.  This patch fixes it.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Arnaldo Carvalho de Melo <acme@mandriva.com>

 net/core/datagram.c |    4 ++++
 1 files changed, 4 insertions(+)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 81987df..d219435 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
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
-
To unsubscribe from this list: send the line "unsubscribe git-commits-head" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
