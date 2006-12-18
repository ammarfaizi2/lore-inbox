Return-Path: <linux-kernel-owner+w=401wt.eu-S1754605AbWLRVOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbWLRVOJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 16:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754606AbWLRVOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 16:14:09 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:52519 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605AbWLRVOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 16:14:08 -0500
Subject: Re: [PATCH] Fix sparsemem on Cell
From: Dave Hansen <haveblue@us.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, apw@shadowen.org, cbe-oss-dev@ozlabs.org,
       linuxppc-dev@ozlabs.org, linux-mm@kvack.org, mkravetz@us.ibm.com,
       hch@infradead.org, jk@ozlabs.org, linux-kernel@vger.kernel.org,
       paulus@samba.org, benh@kernel.crashing.org, gone@us.ibm.com,
       kmannth@us.ibm.com
In-Reply-To: <20061216170353.2dfa27b1.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061215165335.61D9F775@localhost.localdomain>
	 <4582D756.7090702@shadowen.org>
	 <1166203440.8105.22.camel@localhost.localdomain>
	 <20061215114536.dc5c93af.akpm@osdl.org>
	 <20061216170353.2dfa27b1.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 13:13:57 -0800
Message-Id: <1166476437.8648.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-16 at 17:03 +0900, KAMEZAWA Hiroyuki wrote:
>  /* add this memory to iomem resource */
>  static struct resource *register_memory_resource(u64 start, u64 size)
>  {
> @@ -273,10 +284,13 @@
>  		if (ret)
>  			goto error;
>  	}
> +	atomic_inc(&memory_hotadd_count);
>  
>  	/* call arch's memory hotadd */
>  	ret = arch_add_memory(nid, start, size);
>  
> +	atomic_dec(&memory_hotadd_count);

I'd be willing to be that this will work just fine.  But, I think we can
do it without any static state at all, if we just pass a runtime-or-not
flag down into the arch_add_memory() call chain.

I'll code that up so we can compare to yours.  

-- Dave

