Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269068AbUINAD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269068AbUINAD7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 20:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269069AbUINAD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 20:03:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31112 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269068AbUINADz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 20:03:55 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.9-rc1-mm5 bug in tcp_recvmsg?
Date: Mon, 13 Sep 2004 17:03:48 -0700
User-Agent: KMail/1.7
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040913015003.5406abae.akpm@osdl.org> <200409131654.27727.jbarnes@engr.sgi.com> <20040913165557.568cdffb.davem@davemloft.net>
In-Reply-To: <20040913165557.568cdffb.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409131703.48395.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 13, 2004 4:55 pm, David S. Miller wrote:
> On Mon, 13 Sep 2004 16:54:27 -0700
>
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > tg3.  I saw one trace that included do_poll (iirc) and another last week
> > that had sys_select in it.  I'll try to gather some more info.
>
> What you're seeing might be due to the bug fixed by this patch:

>       spin_lock(&dev->queue_lock);
>       return -1;
>      }
> -    if (ret == NETDEV_TX_LOCKED && nolock)
> +    if (ret == NETDEV_TX_LOCKED && nolock) {
> +     spin_lock(&dev->queue_lock);
>       goto collision;
> +    }
>     }
>
>     /* NETDEV_TX_BUSY - we need to requeue */

Ok, I guess that would explain why I haven't seen this in 2.6.9-rc2.  I was 
getting my backtraces confused too--I've only seen this one for this bug.  
I'll keep an eye out and report anything I see with the latest bk tree.

Thanks,
Jesse
