Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268183AbUIJFak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268183AbUIJFak (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 01:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268197AbUIJFaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 01:30:39 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:38796
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268183AbUIJF3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 01:29:30 -0400
Date: Thu, 9 Sep 2004 22:25:42 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: fork0@users.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.9-rc1+bk: assertion tcp_get_pcount failed at
 net/ipv4/tcp_input.c
Message-Id: <20040909222542.7a30c0e4.davem@davemloft.net>
In-Reply-To: <20040910033055.GA26790@gondor.apana.org.au>
References: <20040909111233.GA3987@steel.home>
	<20040910033055.GA26790@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004 13:30:55 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Thu, Sep 09, 2004 at 11:12:33AM +0000, Alex Riesen wrote:
> > The box froze after being left for some time (some 10 hours) unattended.
> > The only thing in I could find in logs was:
> > 
> > Sep  8 22:30:18 steel kernel: KERNEL: assertion ((int)tcp_get_pcount(&tp->lost_out) >= 0) failed at net/ipv4/tcp_input.c (2422)
> > Sep  8 22:30:18 steel kernel: Leak l=4294967295 4
> 
> Looks like the factor isn't set early enough.  Can you please check
> that you had the changeset titled
> 
> [TCP]: Make sure SKB tso factor is setup early enough.
> 
> from davem?
> 
> If you did, then please apply the following patch and tell us what
> the resulting messages.

Herbert did you see my division fix I made today for
tso_factor calculation?  I was dividing by the TSO mss
instead of the normal one :-)

I think that is the cause of these problems.  It was
definitely the cause of a BUG() trap hit in tcp_transmit_skb()
that someone else reported in the past day.
