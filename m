Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267679AbUJTAMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267679AbUJTAMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270215AbUJTACZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:02:25 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:62987 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S268076AbUJTAA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:00:26 -0400
Date: Wed, 20 Oct 2004 10:00:09 +1000
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@gondor.apana.org.au,
       maxk@qualcomm.com, irda-users@lists.sourceforge.net,
       Linux Network Development <netdev@oss.sgi.com>,
       Alain Schroeder <alain@parkautomat.net>
Subject: Re: [PATCH] Make netif_rx_ni preempt-safe
Message-ID: <20041020000009.GA17246@gondor.apana.org.au>
References: <1098230132.23628.28.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098230132.23628.28.camel@krustophenia.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 07:55:33PM -0400, Lee Revell wrote:
> 
> --- include/linux/netdevice.h~	2004-10-19 18:50:18.000000000 -0400
> +++ include/linux/netdevice.h	2004-10-19 18:51:01.000000000 -0400
> @@ -696,9 +696,11 @@
>   */
>  static inline int netif_rx_ni(struct sk_buff *skb)
>  {
> +       preempt_disable();
>         int err = netif_rx(skb);

This is broken on older compilers.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
