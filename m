Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932659AbWCQNvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbWCQNvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWCQNvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:51:07 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:53445 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932659AbWCQNvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:51:05 -0500
Message-ID: <441ABEDD.4070003@de.ibm.com>
Date: Fri, 17 Mar 2006 14:51:25 +0100
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [patch] mspec - special memory driver and do_no_pfn handler
References: <yq0k6auuy5n.fsf@jaguar.mkp.net>
In-Reply-To: <yq0k6auuy5n.fsf@jaguar.mkp.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> Index: linux-2.6/include/linux/mm.h
> ===================================================================
> --- linux-2.6.orig/include/linux/mm.h
> +++ linux-2.6/include/linux/mm.h
> @@ -199,6 +199,7 @@
>  	void (*open)(struct vm_area_struct * area);
>  	void (*close)(struct vm_area_struct * area);
>  	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int *type);
> +	long (*nopfn)(struct vm_area_struct * area, unsigned long address, int *type);
>  	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
>  #ifdef CONFIG_NUMA
>  	int (*set_policy)(struct vm_area_struct *vma, struct mempolicy *new);
If you use address as parameter to nopfn, it won't work with highmem
on 32bit systems. Alternative would be to use (unsigned long) phys. page
frame number.

Your work in memory.c looks like the right thing to do.
Afaics it will work for xip as well once I figure how to
do COW. Cool stuff :-).

Carsten
