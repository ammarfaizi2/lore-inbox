Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTLARvd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 12:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTLARvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 12:51:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54546 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263806AbTLARvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 12:51:32 -0500
Date: Mon, 1 Dec 2003 17:51:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.23 *_task_struct() observations ...
Message-ID: <20031201175128.B13621@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20031201172620.GA312@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031201172620.GA312@MAIL.13thfloor.at>; from herbert@13thfloor.at on Mon, Dec 01, 2003 at 06:26:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 06:26:20PM +0100, Herbert Poetzl wrote:
> just wanted to get an opinion on the following ...
> 
> include/asm-i386/processor.h  defines ...
> 
>   #define alloc_task_struct() ((struct task_struct *) \
> 				__get_free_pages(GFP_KERNEL,1))
>   #define free_task_struct(p)  free_pages((unsigned long) (p), 1)
>   #define get_task_struct(tsk) atomic_inc(&virt_to_page(tsk)->count)
> 
> now there seems to be no put_task_struct(), but
> there are some examples where get/free is used 
> where I would expect a put_* ...

put_* is free_*.  The reference count for the task struct is the page
count (virt_to_page(tsk)->count).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
