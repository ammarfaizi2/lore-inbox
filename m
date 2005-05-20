Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVETQL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVETQL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 12:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVETQL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 12:11:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13728 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261411AbVETQLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 12:11:55 -0400
Date: Fri, 20 May 2005 07:53:05 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vasily Averin <vvs@sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] random poolsize sysctl fix
Message-ID: <20050520105305.GC21742@logos.cnet>
References: <428D7680.5040304@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428D7680.5040304@sw.ru>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vasily,

On Fri, May 20, 2005 at 09:32:48AM +0400, Vasily Averin wrote:
> Hello Marcelo,
> 
> SWSoft Linux kernel Team has discovered that your patch 
> http://linux.bkbits.net:8080/linux-2.4/gnupatch@41e2c4fetTJmVti-Xxql21xXjfbpag
> which should fix a random poolsize sysctl handler integer overflow, is 
> wrong.
> You have changed a variable definition in function proc_do_poolsize(), 
> but you had to fix an another function, poolsize_strategy()

Ouch. Shame on me.

Recent v2.4 versions aren't vulnerable, at least on i386, where copy_from_user() 
does signed overflow checking.

Patch applied, thanks.

> --- ./drivers/char/random.c.rndps	Wed Jan 19 17:09:48 2005
> +++ ./drivers/char/random.c	Fri May 20 09:09:18 2005
> @@ -1771,7 +1771,7 @@ static int change_poolsize(int poolsize)
>  static int proc_do_poolsize(ctl_table *table, int write, struct file *filp,
>  			    void *buffer, size_t *lenp)
>  {
> -	unsigned int	ret;
> +	int	ret;
>  
>  	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
>  
> @@ -1787,7 +1787,7 @@ static int poolsize_strategy(ctl_table *
>  			     void *oldval, size_t *oldlenp,
>  			     void *newval, size_t newlen, void **context)
>  {
> -	int	len;
> +	unsigned int	len;
>  	
>  	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
>  

