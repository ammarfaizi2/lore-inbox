Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269923AbUJTGmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269923AbUJTGmh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 02:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269904AbUJSXMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:12:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6122 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S270069AbUJSWpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:45:16 -0400
Subject: Re: tun.c patch to fix "smp_processor_id() in preemptible code"
From: Lee Revell <rlrevell@joe-job.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: herbert@gondor.apana.org.au, vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Network Development <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, maxk@qualcomm.com,
       irda-users@lists.sourceforge.net
In-Reply-To: <20041019153308.488d34c1.davem@davemloft.net>
References: <E1CK1e6-0004F3-00@gondolin.me.apana.org.au>
	 <1098222676.23367.18.camel@krustophenia.net>
	 <20041019215401.GA16427@gondor.apana.org.au>
	 <1098223857.23367.35.camel@krustophenia.net>
	 <20041019153308.488d34c1.davem@davemloft.net>
Content-Type: text/plain
Message-Id: <1098225729.23628.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 18:42:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 18:33, David S. Miller wrote:
> On Tue, 19 Oct 2004 18:10:58 -0400
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> >   /*
> >    * Since receiving is always initiated from a tasklet (in iucv.c),
> >    * we must use netif_rx_ni() instead of netif_rx()
> >    */
> > 
> > This implies that the author thought it was a matter of correctness to
> > use netif_rx_ni vs. netif_rx.  But it looks like the only difference is
> > that the former sacrifices preempt-safety for performance.
> 
> You can't really delete netif_rx_ni(), so if there is a preemptability
> issue, just add the necessary preemption protection around the softirq
> checks.
> 

Why not?  AIUI the only valid reason to use preempt_disable/enable is in
the case of per-CPU data.  This is not "real" per-CPU data, it's a
performance hack.  Therefore it would be incorrect to add the preemption
protection, the fix is not to manually call do_softirq but to let the
softirq run by the normal mechanism.

Am I missing something?

Lee

