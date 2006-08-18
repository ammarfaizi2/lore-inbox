Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWHRXV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWHRXV1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbWHRXV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:21:26 -0400
Received: from ns1.coraid.com ([65.14.39.133]:51563 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1751584AbWHRXV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:21:26 -0400
Date: Fri, 18 Aug 2006 19:04:58 -0400
From: "Ed L. Cashin" <ecashin@coraid.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.18-rc4] aoe [07/13]: jumbo frame support 2 of 2
Message-ID: <20060818230457.GT29988@coraid.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com> <89aa13bbceac9f7580cfa29d3a05a236@coraid.com> <1155941912.31543.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155941912.31543.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 11:58:32PM +0100, Alan Cox wrote:
> Ar Gwe, 2006-08-18 am 13:39 -0400, ysgrifennodd Ed L. Cashin:
...
> > @@ -28,7 +28,7 @@ new_skb(ulong len)
> >  		skb->protocol = __constant_htons(ETH_P_AOE);
> >  		skb->priority = 0;
> >  		skb_put(skb, len);
> > -		memset(skb->head, 0, len);
> > +		memset(skb->head, 0, ETH_ZLEN);
> 
> You realise the tail of a short packet is cleared by the network drivers
> either in software or hardware ?

Yes, I think that the patch author is used to doing ETH_ZLEN because
of a bug in the e1000 driver where the short packets weren't getting
padded.  I don't think I ever heard of a resolution to that issue, but
I could change it back to "len" here.

-- 
  Ed L Cashin <ecashin@coraid.com>
