Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269940AbUJTK0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269940AbUJTK0v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269941AbUJSWTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:19:37 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:51685 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269946AbUJSWK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:10:58 -0400
Subject: Re: tun.c patch to fix "smp_processor_id() in preemptible code"
From: Lee Revell <rlrevell@joe-job.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Network Development <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, maxk@qualcomm.com,
       irda-users@lists.sourceforge.net
In-Reply-To: <20041019215401.GA16427@gondor.apana.org.au>
References: <E1CK1e6-0004F3-00@gondolin.me.apana.org.au>
	 <1098222676.23367.18.camel@krustophenia.net>
	 <20041019215401.GA16427@gondor.apana.org.au>
Content-Type: text/plain
Message-Id: <1098223857.23367.35.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 18:10:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 17:54, Herbert Xu wrote:
> On Tue, Oct 19, 2004 at 05:51:17PM -0400, Lee Revell wrote:
> > 
> > Ok, here is the correct patch.  If this is really just a matter of
> > performance, and not required for correctness, disabling preemption is
> > broken, right?
> 
> No if you're doing this then you should get rid of netif_rx_ni()
> altogether.  But before you do that please ask all the people who
> call it.

There are not a lot of them:

drivers/s390/net/ctcmain.c
drivers/s390/net/netiucv.c
drivers/net/irda/vlsi_ir.c
drivers/net/tun.c

>From netiuvc.c:

  /*
   * Since receiving is always initiated from a tasklet (in iucv.c),
   * we must use netif_rx_ni() instead of netif_rx()
   */

This implies that the author thought it was a matter of correctness to
use netif_rx_ni vs. netif_rx.  But it looks like the only difference is
that the former sacrifices preempt-safety for performance.

I could not find maintainers for the two s390 drivers, or a specific
maintainer for vlsi_ir.

Lee

