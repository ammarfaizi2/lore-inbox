Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270038AbUJSWsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270038AbUJSWsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270039AbUJSWnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:43:08 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:35733
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269880AbUJSWig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:38:36 -0400
Date: Tue, 19 Oct 2004 15:33:08 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: herbert@gondor.apana.org.au, vda@port.imtp.ilyichevsk.odessa.ua,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org, maxk@qualcomm.com,
       irda-users@lists.sourceforge.net
Subject: Re: tun.c patch to fix "smp_processor_id() in preemptible code"
Message-Id: <20041019153308.488d34c1.davem@davemloft.net>
In-Reply-To: <1098223857.23367.35.camel@krustophenia.net>
References: <E1CK1e6-0004F3-00@gondolin.me.apana.org.au>
	<1098222676.23367.18.camel@krustophenia.net>
	<20041019215401.GA16427@gondor.apana.org.au>
	<1098223857.23367.35.camel@krustophenia.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 18:10:58 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

>   /*
>    * Since receiving is always initiated from a tasklet (in iucv.c),
>    * we must use netif_rx_ni() instead of netif_rx()
>    */
> 
> This implies that the author thought it was a matter of correctness to
> use netif_rx_ni vs. netif_rx.  But it looks like the only difference is
> that the former sacrifices preempt-safety for performance.

You can't really delete netif_rx_ni(), so if there is a preemptability
issue, just add the necessary preemption protection around the softirq
checks.
