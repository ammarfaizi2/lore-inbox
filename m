Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbTKTCbs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 21:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbTKTCbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 21:31:48 -0500
Received: from c-24-6-236-77.client.comcast.net ([24.6.236.77]:9435 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264197AbTKTCbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 21:31:47 -0500
Date: Wed, 19 Nov 2003 18:24:51 -0500
From: Christopher Li <lkml@chrisli.org>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@24x7linux.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031119232451.GB20840@64m.dyndns.org>
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar> <20031120002119.GA7875@localhost> <20031119170233.2619ba81.akpm@osdl.org> <20031120011209.GZ22764@holomorphy.com> <20031119175803.65d7dc99.akpm@osdl.org> <20031120021258.GB22764@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120021258.GB22764@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 06:12:58PM -0800, William Lee Irwin III wrote:
> I just realized this can all be done in one line by setting the initial
> value of ret to VM_FAULT_MINOR in do_no_page(). The ->nopage() methods
> not updated will give off compiler warnings and since they think their
> third arguments are ordinary integers, they won't update the referenced
> content, and the initializer of VM_FAULT_MINOR then comes into play.

Yes, that is a good idea.

Chris

> 
> 
> -- wli
> 
> 
> diff -prauN mm4-2.6.0-test9-1/mm/memory.c mm4-2.6.0-test9-default-2/mm/memory.c
> --- mm4-2.6.0-test9-1/mm/memory.c	2003-11-19 00:07:15.000000000 -0800
> +++ mm4-2.6.0-test9-default-2/mm/memory.c	2003-11-19 18:08:49.000000000 -0800
> @@ -1424,7 +1424,7 @@ do_no_page(struct mm_struct *mm, struct 
>  	pte_t entry;
>  	struct pte_chain *pte_chain;
>  	int sequence = 0;
> -	int ret;
> +	int ret = VM_FAULT_MINOR;
>  
>  	if (!vma->vm_ops || !vma->vm_ops->nopage)
>  		return do_anonymous_page(mm, vma, page_table,
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
