Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVFPW7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVFPW7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVFPW4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:56:41 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:35335 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261876AbVFPWxX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:53:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eSdASbjHJkOXT24UeDk3dgA4WUvRPrj81X4eRh6BsRccUEwFsvf5eqjU4DIahYjjRxVtWMkgCDd0FQRVcFCsHj6mghgI8IqaSiReXrY2laagjSL8R1DqYj1YXRLKqVlWX/kICvsqPcawDNo6D2LV4PNDz8hpepLzWpwU0xUEb4k=
Message-ID: <9a8748490506161553409d2851@mail.gmail.com>
Date: Fri, 17 Jun 2005 00:53:23 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: Shouldn't we be using alloc_skb/kfree_skb in net/ipv4/netfilter/ipt_recent.c::ip_recent_ctrl ?
Cc: juhl-lkml@dif.dk, linux-kernel@vger.kernel.org, laforge@netfilter.org,
       sfrost@snowman.net
In-Reply-To: <20050616.154838.41634341.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0506170025140.2477@dragon.hyggekrogen.localhost>
	 <20050616.154838.41634341.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/05, David S. Miller <davem@davemloft.net> wrote:
> From: Jesper Juhl <juhl-lkml@dif.dk>
> Date: Fri, 17 Jun 2005 00:36:04 +0200 (CEST)
> 
> > I was just grep'ing through the source looking for places where skb's
> > might be freed by plain kfree() and, amongst other things, I noticed
> > net/ipv4/netfilter/ipt_recent.c::ip_recent_ctrl, where a struct sk_buff*
> > is defined and then storage for it is allocated with kmalloc() and freed
> > with kfree(), and I'm wondering if we shouldn't be using
> > alloc_skb/kfree_skb instead (as pr the patch below)? Or is there some good
> > reason for doing it the way it's currently done?
> 
> It's using it to send a dummy packet to the patch function.
> It is gross, but it does work because it allocated it's own
> private data area to skb->nh.iph.
> 
> Just leave it alone for now, ipt_recent is gross and full of many
> errors and bug, and thus stands to have a rewrite. Patrick McHardy
> said he will try to do that.
> 
Ok. I was just about to send the patch off to Andrew based on
Stephen's reply, but I'll hold off on that then.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
