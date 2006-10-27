Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWJ0FHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWJ0FHJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 01:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWJ0FHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 01:07:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52661 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932287AbWJ0FHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 01:07:08 -0400
Date: Thu, 26 Oct 2006 22:07:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 update4] drivers: add LCD support
Message-Id: <20061026220703.37182521.akpm@osdl.org>
In-Reply-To: <20061026174858.b7c5eab1.maxextreme@gmail.com>
References: <20061026174858.b7c5eab1.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2006 17:48:58 +0000
Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:

>  
> +DECLARE_MUTEX(cfag12864bfb_sem);

Mutexes are preferred - please only use semaphores if their counting
feature is required.

This lock can have static scope.

> +struct page *cfag12864bfb_vma_nopage(struct vm_area_struct *vma,
> +	unsigned long address, int *type)

This function can have static scope.

> +{
> +	struct page *page;
> +	down(&cfag12864bfb_sem);
> +
> +	page = virt_to_page(cfag12864b_buffer);
> +	get_page(page);
> +
> +	if(type)
> +		*type = VM_FAULT_MINOR;
> +
> +	up(&cfag12864bfb_sem);
> +	return page;
> +}

What's the semaphore actually needed for?

