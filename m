Return-Path: <linux-kernel-owner+w=401wt.eu-S932896AbWLSTZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896AbWLSTZv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 14:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932910AbWLSTZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 14:25:51 -0500
Received: from mx1.cs.washington.edu ([128.208.5.52]:48181 "EHLO
	mx1.cs.washington.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932896AbWLSTZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 14:25:50 -0500
Date: Tue, 19 Dec 2006 11:25:48 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Get rid of most of the remaining k*alloc() casts.
In-Reply-To: <Pine.LNX.4.64.0612190627020.22485@localhost.localdomain>
Message-ID: <Pine.LNX.4.64N.0612191116170.19395@attu4.cs.washington.edu>
References: <Pine.LNX.4.64.0612190627020.22485@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006, Robert P. J. Day wrote:

> diff --git a/include/asm-um/thread_info.h b/include/asm-um/thread_info.h
> index 261e2f4..e43c2dd 100644
> --- a/include/asm-um/thread_info.h
> +++ b/include/asm-um/thread_info.h
> @@ -51,8 +51,7 @@ static inline struct thread_info *current_thread_info(void)
>  }
> 
>  /* thread information allocation */
> -#define alloc_thread_info(tsk) \
> -	((struct thread_info *) kmalloc(THREAD_SIZE, GFP_KERNEL))
> +#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL))
>  #define free_thread_info(ti) kfree(ti)
> 
>  #endif

This patch breaks all of usermode from the change above.

There's also no reason to avoid other cleanups in the area you're 
changing (and testing) such as moving the asterisk for pointers to the 
variable name, deleting extraneous whitespace, or changing the several 
instances in this patch where kzalloc conversion is appropriate.  If it's 
not done now, it will either be forgotten or another patch on the same 
elaborate scale as this one will need to fix it incrementally.  Given the 
high chance of typos such as the one above in broad patches like this, all 
the changes should be rolled together into one patch that is at least 
inspected before submission by the author.

		David
