Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263972AbVBEK5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbVBEK5V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 05:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264335AbVBEK5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:57:21 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:59917 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263972AbVBEKrD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:47:03 -0500
Date: Sat, 5 Feb 2005 21:45:59 +1100
To: "David S. Miller" <davem@davemloft.net>
Cc: mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org, shemminger@osdl.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-ID: <20050205104559.GA30981@gondor.apana.org.au>
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de> <20050205052407.GA17266@gondor.apana.org.au> <20050204213813.4bd642ad.davem@davemloft.net> <20050205061110.GA18275@gondor.apana.org.au> <20050204221344.247548cb.davem@davemloft.net> <20050205064643.GA29758@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205064643.GA29758@gondor.apana.org.au>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 05:46:43PM +1100, herbert wrote:
> 
> This doesn't work because net/core/dst.c can only search based
> on dst->dev.  For the split device case, dst->dev is set to
> loopback_dev while rt6i_idev is set to the real device.

Although I still think this is a bug, I'm now starting to suspect
that there is another bug around as well.

There is probably an ifp leak which in turn leads to a split dst
leak that allows the first bug to make its mark.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
