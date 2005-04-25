Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVDYVjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVDYVjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVDYVhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:37:02 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:30217 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261237AbVDYVe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:34:28 -0400
Date: Tue, 26 Apr 2005 07:34:00 +1000
To: Patrick McHardy <kaber@trash.net>
Cc: Yair@arx.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
Message-ID: <20050425213400.GB29288@gondor.apana.org.au>
References: <E1DQ1Ct-00055s-00@gondolin.me.apana.org.au> <426D0CB9.4060500@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426D0CB9.4060500@trash.net>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 05:28:57PM +0200, Patrick McHardy wrote:
> 
> No, ip_route_me_harder() can be called for packets with non-local
> source. ip_route_output_slow() rejects non-local source addresses,
> so the only way to use them for policy routing is by using
> ip_route_input().

You're right.  But then we can't call ip_route_output in the case
where saddr is foreign but daddr is local.  Nor can we call
ip_route_input since the output will be ip_rt_bug.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
