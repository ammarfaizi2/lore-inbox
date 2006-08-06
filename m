Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWHFXtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWHFXtb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 19:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWHFXtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 19:49:31 -0400
Received: from pop-canoe.atl.sa.earthlink.net ([207.69.195.66]:57266 "EHLO
	pop-canoe.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1750763AbWHFXta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 19:49:30 -0400
Subject: Re: [PATCH] pSeries hvsi char driver null pointer deref
From: Hollis Blanchard <hollis@alumni.cmu.edu>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060803201300.GB10638@austin.ibm.com>
References: <20060803201300.GB10638@austin.ibm.com>
Content-Type: text/plain
Date: Sun, 06 Aug 2006 18:49:22 -0500
Message-Id: <1154908162.27074.2.camel@diesel>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 15:13 -0500, Linas Vepstas wrote:
> Andrew, 
> Please apply.
> 
> Under certain rare circumstances, it appears that there can be
> be a NULL-pointer deref when a user fiddles with terminal
> emeulation programs while outpu is being sent to the console.
> This patch checks for and avoids a NULL-pointer deref.
> 
> Signed-off-by: Hollis Blanchard <hollisbl@austin.ibm.com>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

That email address is incorrect.

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

> ----
>  drivers/char/hvsi.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.18-rc3-git1/drivers/char/hvsi.c
> ===================================================================
> --- linux-2.6.18-rc3-git1.orig/drivers/char/hvsi.c	2006-08-03 14:50:00.000000000 -0500
> +++ linux-2.6.18-rc3-git1/drivers/char/hvsi.c	2006-08-03 14:51:46.000000000 -0500
> @@ -311,7 +311,8 @@ static void hvsi_recv_control(struct hvs
>  				/* CD went away; no more connection */
>  				pr_debug("hvsi%i: CD dropped\n", hp->index);
>  				hp->mctrl &= TIOCM_CD;
> -				if (!(hp->tty->flags & CLOCAL))
> +				/* If userland hasn't done an open(2) yet, hp->tty is NULL. */
> +				if (hp->tty && !(hp->tty->flags & CLOCAL))
>  					*to_hangup = hp->tty;
>  			}
>  			break;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

