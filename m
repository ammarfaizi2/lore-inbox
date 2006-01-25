Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWAYHPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWAYHPg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 02:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWAYHPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 02:15:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49866 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750755AbWAYHPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 02:15:35 -0500
Date: Tue, 24 Jan 2006 23:15:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
Cc: ebiederm@xmission.com, ak@suse.de, vgoyal@in.ibm.com,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH 3/5] stack overflow safe kdump (2.6.16-rc1-i386) - fault
Message-Id: <20060124231510.35eabe15.akpm@osdl.org>
In-Reply-To: <1138172000.2370.68.camel@localhost.localdomain>
References: <1138172000.2370.68.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> wrote:
>
> When we have a bloated stack it is likely that it ends up making an
> invalid memory access that in turn causes a page fault. Take this case
> into account in the page fault code.
> 
> +	if (!virt_addr_valid(tsk)) {

Is virt_addr_valid() a sufficiently strong test here?  One could probe the
address to see if it generates a fault, like the __get_user() in
kmem_cache_create().


> +		printk("do_page_fault: Discarding invalid 'current' struct task_struct * = 0x%p\n", tsk);
> +		printk("do_page_fault: Discarding invalid current->mm struct mm_struct * = 0x%p\n", mm);

Try to make the code look nice in an 80-col window please.
