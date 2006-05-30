Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWE3Bci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWE3Bci (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWE3Bch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:32:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21441 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932116AbWE3BcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:32:23 -0400
Date: Mon, 29 May 2006 18:36:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       "David S. Miller" <davem@davemloft.net>,
       Patrick McHardy <kaber@trash.net>
Subject: Re: [patch 59/61] lock validator: special locking: xfrm
Message-Id: <20060529183632.67f6b0bd.akpm@osdl.org>
In-Reply-To: <20060529212751.GG3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212751.GG3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:27:51 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> teach special (non-nested) unlocking code to the lock validator. Has no
> effect on non-lockdep kernels.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  net/xfrm/xfrm_policy.c |    2 +-
>  net/xfrm/xfrm_state.c  |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux/net/xfrm/xfrm_policy.c
> ===================================================================
> --- linux.orig/net/xfrm/xfrm_policy.c
> +++ linux/net/xfrm/xfrm_policy.c
> @@ -1308,7 +1308,7 @@ static struct xfrm_policy_afinfo *xfrm_p
>  	afinfo = xfrm_policy_afinfo[family];
>  	if (likely(afinfo != NULL))
>  		read_lock(&afinfo->lock);
> -	read_unlock(&xfrm_policy_afinfo_lock);
> +	read_unlock_non_nested(&xfrm_policy_afinfo_lock);
>  	return afinfo;
>  }
>  
> Index: linux/net/xfrm/xfrm_state.c
> ===================================================================
> --- linux.orig/net/xfrm/xfrm_state.c
> +++ linux/net/xfrm/xfrm_state.c
> @@ -1105,7 +1105,7 @@ static struct xfrm_state_afinfo *xfrm_st
>  	afinfo = xfrm_state_afinfo[family];
>  	if (likely(afinfo != NULL))
>  		read_lock(&afinfo->lock);
> -	read_unlock(&xfrm_state_afinfo_lock);
> +	read_unlock_non_nested(&xfrm_state_afinfo_lock);
>  	return afinfo;
>  }
>  

I got a bunch of rejects here due to changes in git-net.patch.  Please
verify the result.  It could well be wrong (the changes in there are odd).

