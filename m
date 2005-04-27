Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVD0Lyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVD0Lyz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 07:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVD0Lyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 07:54:55 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:24082 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261481AbVD0Lyx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 07:54:53 -0400
Date: Wed, 27 Apr 2005 21:54:14 +1000
To: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Patrick McHardy <kaber@trash.net>, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, Yair@arx.com,
       linux-kernel@vger.kernel.org
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
Message-ID: <20050427115414.GA22562@gondor.apana.org.au>
References: <426D8672.1030001@trash.net> <20050426003925.GA13650@gondor.apana.org.au> <426E3F67.8090006@trash.net> <20050426232857.GA18358@gondor.apana.org.au> <426EE350.1070902@trash.net> <20050427010730.GA18919@gondor.apana.org.au> <426F68C5.4010109@trash.net> <20050427103056.GB22099@gondor.apana.org.au> <Pine.LNX.4.58.0504271237350.4795@blackhole.kfki.hu> <20050427113542.GB22433@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427113542.GB22433@gondor.apana.org.au>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 09:35:42PM +1000, herbert wrote:
>
> > Besides the REJECT target, TARPIT in patch-o-matic-ng also generates
> > packets with non-local source addresses. We cannot assume that REJECT is
> > the only one which can create such packets.
> 
> Any reason why it can't be fed through the FORWARD chain as opposed
> to LOCAL_OUT? In general, is there anything that's generating packets
> with foreign addresses that can't be fed through FORWARD?

Here is another reason why these packets should go through FORWARD.
They were generated in response to packets in INPUT/FORWARD/OUTPUT.
The original packet has not undergone SNAT in any of these cases.

However, if we feed the response packet through LOCAL_OUT it will
be subject to DNAT.  This creates a NAT asymmetry and we may end
up with the wrong destination address.

By pushing it through FORWARD it will only undergo SNAT which is
correct since the original packet would have undergone DNAT.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
