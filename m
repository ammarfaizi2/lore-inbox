Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268113AbUIJFNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268113AbUIJFNY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 01:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268094AbUIJFNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 01:13:24 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:29324
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268113AbUIJFNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 01:13:19 -0400
Date: Thu, 9 Sep 2004 22:12:44 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc: fix sungem NAPI
Message-Id: <20040909221244.0d0a91db.davem@davemloft.net>
In-Reply-To: <1094788157.2543.111.camel@gaston>
References: <1094788157.2543.111.camel@gaston>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004 13:49:17 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> The recent sungem NAPI change introduced a bug: dev_kfree_skb() is called
> within the spinlock, thus triggers all sort of WARN_ON's later on down the
> stack.
> 
> This patch changes it to dev_kfree_skb_any(), I hope that is fine
> as we aren't really in interrupt, are we ? (I don't know in what
> context NAPI polling occurs, is it a timer IRQ ?)

NAPI polling occurs from softirq context.

Thanks for making me aware of this.  This fix is fine for
now, but it may be possible to simplify it and I'll look
into that.

