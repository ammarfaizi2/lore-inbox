Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270556AbUJTUmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270556AbUJTUmY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270544AbUJTUcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:32:17 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:54200 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S270530AbUJTU1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:27:00 -0400
Subject: Re: [PATCH] Make netif_rx_ni preempt-safe
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       linux-kernel@gondor.apana.org.au, maxk@qualcomm.com,
       irda-users@lists.sourceforge.net,
       Linux Network Development <netdev@oss.sgi.com>,
       Alain Schroeder <alain@parkautomat.net>
In-Reply-To: <200410202256.56636.vda@port.imtp.ilyichevsk.odessa.ua>
References: <1098230132.23628.28.camel@krustophenia.net>
	 <200410202214.31791.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1098302001.2268.5.camel@krustophenia.net>
	 <200410202256.56636.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1098303951.2268.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 16:25:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 15:56, Denis Vlasenko wrote:
> > OK, third try.
> > 
> > Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
> > 
> > --- include/linux/netdevice.h~	2004-10-20 15:51:00.000000000 -0400
> > +++ include/linux/netdevice.h	2004-10-20 15:51:54.000000000 -0400
> > @@ -694,11 +694,14 @@
> >  /* Post buffer to the network code from _non interrupt_ context.
> >   * see net/core/dev.c for netif_rx description.
> >   */
> > -static inline int netif_rx_ni(struct sk_buff *skb)
> > +static int netif_rx_ni(struct sk_buff *skb)
> 
> non-inline functions must not live in .h files

Where do you suggest we put it?

Lee

