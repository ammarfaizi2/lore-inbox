Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267486AbUHEEoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267486AbUHEEoh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUHEEoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:44:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:4262 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267486AbUHEEo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:44:28 -0400
Date: Wed, 4 Aug 2004 21:42:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, jbarnes@engr.sgi.com
Subject: Re: [PATCH] don't pass mem_map into init functions
Message-Id: <20040804214250.2de3dd81.akpm@osdl.org>
In-Reply-To: <1091581282.27397.6676.camel@nighthawk>
References: <1091581282.27397.6676.camel@nighthawk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
> When using CONFIG_NONLINEAR, a zone's mem_map isn't contiguous, and
>  isn't allocated in the same place.  This means that nonlinear doesn't
>  really have a mem_map[] to pass into free_area_init_node() or 
>  memmap_init_zone() which makes any sense.  
> 
>  So, this patch removes the 'struct page *mem_map' argument to both of
>  those functions.  All non-NUMA architectures just pass a NULL in there,
>  which is ignored.  The solution on the NUMA arches is to pass the
>  mem_map in via the pgdat, which works just fine. 
> 
>  To replace the removed arguments, a call to pfn_to_page(node_start_pfn)
>  is made.  This is valid because all of the pfn_to_page() implementations
>  rely only on the pgdats, which are already set up at this time.  Plus,
>  the pfn_to_page() method should work for any future nonlinear-type
>  code.  
> 
>  Finally, the patch creates a function: node_alloc_mem_map(), which I
>  plan to effectively #ifdef out for nonlinear at some future date.  

You wanna take a shot at fixing this up please?

arch/sparc64/mm/init.c: In function `paging_init':
arch/sparc64/mm/init.c:1589: warning: passing arg 4 of `free_area_init_node' makes integer from pointer without a cast
arch/sparc64/mm/init.c:1589: warning: passing arg 5 of `free_area_init_node' makes pointer from integer without a cast
arch/sparc64/mm/init.c:1589: error: too many arguments to function `free_area_init_node'

