Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267406AbUHWEtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267406AbUHWEtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 00:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267408AbUHWEtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 00:49:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56490 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267406AbUHWEtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 00:49:20 -0400
Date: Sun, 22 Aug 2004 21:47:46 -0700
From: "David S. Miller" <davem@redhat.com>
To: Patrick McHardy <kaber@trash.net>
Cc: herbert@gondor.apana.org.au, nuno.silva@vgertech.com,
       linux-kernel@vger.kernel.org, master@sectorb.msk.ru, netdev@oss.sgi.com
Subject: Re: 2.6.8-rc4-bk1 problem: unregister_netdevice: waiting for ppp0
 to become free. Usage count = 1
Message-Id: <20040822214746.1efb3682.davem@redhat.com>
In-Reply-To: <4128941D.9030000@trash.net>
References: <E1BynUy-0007t1-00@gondolin.me.apana.org.au>
	<4128941D.9030000@trash.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004 14:39:57 +0200
Patrick McHardy <kaber@trash.net> wrote:

> Herbert Xu wrote:
> 
> >Nuno Silva <nuno.silva@vgertech.com> wrote:
> >  
> >
> >>The problem is in the QoS code. If I start ppp whithout the 
> >>    
> >>
> >
> >OK, this appears to be due to the changeset titled
> >
> >[PKT_SCHED]: Refcount qdisc->dev for __qdisc_destroy rcu-callback
> >
> >It adds a reference to dev.
> >
> >I don't see any code that cleans up that reference when the dev goes
> >down.  So someone needs to add that similar to the code in net/core/dst.c.
> >
> >Patrick, could you please have a look at this?
> >  
> The reference is dropped in __qdisc_destroy. The problem lies in the CBQ
> qdisc, it doesn't destroy the root-class and leaks the inner qdisc. These
> two patches for 2.4 and 2.6 fix the problem.

Awesome, good detective work guys.

Patch applied, thanks.
