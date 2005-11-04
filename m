Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbVKDXMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbVKDXMv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbVKDXMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:12:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50381 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750978AbVKDXMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:12:50 -0500
Date: Fri, 4 Nov 2005 15:12:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>, David Woodhouse <dwmw2@infradead.org>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, dwmw2@infradead.org,
       linux-mtd@lists.infradead.org
Subject: Re: [patch] collie: fixup mtd a bit
Message-Id: <20051104151239.4a39a529.akpm@osdl.org>
In-Reply-To: <20051101233320.GA31263@elf.ucw.cz>
References: <20051101233320.GA31263@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Get collie mtd support closer to working/clean state.
> 

This patch throws a screen-sized reject due to conflicting changes in
dwmw2's MTD tree.  I'd suggest that you rework the patch and send it in via
David (who needs to get a wiggle on if he wants his stuff in 2.6.15).

>  	default:
> -		printk("Waiting for chip\n");
> -
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		add_wait_queue(&chip->wq, &wait);
>  
>  		spin_unlock_bh(chip->mutex);
>  
> -		schedule();
> +		udelay(1);
> +
> +		set_current_state(TASK_RUNNING);
>  		remove_wait_queue(&chip->wq, &wait);
>  
>  		if(signal_pending(current))
> @@ -255,7 +256,7 @@ retry:

If you're going to do this then you should remove all that now-pointless
waitqueue and task-state handling.
