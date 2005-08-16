Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbVHPEiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbVHPEiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 00:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVHPEiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 00:38:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15791 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932601AbVHPEit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 00:38:49 -0400
Date: Mon, 15 Aug 2005 21:38:43 -0700
From: Chris Wright <chrisw@osdl.org>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zwane@arm.linux.org.uk
Subject: Re: [PATCH 2/6] i386 virtualization - Remove some dead debugging code
Message-ID: <20050816043843.GT7762@shell0.pdx.osdl.net>
References: <200508152259.j7FMx9qZ005312@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508152259.j7FMx9qZ005312@zach-dev.vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* zach@vmware.com (zach@vmware.com) wrote:
> This code is quite dead.  Release_thread is always guaranteed that the mm has
> already been released, thus dead_task->mm will always be NULL.
> 
> Signed-off-by: Zachary Amsden <zach@vmware.com>
> Index: linux-2.6.13/arch/i386/kernel/process.c
> ===================================================================
> --- linux-2.6.13.orig/arch/i386/kernel/process.c	2005-08-15 10:46:18.000000000 -0700
> +++ linux-2.6.13/arch/i386/kernel/process.c	2005-08-15 10:48:51.000000000 -0700
> @@ -421,17 +421,7 @@
>  
>  void release_thread(struct task_struct *dead_task)
>  {
> -	if (dead_task->mm) {
> -		// temporary debugging check
> -		if (dead_task->mm->context.size) {
> -			printk("WARNING: dead process %8s still has LDT? <%p/%d>\n",
> -					dead_task->comm,
> -					dead_task->mm->context.ldt,
> -					dead_task->mm->context.size);
> -			BUG();
> -		}
> -	}
> -
> +	BUG_ON(dead_task->mm);

This BUG_ON() has different semantics than old dead one.  Is there a
point?  exit_mm() has already reset this to NULL, no?

>  	release_vm86_irqs(dead_task);
>  }
