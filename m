Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268937AbUINE6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268937AbUINE6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 00:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268947AbUINE6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 00:58:09 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:25770
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268937AbUINE6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 00:58:05 -0400
Date: Mon, 13 Sep 2004 21:55:56 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: jmorris@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.9-rc1-mm5: TCP oopses
Message-Id: <20040913215556.73026adf.davem@davemloft.net>
In-Reply-To: <E1C745E-00024r-00@gondolin.me.apana.org.au>
References: <20040913190858.12544431.davem@davemloft.net>
	<E1C745E-00024r-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James, does this make your problem go away?

Thanks for testing.

===== net/ipv4/tcp_output.c 1.57 vs edited =====
--- 1.57/net/ipv4/tcp_output.c	2004-09-12 16:17:23 -07:00
+++ edited/net/ipv4/tcp_output.c	2004-09-13 21:36:59 -07:00
@@ -991,7 +991,7 @@
 		/* New SKB created, account for it. */
 		new_factor = TCP_SKB_CB(skb)->tso_factor;
 		tcp_dec_pcount_explicit(&tp->packets_out,
-					new_factor - old_factor);
+					old_factor - new_factor);
 		tcp_inc_pcount(&tp->packets_out, skb->next);
 	}
 
