Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWCQN7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWCQN7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbWCQN73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:59:29 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:16362 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932720AbWCQN72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:59:28 -0500
Message-ID: <441AC06E.1090909@sgi.com>
Date: Fri, 17 Mar 2006 14:58:06 +0100
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060223)
MIME-Version: 1.0
To: carsteno@de.ibm.com
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [patch] mspec - special memory driver and do_no_pfn handler
References: <yq0k6auuy5n.fsf@jaguar.mkp.net> <441ABEDD.4070003@de.ibm.com>
In-Reply-To: <441ABEDD.4070003@de.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Otte wrote:
> Jes Sorensen wrote:
>> Index: linux-2.6/include/linux/mm.h
>> ===================================================================
>> --- linux-2.6.orig/include/linux/mm.h
>> +++ linux-2.6/include/linux/mm.h
>> @@ -199,6 +199,7 @@
>>  	void (*open)(struct vm_area_struct * area);
>>  	void (*close)(struct vm_area_struct * area);
>>  	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int *type);
>> +	long (*nopfn)(struct vm_area_struct * area, unsigned long address, int *type);
>>  	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
>>  #ifdef CONFIG_NUMA
>>  	int (*set_policy)(struct vm_area_struct *vma, struct mempolicy *new);
> If you use address as parameter to nopfn, it won't work with highmem
> on 32bit systems. Alternative would be to use (unsigned long) phys. page
> frame number.

Hi Carsten,

The address comes from handle_pte_fault() passing it to do_no_pfn()
passing it to ->nopfn(), ie. it's the faulted address, not the physical
one.

> Your work in memory.c looks like the right thing to do.
> Afaics it will work for xip as well once I figure how to
> do COW. Cool stuff :-).

:-)

Cheers,
Jes


