Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262922AbVCEMf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbVCEMf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 07:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVCEMf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 07:35:28 -0500
Received: from mx1.mail.ru ([194.67.23.121]:55603 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262922AbVCEMfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 07:35:03 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-mm1 (x86-abstract-discontigmem-setup.patch)
Date: Sat, 5 Mar 2005 15:35:24 +0200
User-Agent: KMail/1.6.2
Cc: Dave Hansen <haveblue@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200503051535.24372.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- 25/arch/i386/mm/discontig.c~x86-abstract-discontigmem-setup
> +++ 25-akpm/arch/i386/mm/discontig.c

> +void memory_present(int nid, unsigned long start, unsigned long end)
> +{
> +	unsigned long pfn;
> +
> +	printk(KERN_INFO "Node: %d, start_pfn: %ld, end_pfn: %ld\n",
> +			nid, start, end);
> +	printk(KERN_DEBUG "  Setting physnode_map array to node %d for pfns:\n", nid);
> +	printk(KERN_DEBUG "  ");
> +	for (pfn = start; pfn < end; pfn += PAGES_PER_ELEMENT) {
> +		physnode_map[pfn / PAGES_PER_ELEMENT] = nid;
> +		printk(KERN_DEBUG "%ld ", pfn);
		       ^^^^^^^^^^

> +	}
> +	printk(KERN_DEBUG "\n");
	       ^^^^^^^^^^
> +}

Too much KERN_DEBUG.

> --- 25/include/linux/mmzone.h~x86-abstract-discontigmem-setup
> +++ 25-akpm/include/linux/mmzone.h

> +#ifdef CONFIG_HAVE_MEMORY_PRESENT
> +void memory_present(int nid, unsigned long start, unsigned long end);
> +#else
> +static inline void memory_present(int nid, unsigned long start, unsigned long end) {}
> +#endif

> +#ifdef CONFIG_NEED_NODE_MEMMAP_SIZE
> +unsigned long __init node_memmap_size_bytes(int, unsigned long, unsigned long);
> +#endif

	#else
	static inline unsigned long node_memmap_size_bytes(...);
	#endif

Is this needed?

	Alexey
