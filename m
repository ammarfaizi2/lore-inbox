Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263431AbVBCSZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263431AbVBCSZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbVBCSYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 13:24:33 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:61591
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263687AbVBCSVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 13:21:43 -0500
Date: Thu, 3 Feb 2005 10:14:20 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Anton Blanchard <anton@samba.org>
Cc: herbert@gondor.apana.org.au, okir@suse.de, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-Id: <20050203101420.468c1607.davem@davemloft.net>
In-Reply-To: <20050203142705.GA11318@krispykreme.ozlabs.ibm.com>
References: <20050131102920.GC4170@suse.de>
	<E1CvZo6-0001Bz-00@gondolin.me.apana.org.au>
	<20050203142705.GA11318@krispykreme.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 01:27:05 +1100
Anton Blanchard <anton@samba.org> wrote:

> Architectures should guarantee that any of the atomics and bitops that
> return values order in both directions. So you dont need the
> smp_mb__before_atomic_dec here.
> 
> It is, however, required on the atomics and bitops that dont return
> values. Its difficult stuff, everyone gets it wrong and Andrew keeps
> hassling me to write up a document explaining it.

Sparc64 happens to order the atomic we use in the bitops and atomic_t
ops, so sparc64 gets this right by accident.

I had no idea about this requirement before reading your email.

If IBM is seeing race this on ppc64, then I'm even more confused.
If Anton understands the requirements, then ppc64 should have
the return value atomic's implemented with the proper barriers.
