Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVAaFmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVAaFmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 00:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVAaFmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 00:42:37 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:39182 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261925AbVAaFmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 00:42:33 -0500
Date: Mon, 31 Jan 2005 16:40:52 +1100
To: "David S. Miller" <davem@davemloft.net>
Cc: Patrick McHardy <kaber@trash.net>, yoshfuji@linux-ipv6.org,
       rmk+lkml@arm.linux.org.uk, Robert.Olsson@data.slu.se, akpm@osdl.org,
       torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050131054052.GA20227@gondor.apana.org.au>
References: <41FD2043.3070303@trash.net> <E1CvSuS-00056x-00@gondolin.me.apana.org.au> <20050131.134559.125426676.yoshfuji@linux-ipv6.org> <41FDBB78.2050403@trash.net> <20050130211150.464d1c62.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050130211150.464d1c62.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 09:11:50PM -0800, David S. Miller wrote:
> On Mon, 31 Jan 2005 06:00:40 +0100
> Patrick McHardy <kaber@trash.net> wrote:
> 
> > We don't need this for IPv6 yet. Once we get nf_conntrack in we
> > might need this, but its IPv6 fragment handling is different from
> > ip_conntrack, I need to check first.
> 
> Right, ipv6 netfilter cannot create this situation yet.

Not through netfilter but I'm not convinced that other paths
won't do this.

For instance, what about ipv6_frag_rcv -> esp6_input -> ... -> ip6_fragment?
That would seem to be a potential path for a non-NULL dst to survive
through to ip6_fragment, no?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
