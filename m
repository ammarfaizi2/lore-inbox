Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWE3Bbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWE3Bbu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWE3Bbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:31:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5569 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932113AbWE3Bbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:31:42 -0400
Date: Mon, 29 May 2006 18:35:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 50/61] lock validator: special locking: hrtimer.c
Message-Id: <20060529183556.602b1570.akpm@osdl.org>
In-Reply-To: <20060529212709.GX3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212709.GX3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:27:09 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> teach special (recursive) locking code to the lock validator. Has no
> effect on non-lockdep kernels.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  kernel/hrtimer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux/kernel/hrtimer.c
> ===================================================================
> --- linux.orig/kernel/hrtimer.c
> +++ linux/kernel/hrtimer.c
> @@ -786,7 +786,7 @@ static void __devinit init_hrtimers_cpu(
>  	int i;
>  
>  	for (i = 0; i < MAX_HRTIMER_BASES; i++, base++)
> -		spin_lock_init(&base->lock);
> +		spin_lock_init_static(&base->lock);
>  }
>  

Perhaps the validator core's implementation of spin_lock_init() could look
at the address and work out if it's within the static storage sections.

