Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVD0UtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVD0UtA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 16:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVD0UtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 16:49:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14276 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262006AbVD0Ust (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 16:48:49 -0400
Date: Wed, 27 Apr 2005 12:28:31 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.31-pre1] rwsem-spinlock linkage error
Message-ID: <20050427152830.GB32550@logos.cnet>
References: <17006.40634.550626.473965@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17006.40634.550626.473965@alkaid.it.uu.se>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied, thanks Mikael.

On Tue, Apr 26, 2005 at 10:04:10PM +0200, Mikael Pettersson wrote:
> The
> 
> Andrew Morton:
>   o rwsem: Make rwsems use interrupt disabling spinlocks
> 
> change in 2.4.31-pre1 has a typo: one occurrence of spin_unlock() was
> changed to spin_unlock_restore() instead of spin_unlock_irqrestore()
> as was obviously the intention. Since spin_unlock_restore() doesn't
> exist, this results in linkage errors on x86_64 and other archs using
> CONFIG_RWSEM_GENERIC_SPINLOCK.
> 
> Trival fix below.
> 
> Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>
> 
> --- linux-2.4.31-pre1/lib/rwsem-spinlock.c.~1~	2005-04-26 19:12:52.000000000 +0200
> +++ linux-2.4.31-pre1/lib/rwsem-spinlock.c	2005-04-26 21:16:05.000000000 +0200
> @@ -269,7 +269,7 @@ void fastcall __up_read(struct rw_semaph
>  	if (--sem->activity==0 && !list_empty(&sem->wait_list))
>  		sem = __rwsem_wake_one_writer(sem);
>  
> -	spin_unlock_restore(&sem->wait_lock, flags);
> +	spin_unlock_irqrestore(&sem->wait_lock, flags);
>  
>  	rwsemtrace(sem,"Leaving __up_read");
>  }
