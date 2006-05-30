Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751553AbWE3BaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbWE3BaE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWE3B3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:29:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22464 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751553AbWE3B3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:29:35 -0400
Date: Mon, 29 May 2006 18:33:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       Nathan Scott <nathans@sgi.com>
Subject: Re: [patch 11/61] lock validator: lockdep: small xfs init_rwsem()
 cleanup
Message-Id: <20060529183341.58d75aec.akpm@osdl.org>
In-Reply-To: <20060529212359.GK3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212359.GK3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:23:59 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> nit_rwsem() has no return value. This is not a problem if init_rwsem()
> is a function, but it's a problem if it's a do { ... } while (0) macro.
> (which lockdep introduces)
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  fs/xfs/linux-2.6/mrlock.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux/fs/xfs/linux-2.6/mrlock.h
> ===================================================================
> --- linux.orig/fs/xfs/linux-2.6/mrlock.h
> +++ linux/fs/xfs/linux-2.6/mrlock.h
> @@ -28,7 +28,7 @@ typedef struct {
>  } mrlock_t;
>  
>  #define mrinit(mrp, name)	\
> -	( (mrp)->mr_writer = 0, init_rwsem(&(mrp)->mr_lock) )
> +	do { (mrp)->mr_writer = 0; init_rwsem(&(mrp)->mr_lock); } while (0)
>  #define mrlock_init(mrp, t,n,s)	mrinit(mrp, n)
>  #define mrfree(mrp)		do { } while (0)
>  #define mraccess(mrp)		mraccessf(mrp, 0)

I'll queue this for mainline, via the XFS tree.
