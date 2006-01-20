Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWATMbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWATMbA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWATMbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:31:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47065 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750916AbWATMbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:31:00 -0500
Date: Fri, 20 Jan 2006 04:30:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Vitaly V. Bursov" <vitalyb@telenet.dn.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.6.15.1 ppp_async panic on x86-64.
Message-Id: <20060120043038.0dd9669b.akpm@osdl.org>
In-Reply-To: <20060115214838.2034a56c.vitalyb@telenet.dn.ua>
References: <20060115214838.2034a56c.vitalyb@telenet.dn.ua>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Vitaly V. Bursov" <vitalyb@telenet.dn.ua> wrote:
>
>  PPP doesn't work for me on a x86-64 kernel.
>

The below was merged a couple of days ago, which should fix it.  Can you
please confirm that?




Begin forwarded message:

Date: Tue, 17 Jan 2006 18:03:32 -0800
From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: git-commits-head@vger.kernel.org
Subject: [NET]: Make second arg to skb_reserved() signed.


tree 39750d44770efcdac150f041f71b7272c8da20f9
parent f09484ff87f677056ce631aa3d8e486861501b51
author David S. Miller <davem@sunset.davemloft.net> Tue, 17 Jan 2006 18:54:21 -0800
committer David S. Miller <davem@sunset.davemloft.net> Tue, 17 Jan 2006 18:54:21 -0800

[NET]: Make second arg to skb_reserved() signed.

Some subsystems, such as PPP, can send negative values
here.  It just happened to work correctly on 32-bit with
an unsigned value, but on 64-bit this explodes.

Figured out by Paul Mackerras based upon several PPP crash
reports.

Signed-off-by: David S. Miller <davem@davemloft.net>

 include/linux/skbuff.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index e5fd66c..ad7cc22 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -926,7 +926,7 @@ static inline int skb_tailroom(const str
  *	Increase the headroom of an empty &sk_buff by reducing the tail
  *	room. This is only allowed for an empty buffer.
  */
-static inline void skb_reserve(struct sk_buff *skb, unsigned int len)
+static inline void skb_reserve(struct sk_buff *skb, int len)
 {
 	skb->data += len;
 	skb->tail += len;
-
To unsubscribe from this list: send the line "unsubscribe git-commits-head" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
