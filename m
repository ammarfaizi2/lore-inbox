Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVFSUOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVFSUOT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 16:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVFSUOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 16:14:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61334 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261308AbVFSUON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 16:14:13 -0400
Date: Sun, 19 Jun 2005 13:13:54 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, "Rickard E. (Rik) Faith" <faith@redhat.com>,
       Rik Faith <faith@cs.unc.edu>, linux-audit@redhat.com
Subject: Re: [PATCH] Small kfree cleanup, save a local variable.
Message-ID: <20050619201354.GY9153@shell0.pdx.osdl.net>
References: <Pine.LNX.4.62.0506192129300.2832@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506192129300.2832@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jesper Juhl (juhl-lkml@dif.dk) wrote:
> Here's a patch with a small improvement to kernel/auditsc.c .
> There's no need for the local variable  struct audit_entry *e  , 
> we can just call kfree directly on container_of() .
> Patch also removes an extra space a little further down in the file.

Please Cc: linux-audit@redhat.com on audit patches.  I tend to agree
with Michael, it's optimized away, and readable as is.

thanks,
-chris

> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> ---
> 
>  kernel/auditsc.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.12-orig/kernel/auditsc.c	2005-06-17 21:48:29.000000000 +0200
> +++ linux-2.6.12/kernel/auditsc.c	2005-06-19 21:21:37.000000000 +0200
> @@ -202,8 +202,7 @@ static inline int audit_add_rule(struct 
>  
>  static void audit_free_rule(struct rcu_head *head)
>  {
> -	struct audit_entry *e = container_of(head, struct audit_entry, rcu);
> -	kfree(e);
> +	kfree(container_of(head, struct audit_entry, rcu));
>  }
>  
>  /* Note that audit_add_rule and audit_del_rule are called via
> @@ -612,7 +611,7 @@ static inline void audit_free_context(st
>  		audit_free_names(context);
>  		audit_free_aux(context);
>  		kfree(context);
> -		context  = previous;
> +		context = previous;
>  	} while (context);
>  	if (count >= 10)
>  		printk(KERN_ERR "audit: freed %d contexts\n", count);
