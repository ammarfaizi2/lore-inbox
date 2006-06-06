Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751176AbWFFABV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWFFABV (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 20:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWFFABV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 20:01:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:35793 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751176AbWFFABU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 20:01:20 -0400
Subject: Re: 2.6.17-rc5-mm2 problem ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060605114132.2f777060.akpm@osdl.org>
References: <1149525461.26170.22.camel@dyn9047017100.beaverton.ibm.com>
	 <20060605114132.2f777060.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 17:02:58 -0700
Message-Id: <1149552178.26170.31.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 11:41 -0700, Andrew Morton wrote:
> On Mon, 05 Jun 2006 09:37:40 -0700
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
> > Have you seen this on 2.6.17-rc5-mm2 before ? Could be due to my
> > patchset (fileop cleanups), but doesn't seem like it ..
> > 
> > Thanks,
> > Badari
> > 
> > Unable to handle kernel NULL pointer dereference at 0000000000000008
> > RIP:
> >  [<ffffffff80448d5f>] skb_dequeue+0x2c/0x50
> 
> It could be the LLC bug.  That thing caused untold amounts of grief.
> 
> --- devel/net/llc/llc_input.c~git-net-llc-fix	2006-06-02 11:55:38.000000000 -0700
> +++ devel-akpm/net/llc/llc_input.c	2006-06-02 11:55:38.000000000 -0700
> @@ -176,7 +176,6 @@ int llc_rcv(struct sk_buff *skb, struct 
>   		struct sk_buff *cskb = skb_clone(skb, GFP_ATOMIC);
>   		if (cskb)
>   			rcv(cskb, dev, pt, orig_dev);
> -		rcv(skb, dev, pt, orig_dev);
>  	}
>  	dest = llc_pdu_type(skb);
>  	if (unlikely(!dest || !llc_type_handlers[dest - 1]))
> _

Thanks. 2.6.17-rc5-mm3 is behaving much better, haven't seen these
issues on -mm3 with my patchset. I don't want to be the reason for
breaking -mm tree with fileop changes (I already used up my free
credits) ;)

Thanks,
Badari

