Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751271AbWFESli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWFESli (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 14:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWFESli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 14:41:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751271AbWFESlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 14:41:37 -0400
Date: Mon, 5 Jun 2006 11:41:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2 problem ?
Message-Id: <20060605114132.2f777060.akpm@osdl.org>
In-Reply-To: <1149525461.26170.22.camel@dyn9047017100.beaverton.ibm.com>
References: <1149525461.26170.22.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2006 09:37:40 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> Have you seen this on 2.6.17-rc5-mm2 before ? Could be due to my
> patchset (fileop cleanups), but doesn't seem like it ..
> 
> Thanks,
> Badari
> 
> Unable to handle kernel NULL pointer dereference at 0000000000000008
> RIP:
>  [<ffffffff80448d5f>] skb_dequeue+0x2c/0x50

It could be the LLC bug.  That thing caused untold amounts of grief.

--- devel/net/llc/llc_input.c~git-net-llc-fix	2006-06-02 11:55:38.000000000 -0700
+++ devel-akpm/net/llc/llc_input.c	2006-06-02 11:55:38.000000000 -0700
@@ -176,7 +176,6 @@ int llc_rcv(struct sk_buff *skb, struct 
  		struct sk_buff *cskb = skb_clone(skb, GFP_ATOMIC);
  		if (cskb)
  			rcv(cskb, dev, pt, orig_dev);
-		rcv(skb, dev, pt, orig_dev);
 	}
 	dest = llc_pdu_type(skb);
 	if (unlikely(!dest || !llc_type_handlers[dest - 1]))
_

