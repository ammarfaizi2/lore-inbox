Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269780AbUJUFSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269780AbUJUFSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270629AbUJUFPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:15:53 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:26019
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S270600AbUJUFEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 01:04:33 -0400
Date: Wed, 20 Oct 2004 21:58:40 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, rlrevell@joe-job.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-kernel@gondor.apana.org.au,
       maxk@qualcomm.com, irda-users@lists.sourceforge.net, netdev@oss.sgi.com,
       alain@parkautomat.net
Subject: Re: [PATCH] Make netif_rx_ni preempt-safe
Message-Id: <20041020215840.40f0bacc.davem@davemloft.net>
In-Reply-To: <20041021003503.GA10391@gondor.apana.org.au>
References: <1098230132.23628.28.camel@krustophenia.net>
	<200410202256.56636.vda@port.imtp.ilyichevsk.odessa.ua>
	<1098303951.2268.8.camel@krustophenia.net>
	<200410202332.33583.vda@port.imtp.ilyichevsk.odessa.ua>
	<20041020171508.0e947d08.davem@davemloft.net>
	<20041021003503.GA10391@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 10:35:03 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Wed, Oct 20, 2004 at 05:15:08PM -0700, David S. Miller wrote:
> >  
> > +int netif_rx_ni(struct sk_buff *skb)
> > +{
> > +       int err = netif_rx(skb);
> > +
> > +       preempt_disable();
> > +       if (softirq_pending(smp_processor_id()))
> > +               do_softirq();
> 
> You need to move the netif_rx call inside the disable as otherwise
> you might be checking the pending flag on the wrong CPU.

Good catch, I've made that fix in my tree.

Thanks.
