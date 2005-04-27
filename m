Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVD0MFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVD0MFW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 08:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVD0MFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 08:05:21 -0400
Received: from [62.206.217.67] ([62.206.217.67]:52458 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261515AbVD0MFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 08:05:17 -0400
Message-ID: <426F7FF2.4070506@trash.net>
Date: Wed, 27 Apr 2005 14:05:06 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, Yair@arx.com,
       linux-kernel@vger.kernel.org
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
References: <426D8672.1030001@trash.net> <20050426003925.GA13650@gondor.apana.org.au> <426E3F67.8090006@trash.net> <20050426232857.GA18358@gondor.apana.org.au> <426EE350.1070902@trash.net> <20050427010730.GA18919@gondor.apana.org.au> <426F68C5.4010109@trash.net> <20050427103056.GB22099@gondor.apana.org.au> <Pine.LNX.4.58.0504271237350.4795@blackhole.kfki.hu> <20050427113542.GB22433@gondor.apana.org.au> <20050427115414.GA22562@gondor.apana.org.au>
In-Reply-To: <20050427115414.GA22562@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Here is another reason why these packets should go through FORWARD.
> They were generated in response to packets in INPUT/FORWARD/OUTPUT.
> The original packet has not undergone SNAT in any of these cases.
> 
> However, if we feed the response packet through LOCAL_OUT it will
> be subject to DNAT.  This creates a NAT asymmetry and we may end
> up with the wrong destination address.
> 
> By pushing it through FORWARD it will only undergo SNAT which is
> correct since the original packet would have undergone DNAT.

This is only a problem since the recent NAT changes, but I agree
that we should fix it by moving these packets to FORWARD.

Regards
Patrick
